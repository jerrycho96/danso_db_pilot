import 'package:danso_db_pilot/controller/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ExerDataController exerDataController = Get.put(ExerDataController());
    return Scaffold(
      appBar: AppBar(title: Text('녹화 보기')),
      body: Obx(
        () => ListView.builder(
            itemCount: exerDataController.myVideoRecord.length,
            itemBuilder: (BuildContext context, int index) {
              var item = exerDataController.myVideoRecord;
              return Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${item[index].songTitle}'),
                    Text('${item[index].exerPath}'),
                    Text('${item[index].exerTime}'),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
