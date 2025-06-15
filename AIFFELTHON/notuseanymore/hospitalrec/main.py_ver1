from flask import escape, request, jsonify
from google.cloud import storage
import json

def load_hospital_data():
    with open('hospitals.json', 'r') as file:
        hospitals = json.load(file)
    return hospitals

# 거리 계산 함수
def calculate_distance(x1, y1, x2, y2):
    return ((x1 - x2)**2 + (y1 - y2)**2)**0.5

def hospital_recommendation(request):
    if request.method == 'POST':
        request_json = request.get_json(silent=True)
        
        if request_json and 'x' in request_json and 'y' in request_json:
            user_x = request_json['x']
            user_y = request_json['y']
            
            # 병원 데이터 로드
            hospitals = load_hospital_data()
            
            # 사용자 위치와 각 병원 위치 사이의 거리 계산
            for hospital in hospitals:
                hospital['distance'] = calculate_distance(user_x, user_y, hospital['좌표(X)'], hospital['좌표(Y)'])
            
            # 가장 가까운 3개의 병원 찾기
            nearest_hospitals = sorted(hospitals, key=lambda h: h['distance'])[:3]
            
            return jsonify(nearest_hospitals)
        else:
            return jsonify({"error": "x, y 좌표가 요청에 포함되어 있지 않습니다."}), 400
    else:
        return jsonify({"error": "이 함수는 POST 요청만을 지원합니다."}), 405
