# AIFFELTHON - PI부엔 프로젝트 


"**PI부엔**"은 피부 문제로 고민하는 많은 사람들을 위해 설계된 혁신적인 앱입니다.  
이 앱은 최첨단 인공지능 기술을 활용하여 사용자의 피부 상태를 정밀하게 분석합니다.  
분석을 통해, 사용자의 특정 피부 문제를 식별하고 그에 맞는 솔루션을 제시합니다.  
"PI부엔"은 사용자의 개인적인 피부 상태와 필요에 기반하여 맞춤화된 피부과 병원 및  
전문가를 추천합니다. 예를 들어 여드름, 아토피, 곰팡이성 피부염, 건선 등에 대한 가벼운 1차 피부 치료방안을 제공합니다.  
  
- **개발 환경**  
	- window, mac OS  
  
- **프로그래밍 언어**  
	- Python, Dart
  
- **프레임워크**  
	- Flutter 
  
- **데이터베이스**  
	- Firebase - Firestore
 
![](https://i.imgur.com/iBbuNNh.jpeg)

---
# 01 EDA, model parameter tuning

## 1) 데이터 개요

- ISIC(International Skin Imaging Collaboration)와 DermNet에서 제공하는 피부병 이미지
- Kaggle에서 10개 클래스로 정리된 데이터 사용
    - 데이터 링크: [Skin diseases image dataset (kaggle.com)](https://www.kaggle.com/datasets/ismailpromus/skin-diseases-image-dataset)

## 2) 데이터 특징

- 눈으로 보기에 비슷하게 보이는 피부병이 많음
- 모델 학습을 통해 비슷해 보이는 피부병을 잘 분류할 수 있는 지가 모델 학습의 중요 문제
- 훈련, 검증, 평가 데이터 분리 : 8 / 1 / 1 → 21719 / 2711 / 2723

```
0: Atopic Dermatitis 
아토피 피부염 / 1257
1: Basal Cell Carcinoma 
기저세포암 / 3323 
2: Benign Keratosis-like Lesions 
양성 각화증 유사 병변 / 2079
3: Eczema 
습진 / 1677 
4: Melanocytic Nevi 
색소성 모반 / 7970 
5: Melanoma 
흑색종 / 3140
6: Psoriasis pictures Lichen Planus and related diseases 
건선, 편평태선 및 관련 질환 / 2055 
7: Seborrheic Keratoses and other Benign Tumors 
지루성 각화증 및 기타 양성 종양 / 1847 
8: Tinea Ringworm Candidiasis and other Fungal Infections 
백선, 옴, 칸디다증 및 기타 곰팡이 감염/ 1702 
9: Warts Molluscum and other Viral Infections 
사마귀 연쇄상구균 및 기타 바이러스 감염 / 2103 
```

![](https://i.imgur.com/KDyI2cJ.jpeg)

![](https://i.imgur.com/V5wxl0J.png)

## 3) model parameter tuning

- 대략적으로 데이터를 살펴봤을 때 큰 문제가 없을 것이라고 단순 판단
- 시험적으로 모델을 돌려보고 학습이 어떻게 되는지 보고 이후 모델 실험 방향을 결정하려고 함
- 학습이 제대로 되지 않는 것으로 보이며, 클래스별 재현율도 현저히 낮은 것을 볼 수 있음(70% 이하가 7개, 대부분 60% 이하)
- 클래스별 분포 불균형 문제로 판단해 over/under sampling 해보았으나, overfitting 발생

![](https://i.imgur.com/qnTkjUg.png)

![](https://i.imgur.com/OAYZDyO.png)

![](https://i.imgur.com/XwLv5hf.png)


- 클래스가 많기에 발생하는 문제로 판단해, 클래스 10개 중 피부병 분류에 필요한 클래스를 자체 판단. 클래스를 10개에서 7개로 축소해 모델 학습
- VGG16을 기준으로 wandb의 sweep을 이용해 모델 훈련을 위한 파라미터를 찾고자 함.

```
0: Atopic Dermatitis 
아토피 피부염
1: Basal Cell Carcinoma 
기저세포암
2: Melanocytic Nevi 
색소성 모반 
3: Melanoma 
흑색종
4: Seborrheic Keratoses and other Benign Tumors 
지루성 각화증 및 기타 양성 종양
5: Tinea Ringworm Candidiasis and other Fungal Infections 
백선, 옴, 칸디다증 및 기타 곰팡이 감염/ 1702 
6: Warts Molluscum and other Viral Infections 
사마귀 연쇄상구균 및 기타 바이러스 감염 / 2103 
```

```python

# 파라미터 탐색 조건
sweep_config = {
    "name": "sweep_test_core",
    "method": "bayes",
    "metric": {"name": "val_loss", "goal": "minimize"},
    "parameters": {
        "learning_rate": {"values": [1e-3, 1e-4, 1e-5]},
        "epoch": {"min":20, "max":40},
        "batch_size" : {"values": [32, 64, 128]},
        "optimizer": {"values": ["adam", "sgd", "rmsprop"]},
    }
}

```

- 아래 손실 곡선에서 볼 수 있듯이 대체적으로 수렴되는 결과를 보이며, 특히 epoch 36, lr 10^-5, adam으로 학습했을 때 Test Accuracy, Val Loss에 대한 성능값이 우수하게 나옴
- 배치 크기는 아래 상관관계표를 보았을 때 음의 상관관계를 지니기에, 배치 학습은 제외

![](https://i.imgur.com/N5SMs4T.png)

![](https://i.imgur.com/82hmiTa.png)

![](https://i.imgur.com/JrzHynF.png)

![](https://i.imgur.com/ePWD5QM.png)


## 4) model 선택

- 위 실험 결과를 토대로 epoch 36, lr 10^-5, adam으로 6개 모델 학습 실시
- 아래 결과에서 볼 수 있듯이 ResNet50, 152이 가장 우수한 성능을 보임
- 장성은 서울아산병원 피부과 교수와 함께 아이피부과 한승석 원장과 인제대 상계백병원 김명신 교수가 제 1저자로 참여해 작성한 논문에서도 동일하게 ResNet152가 피부 분류에 가장 우수한 성능을 보인다고 설명
    - 논문제목: Classification of the Clinical Images for Benign and Malignant Cutaneous Tumors Using a Deep Learning Algorithm
    - 관련기사: [피부암, 인공지능으로 찾아낸다 < Deep Learning < AI Tech < 기사본문 - 인공지능신문 (aitimes.kr)](https://www.aitimes.kr/news/articleView.html?idxno=11628)
- ResNet152 우수한 이유는 복잡한 피부 질환의 임상 이미지와 같은 고해상도 데이터를 처리하는 데 있어서 우수한 성능을 발휘할 수 있기 때문에 선택. 또한, 이 모델은 깊은 네트워크 구조를 통해 다양한 특징을 학습할 수 있어, 피부 질환의 미묘한 차이를 구별하는 데 유리
- 그러나 재현율, f1score, 정확도 등에서 ResNet50과 152간의 확연한 차이가 없다는 점, 그리고 모델 학습에 소요되는 시간(runtime)이 ResNet50이 훨씬 적게 든다는 점에서 ResNet50 선택 → 연산 비용 차이


![](https://i.imgur.com/v1Vqfgy.png)

![](https://i.imgur.com/0acu8nE.png)




```

   # ResNet50
   
              precision    recall  f1-score   support

           0       0.67      0.59      0.63       127
           1       0.92      0.95      0.93       333
           2       0.94      0.94      0.94       797
           3       0.92      0.91      0.91       314
           4       0.70      0.74      0.72       186
           5       0.73      0.71      0.72       171
           6       0.67      0.69      0.68       211

    accuracy                           0.85      2139
   macro avg       0.79      0.79      0.79      2139
weighted avg       0.85      0.85      0.85      2139
```

```
   # ResNet 152
   
              precision    recall  f1-score   support

           0       0.61      0.63      0.62       127
           1       0.96      0.94      0.95       333
           2       0.94      0.96      0.95       797
           3       0.92      0.90      0.91       314
           4       0.75      0.79      0.77       186
           5       0.74      0.70      0.72       171
           6       0.73      0.68      0.70       211

    accuracy                           0.87      2139
   macro avg       0.81      0.80      0.80      2139
weighted avg       0.86      0.87      0.86      2139
```

# 02 Grad-CAM을 통한 EDA 및 문제해결

## 1) 각 클래스 재현율 분석

- 각 클래스에 대한 재현율(혼동행렬)을 살펴보았을 때 0, 4, 5, 6번 클래스가 서로 헷갈려 하는 것을 볼 수 있음

```
   
   # ResNet50
   
              precision    recall  f1-score   support

           0       0.67      0.59      0.63       127
           1       0.92      0.95      0.93       333
           2       0.94      0.94      0.94       797
           3       0.92      0.91      0.91       314
           4       0.70      0.74      0.72       186
           5       0.73      0.71      0.72       171
           6       0.67      0.69      0.68       211

    accuracy                           0.85      2139
   macro avg       0.79      0.79      0.79      2139
weighted avg       0.85      0.85      0.85      2139
```


![](https://i.imgur.com/DVCUeZk.png)

![](https://i.imgur.com/cwP5p7y.png)


## 2) Grad-CAM을 통한 EDA

- 멘토링에서 모델 자체에 집중하기 보다는, 데이터의 상태가 어떤지 자세히 살펴볼 것을 요구 받음. 이를 위해 실시한 것이 Grad-CAM
    
- Grad-CAM(gradient-weighted class activation mapping)은 딥러닝이 왜 이런 결정을 내렸는지에 대해 연구하는 **모델의 해석 가능성 분야**에서 사용되는 기법. 모델에 들어간 입력 이미지에 대한 feature map을 heatmap으로 산출해 이미지에 덧붙임으로써 모델이 입력 이미지의 어떤 부분에 집중하는지 확인
    
- 평가 데이터 중 틀린 이미지에 대한 Grad-CAM을 출력해 모델이 피부병 이미지의 중요 특징들을 잡아내는지 확인
    
- 분석 결과 다양한 이유로 피부병의 특징들을 잡아내지 못하는 것을 확인
    
    - 피부병이 전체적으로 퍼져있거나, 부위가 너무 작은 부분은 해당 이미지의 특징을 잘 뽑아내지 못하는 것 같음
    - 입술이나 작은 특징 부분들을 구별을 어려워함
    
    
![](https://i.imgur.com/K7XC4Iv.png)

![](https://i.imgur.com/9TCBl03.jpeg)

    
- 털이 많은 부분도 식별을 잘 하지 못하는 것 같음
    
![](https://i.imgur.com/1Sxp52S.png)

    
- 피부병이 자세히 보이지 않는 이미지 등 사진 각도에 따라 특징이 추출 안되는 현상 발생

## 3) Grad-CAM을 통한 문제 해결

- ISIC 및 DermNet에서 제공하는 이미지 중 명확히 인식될 수 있는 피부병 이미지를 선별해 새롭게 모델 훈련 실시
- 이를 통해 0, 4,5,6 클래스의 재현율 증가 및 기존에 제대로 학습되지 않았던 클래스들의 feature map이 개선되는 것을 볼 수 있었음(보라색: 이전에 재현율 낮았던 모델, 빨강색: 개선 모델)



![](https://i.imgur.com/dZs2D9U.png)

![](https://i.imgur.com/fgOKAQb.png)



```
                precision    recall  f1-score   support
          
           0       0.90      0.86      0.88       123
           1       0.95      0.93      0.94       333
           2       0.95      0.95      0.95       797
           3       0.93      0.92      0.92       314
           4       0.91      0.91      0.91       343
           5       0.89      0.90      0.90       325
           6       0.86      0.87      0.87       272

    accuracy                           0.92      2507
   macro avg       0.91      0.91      0.91      2507
weighted avg       0.92      0.92      0.92      2507
```

- Grad-CAM을 통한 feature map 개선 사항 확인
    - 0번 클래스
        
        
![](https://i.imgur.com/AhD0ryw.jpeg)

        
- 0번 클래스
        
        
![](https://i.imgur.com/wEZ78Qa.png)

        
- 4번 클래스
        
        
![](https://i.imgur.com/wE8LcZh.jpeg)

![](https://i.imgur.com/pzPpCou.jpeg)

        
- 5번클래스
        
        
![](https://i.imgur.com/Ewwjsqs.jpeg)

![](https://i.imgur.com/yW0ztwB.png)
- 6번 클래스

![](https://i.imgur.com/JkjEk3q.png)

![](https://i.imgur.com/ZTrnRZn.jpeg)

# 03 일반화의 문제

## 1) 클래스 구성의 문제

- 클래스가 7개 밖에 없어 다양한 피부병 분류에 한계를 지님
- 비슷한 형태의 피부병이 많기에 아예 다른 피부병으로 인식하는 문제도 발생
- 클래스를 다시 10개로 늘리되, 학습을 위한 품질이 좋은 피부병 이미지를 구성해 모델 학습 실시
- 클래스 구성

|라벨|클래스|출처|데이터 주소|
|---|---|---|---|
|0|여드름(8:1:1로 분리)|Dermnet|[https://www.kaggle.com/datasets/nayanchaure/acne-dataset](https://www.kaggle.com/datasets/nayanchaure/acne-dataset)|
|1|아토피 피부염(8:1:1로 분리)|Dermnet|[https://www.kaggle.com/datasets/josettefekison/traindataskin2](https://www.kaggle.com/datasets/josettefekison/traindataskin2)|
|2|기저세포암 (BCC)|ISIC|[https://www.kaggle.com/datasets/noureldeenhossam/33k-skin-disease-data-set](https://www.kaggle.com/datasets/noureldeenhossam/33k-skin-disease-data-set)|
|3|양성 각화 유사 병변 (BKL)|ISIC|[https://www.kaggle.com/datasets/noureldeenhossam/33k-skin-disease-data-set](https://www.kaggle.com/datasets/noureldeenhossam/33k-skin-disease-data-set)|
|4|습진|ISIC|[https://www.kaggle.com/datasets/durgeshpal/my-dataset-modified-1400](https://www.kaggle.com/datasets/durgeshpal/my-dataset-modified-1400)|
|5|흑색종(Melona)|ISIC|[https://www.kaggle.com/datasets/noureldeenhossam/33k-skin-disease-data-set](https://www.kaggle.com/datasets/noureldeenhossam/33k-skin-disease-data-set)|
|6|건선, 회반증 및 관련 질환 사진|Dermnet|[https://www.kaggle.com/datasets/durgeshpal/my-dataset-modified-1400](https://www.kaggle.com/datasets/durgeshpal/my-dataset-modified-1400)|
|7|지루성 각화 및 기타 양성 종양|Dermnet|[https://www.kaggle.com/datasets/durgeshpal/my-dataset-modified-1400](https://www.kaggle.com/datasets/durgeshpal/my-dataset-modified-1400)|
|8|백선사상균, 칸디다증 및 기타 곰팡이 감염|Dermnet|[https://www.kaggle.com/datasets/durgeshpal/my-dataset-modified-1400](https://www.kaggle.com/datasets/durgeshpal/my-dataset-modified-1400)|
|9|사마귀, 멜러스컴 및 기타 바이러스 감염|Dermnet|[https://www.kaggle.com/datasets/durgeshpal/my-dataset-modified-1400](https://www.kaggle.com/datasets/durgeshpal/my-dataset-modified-1400)|

```
0 : Acne
여드름
1 : Atopic Dermatitis
아토피 피부염
2 : Basal Cell Carcinoma (BCC)
기저세포암
3 : Benign Keratosis-like Lesions (BKL) 
양성 각화증 유사 병변
4 : Eczema
습진
5 : Melanoma
흑생종, 색소성 모반
6 : Psoriasis pictures Lichen Planus and related diseases
건선, 편평태선 및 관련 질환
7: Seborrheic Keratoses and other Benign Tumors
지루성 각화증 및 기타 양성 종양
8 : Tinea Ringworm Candidiasis and other Fungal Infections
백선, 옴, 칸디다증 및 기타 곰팡이 감염
9 : Warts Molluscum and other Viral Infections
사마귀 연쇄상구균 및 기타 바이러스 감염
```

## 2) 모델 학습 및 결과

- classification report

```
              precision    recall  f1-score   support

           0       0.94      0.83      0.88       184
           1       0.96      0.93      0.95       281
           2       0.84      0.85      0.84       238
           3       0.76      0.74      0.75       152
           4       0.82      0.87      0.84       309
           5       0.96      0.96      0.96       201
           6       0.82      0.82      0.82       352
           7       0.79      0.92      0.85       343
           8       0.88      0.84      0.86       325
           9       0.87      0.78      0.82       272

    accuracy                           0.86      2657
   macro avg       0.86      0.85      0.86      2657
weighted avg       0.86      0.86      0.86      2657
```

- confusion matrix

![](https://i.imgur.com/9JQxkhG.png)

![](https://i.imgur.com/XHAnBDp.png)


- 클래스별 피부명 이미지 테스트 향상 결과

![](https://i.imgur.com/En2Ijf8.png)

![](https://i.imgur.com/50ydMOb.png)
