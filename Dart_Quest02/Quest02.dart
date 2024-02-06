// Flutter의 Material 디자인 컴포넌트를 사용하기 위해 material.dart 패키지를 가져옵니다.
import 'package:flutter/material.dart';

// main 함수는 모든 Flutter 애플리케이션의 진입점입니다.
void main() {
  // runApp 함수는 주어진 위젯을 애플리케이션의 루트로 만듭니다.
  runApp(MyApp());
}

// MyApp 클래스는 StatelessWidget을 상속받아 상태가 없는 위젯을 만듭니다.
// 상태가 없는 위젯은 한 번 생성되면 위젯의 상태를 변경할 수 없습니다.
class MyApp extends StatelessWidget {
  // build 함수는 위젯의 레이아웃을 설명합니다.
  // context는 현재 위젯의 위치를 알 수 있는 정보를 담고 있습니다.
  @override
  Widget build(BuildContext context) {
    // MaterialApp은 Material 디자인을 적용한 앱을 만들기 위한 위젯입니다.
    return MaterialApp(
      // 앱의 타이틀을 'AppDisplaySetting'으로 설정합니다.
      title: 'AppDisplaySetting',
      // Scaffold는 기본적인 머티리얼 디자인 레이아웃 구조를 제공합니다.
      home: Scaffold(
        // AppBar는 앱의 상단에 위치하는 바로, 앱의 제목이나 메뉴 버튼을 담습니다.
        appBar: AppBar(
          // AppBar의 leading은 일반적으로 앱의 아이콘이나 메뉴 버튼이 위치합니다.
          // 여기서는 Row 위젯을 사용하여 여러 위젯을 가로로 배치합니다.
          leading: Row(
            // MainAxisSize.min은 Row의 크기를 자식 위젯의 크기에 맞춥니다.
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon 위젯을 사용하여 알람 아이콘을 추가합니다.
              // size는 아이콘의 크기, color는 아이콘의 색상을 설정합니다.
              Icon(
                Icons.alarm,
                size: 50,
                color: Colors.red,
              ),
              // Container를 사용하여 세로 경계선을 추가합니다.
              // height를 double.infinity로 설정하여 최대 높이를 가지게 합니다.
              // width는 경계선의 두께를 설정합니다.
              Container(
                height: double.infinity,
                width: 4.0,
                color: Colors.grey[300], // 경계선의 색상을 회색으로 설정합니다.
              ),
            ],
          ), // AppBar의 왼쪽에 아이콘 배치
          // AppBar의 title은 앱의 제목을 표시합니다.
          // Center 위젯을 사용하여 제목을 가운데 정렬합니다.
          title: Center(
            child: Text('플러터 앱 만들기'), // AppBar의 제목을 설정합니다.
          ),
          // AppBar의 bottom은 AppBar의 하단 영역을 설정합니다.
          // PreferredSize를 사용하여 커스텀 높이를 가진 위젯을 추가합니다.
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(4.0), // 높이를 4.0으로 설정합니다.
            child: Container(
              height: 4.0, // Container의 높이를 설정합니다.
              color: Colors.grey[300], // Container의 색상을 회색으로 설정합니다.
            ),
          ),
        ),
        // Scaffold의 body는 앱의 메인 콘텐츠 영역입니다.
        // Center 위젯을 사용하여 자식 위젯을 화면 가운데에 배치합니다.
        body: Center(
          // Column 위젯을 사용하여 자식 위젯을 수직으로 배치합니다.
          child: Column(
            // MainAxisAlignment.center를 사용하여 자식들을 중앙 정렬합니다.
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ElevatedButton은 머티리얼 디자인의 버튼 위젯입니다.
              ElevatedButton(
                // onPressed는 버튼을 클릭했을 때 실행할 콜백 함수를 설정합니다.
                onPressed: () {
                  print('버튼이 눌렸습니다.'); // 콘솔에 메시지를 출력합니다.
                },
                // 버튼의 자식으로 텍스트를 설정합니다.
                child: Text('Text'),
                // 버튼의 스타일을 설정합니다.
                style: ButtonStyle(
                  // backgroundColor를 MaterialStateProperty.all로 설정하여
                  // 버튼의 배경색을 파란색으로 설정합니다.
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blue)),
              ),
              // SizedBox는 공백을 만드는 위젯입니다.
              // 여기서는 높이 20의 공백을 만듭니다.
              // SizedBox 위젯을 사용하여 위젯 간의 공간을 만듭니다. 여기서는 높이가 20 픽셀인 공간을 추가합니다.
              SizedBox(height: 20),
              // Container 위젯을 사용하여 내용을 담습니다.
              Container(
                // 이 컨테이너의 배경색을 파란색으로 설정합니다.
                  color: Colors.blue,
                  // margin 속성을 사용하여 컨테이너 하단에 5 픽셀의 여백을 추가합니다.
                  margin: EdgeInsets.only(bottom: 5),
                  // 컨테이너의 높이를 300 픽셀로, 너비를 300 픽셀로 설정합니다.
                  height: 300,
                  width: 300,
                  // Stack 위젯을 사용하여 여러 개의 컨테이너를 겹쳐서 표시합니다.
                  child: Stack(
                    children: [
                      // Stack의 첫 번째 자식 컨테이너, 배경색을 빨간색으로 설정합니다.
                      Container(
                        color: Colors.red,
                      ),
                      // Stack의 두 번째 자식 컨테이너, 크기를 240x240으로 설정하고, 배경색을 오렌지색으로 합니다.
                      Container(
                        width: 240,
                        height: 240,
                        color: Colors.orange,
                      ),
                      // Stack의 세 번째 자식 컨테이너, 크기를 180x180으로 설정하고, 배경색을 노란색으로 합니다.
                      Container(
                        width: 180,
                        height: 180,
                        color: Colors.yellow,
                      ),
                      // Stack의 네 번째 자식 컨테이너, 크기를 120x120으로 설정하고, 배경색을 초록색으로 합니다.
                      Container(
                        width: 120,
                        height: 120,
                        color: Colors.green,
                      ),
                      // Stack의 다섯 번째 자식 컨테이너, 크기를 60x60으로 설정하고, 배경색을 파란색으로 합니다.
                      // 이 컨테이너는 Stack 내에서 가장 위에 위치합니다.
                      Container(
                        width: 60,
                        height: 60,
                        color: Colors.blue,
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

/* 회고 */

// 이번 퀘스트는 퍼실님이 각 단계에 따른 힌트를 명시해주어서 첫 번째 과제보다 손쉽게 해결할 수 있었음.

// 과제 진행은 화면 구성에 있어 큰 부분부터 해결한 후(중앙 버튼, 스택, 제목), 세부적인 부분(스택 크기, 제목 위치, 간격 등)을 구현했음

// 이후에 아이펠톤에서 실제 앱을 만들 때 오늘처럼 전체적인 얼개를 대충 짠 후에 세부적인 것을 구현하는 계획을 세워야 겠다곡 생각함