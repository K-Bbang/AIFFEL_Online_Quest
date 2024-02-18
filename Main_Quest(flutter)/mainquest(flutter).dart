import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageSwitcher(),
    );
  }
}

class ImageSwitcher extends StatefulWidget {
  @override
  _ImageSwitcherState createState() => _ImageSwitcherState();
}

class _ImageSwitcherState extends State<ImageSwitcher> {
  // 이미지의 경로 리스트를 설정합니다.
  List<String> _imagePaths = [
    'images/그림1.png',
    'images/그림2.png',
    'images/그림3.png',
    'images/그림4.png',
  ];

  // 현재 이미지의 인덱스와 다음 이미지의 인덱스를 설정합니다.
  int _currentIndex = 0;
  int _nextIndex = 1;

  Future<void> _switchImage() async {
    await Future.delayed(Duration(seconds: 1)); // 1초의 딜레이를 줍니다.

    setState(() {
      // 이미지를 전환하는 로직을 작성합니다.
      _currentIndex = (_currentIndex + 1) % _imagePaths.length;
      _nextIndex = (_nextIndex + 1) % _imagePaths.length;
    });
  }

  void _goToFirstImage() {
    setState(() {
      _currentIndex = 0;
      _nextIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('반려식물 상태진단')),
        leading: Icon(Icons.menu),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              _imagePaths[_currentIndex],
              width: 400,
              height: 400,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _goToFirstImage();
                  },
                  child: Text('사진촬영'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    _switchImage();
                  },
                  child: Text('질병진단'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}