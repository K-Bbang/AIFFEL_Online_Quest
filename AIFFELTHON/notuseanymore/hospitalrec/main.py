from flask import escape, request, jsonify
import json

def load_hospital_data():
    with open('hospitals.json', 'r') as file:
        hospitals = json.load(file)
    return hospitals

def calculate_distance(x1, y1, x2, y2):
    return ((x1 - x2)**2 + (y1 - y2)**2)**0.5

def remove_duplicate_hospitals(hospitals):
    unique_hospitals = []
    seen = set()
    for hospital in hospitals:
        if hospital['요양기관명'] not in seen:
            unique_hospitals.append(hospital)
            seen.add(hospital['요양기관명'])
    return unique_hospitals

def hospital_recommendation(request):
    if request.method == 'POST':
        request_json = request.get_json(silent=True)
        
        if request_json and 'x' in request_json and 'y' in request_json:
            user_x = request_json['x']
            user_y = request_json['y']
            
            hospitals = load_hospital_data()
            
            for hospital in hospitals:
                hospital['distance'] = calculate_distance(user_x, user_y, hospital['좌표(X)'], hospital['좌표(Y)'])
            
            sorted_hospitals = sorted(hospitals, key=lambda h: (h['distance'], h['이름'])) # 두 번째 기준으로 '이름' 사용
            unique_sorted_hospitals = remove_duplicate_hospitals(sorted_hospitals)
            
            nearest_hospitals = unique_sorted_hospitals[:3]
            
            return jsonify(nearest_hospitals)
        else:
            return jsonify({"error": "x, y 좌표가 요청에 포함되어 있지 않습니다."}), 400
    else:
        return jsonify({"error": "이 함수는 POST 요청만을 지원합니다."}), 405
