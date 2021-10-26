import 'package:danso_db_pilot/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExerCiseScreen extends StatelessWidget {
  const ExerCiseScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('exercise'),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: Text('연습'),
            ),
            ElevatedButton(
              child: Text('녹음 듣기'),
              onPressed: () {
                Get.to(SoundScreen());
              },
            ),
            ElevatedButton(
              child: Text('녹화 보기'),
              onPressed: () {
                Get.to(VideoScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
