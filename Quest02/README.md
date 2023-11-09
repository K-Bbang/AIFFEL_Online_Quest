# AIFFEL Campus Online 7th Code Peer Review Templete

- 코더 : 이상원
- 리뷰어 : 강영현



🔑 **PRT(Peer Review Template)**

- [x]  **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요?**
       -> 결과물은 제출되었으나, 문제 요구조건이 충족되는지는 모르겠다.
      
      : 1. # 컴프리헨션

fish_list = [{"이름": "Nemo", "speed": 3}, {"이름": "Dory", "speed": 5}]

def fish_movement_com(fish_list):
    fish_movements = [(fish["이름"], fish["speed"]) for fish in fish_list]
    for name, speed in fish_movements:
        print(f"{name} is swimming at {speed} m/s")
        fish_movement_com(fish_list)
        
        2. #제너레이터 작업중
        
fish_list = [{"이름": "Nemo", "speed": 3}, {"이름": "Dory", "speed": 5}]

def fish_movement_gen(fish_list):
  for fish in fish_list:
    yield(fish["이름"], fish["speed"])

move_gen = fish_movement_gen(fish_list)

print(next(move_gen))
print(next(move_gen))

     3. #제너레이터 결과

def fish_movement_gen(fish_list):
  for fish in fish_list:
    yield(fish["이름"], 'is swimming at', fish["speed"], 'm/s')

move_gen = fish_movement_gen(fish_list) # 반복 및 시간 간격 추가를 못했음. 어떻게 해야 할지?

print("Using Generator:")
for i in move_gen:
    print(i)
print("Using Comprehension:")

         

    - 문제에서 요구하는 최종 결과물이 첨부되었는지 확인
    - 문제를 해결하는 완성된 코드란 프로젝트 루브릭 3개 중 2개, 
    퀘스트 문제 요구조건 등을 지칭
        - 해당 조건을 만족하는 부분의 코드 및 결과물을 근거로 첨부
    
- [ ]  **2. 전체 코드에서 가장 핵심적이거나 가장 복잡하고 이해하기 어려운 부분에 작성된 
주석 또는 doc string을 보고 해당 코드가 잘 이해되었나요?** - 예와 아니요의 중간..

    -> 주석을 달아주셨으나, 충분한 설명이 되어 있지는 않다. 하지만 시도는 좋았다..!, 주석에 어떤 식으로 코드를 작성하는지에 대한 설명을
       작성하는 연습을 하면 좋을 것 같다.
       # 컴프리헨션
       #제너레이터 작업중
       #제너레이터 결과
       # 반복 및 시간 간격 추가를 못했음. 어떻게 해야 할지?

    
    : 작성해주신 코드의 
    - 해당 코드 블럭에 doc string/annotation이 달려 있는지 확인
    - 해당 코드가 무슨 기능을 하는지, 왜 그렇게 짜여진건지, 작동 메커니즘이 뭔지 기술.
    - 주석을 보고 코드 이해가 잘 되었는지 확인
        - 잘 작성되었다고 생각되는 부분을 근거로 첨부합니다.
        
- [ ]  **3. 에러가 난 부분을 디버깅하여 문제를 “해결한 기록을 남겼거나” 
”새로운 시도 또는 추가 실험을 수행”해봤나요?** - 아니요
    - 문제 원인 및 해결 과정을 잘 기록하였는지 확인 또는
    - 문제에서 요구하는 조건에 더해 추가적으로 수행한 나만의 시도, 
    실험이 기록되어 있는지 확인
        - 잘 작성되었다고 생각되는 부분을 근거로 첨부합니다.
        
- [x]  **4. 회고를 잘 작성했나요?**
    : 힘든 마음이 고스란히 느껴지는.. 회고.. (공감ㅜㅜ)

    - 주어진 문제를 해결하는 완성된 코드 내지 프로젝트 결과물에 대해
    배운점과 아쉬운점, 느낀점 등이 상세히 기록되어 있는지 확인
        - 딥러닝 모델의 경우,
        인풋이 들어가 최종적으로 아웃풋이 나오기까지의 전체 흐름을 도식화하여 
        모델 아키텍쳐에 대한 이해를 돕고 있는지 확인

- [x]  **5. 코드가 간결하고 효율적인가요?** - 네 
      1. fish_list = [{"이름": "Nemo", "speed": 3}, {"이름": "Dory", "speed": 5}]

def fish_movement_com(fish_list):
    fish_movements = [(fish["이름"], fish["speed"]) for fish in fish_list]
    for name, speed in fish_movements:
        print(f"{name} is swimming at {speed} m/s")

print("Using Comprehension:")
fish_movement_com(fish_list)

    2. fish_list = [{"이름": "Nemo", "speed": 3}, {"이름": "Dory", "speed": 5}]

def fish_movement_gen(fish_list):
  for fish in fish_list:
    yield(fish["이름"], fish["speed"])

move_gen = fish_movement_gen(fish_list)

print(next(move_gen))
print(next(move_gen))

    3.def fish_movement_gen(fish_list):
  for fish in fish_list:
    yield(fish["이름"], 'is swimming at', fish["speed"], 'm/s')

move_gen = fish_movement_gen(fish_list) # 반복 및 시간 간격 추가를 못했음. 어떻게 해야 할지?

print("Using Generator:")
for i in move_gen:
    print(i)
    
    - 파이썬 스타일 가이드 (PEP8) 를 준수하였는지 확인
    - 코드 중복을 최소화하고 범용적으로 사용할 수 있도록 모듈화(함수화) 했는지
        - 잘 작성되었다고 생각되는 부분을 근거로 첨부합니다.

    참고링크: https://tech-diary.tistory.com/40
    - 해당 사이트를 통해 파이썬 스타일 가이드를 참고하였습니다.
