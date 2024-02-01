// import 'dart:async'; 문장은 Dart 프로그램에서 Timer 클래스를 사용하기 위해 필요한 부분
import 'dart:async';

void main() {
  startPomodoroTimer();
}

void startPomodoroTimer() {
  int workTime = 25 * 60; // 25분, 작업시간 정수로 변수 선언
  int shortBreak = 5 * 60; // 5분, 휴식시간 정수로 변수 선언
  int setCount = 0; // 회차를 보여줄 변수 정수로 선언

  print("Pomodoro 타이머를 시작합니다.");

  Timer.periodic(Duration(seconds: 1), (Timer timer) {
    if (workTime > 0) {
      // 작업 시간이 남아있을 때
      print("작업 시간: ${formatTime(workTime)} 남음");
      workTime--;
    } else if (shortBreak > 0) {
      // 휴식 시간이 남아있을 때
      if (shortBreak == 5 * 60) {
        print("휴식시간을 시작합니다."); // 휴식시간 시작 문구 추가
      }
      print("휴식 시간: ${formatTime(shortBreak)} 남음");
      shortBreak--;
    } else if (setCount < 3) {
      // 카운트가 0,1,2 이기 때문에 3보다 작게
      // 다음 세트로
      workTime = 25 * 60;
      shortBreak = 5 * 60;
      setCount++; // 1회 사이클 종료 후 setCount 1회 추가
      print("새로운 세트 시작! 현재까지 완료한 세트 수: $setCount");
    } else {
      // 4세트가 완료되었을 때
      timer.cancel();
      print("포모도로 4세트 완료! 타이머 종료.");
    }
  });
}

// formatTime 함수는 총 초를 받아와서 분과 초로 변환하여 포맷팅하는 함수
String formatTime(int totalSeconds) {
  int minutes = totalSeconds ~/ 60; // 총 초를 60으로 나눈 몫을 분으로 계산
  int seconds = totalSeconds % 60; // 총 초를 60으로 나눈 나머지를 초로 계산

  // 반환문에서는 padLeft 함수를 사용하여 각 값을 두 자리 숫자로 만들고,
  // 콜론을 이용하여 시간 포맷을 만들어 반환
  return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
}


<img width="433" alt="스크린샷 2024-02-01 오후 5 30 24" src="https://github.com/Cherrymmu/AIFFEL_Online_Quest_Cherry/assets/149548944/b3b9ea32-55fa-42c8-958f-909a1474d4b1">


<img width="386" alt="스크린샷 2024-02-01 오후 5 30 47" src="https://github.com/Cherrymmu/AIFFEL_Online_Quest_Cherry/assets/149548944/5b73565b-6e87-4fae-92b1-58bc71dce799">


<img width="531" alt="스크린샷 2024-02-01 오후 5 31 01" src="https://github.com/Cherrymmu/AIFFEL_Online_Quest_Cherry/assets/149548944/4cd8f04d-d6d3-472d-956d-17572c123cfc">

/* 채림 회고 */
//Keep : 모르는 부분을 협력해서 구글링 한 것
//Problem : 아직 다트 언어를 배운지 얼마 되지 않아서 코드를 읽는데 걸리는 시간이 길다
//Try : 조금 더 익숙해져서 앱을 잘 만들어 봐야지

/* 상원 회고 */
// 파이썬과 다르게 각 변수에 타입을 선언하고 선언문을 작성해야 한다는 부분이 많이 헷갈렸음
// 타이머를 위한 전체적인 구성은 파이썬과 마찬가지로
// if문 등으로 분기를 구분해서 작성한다는 것은 프로그래밍 언어의 공통점인 것 같음
// 즉, 다양한 문법으로 해당 프로그램의 전체적인 설계도를 그린 후,
// 그에 맞는 코드를 작성해야 함을 느낌
