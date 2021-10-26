import 'package:danso_db_pilot/controller/controllers.dart';
import 'package:danso_db_pilot/models/models.dart';
import 'package:danso_db_pilot/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChallangeScreen extends StatelessWidget {
  const ChallangeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChalDataController chalDataController = Get.put(ChalDataController());
    return Scaffold(
      appBar: AppBar(
        title: Text('challange'),
      ),
      body: Container(
        child: Column(
          children: [
            Text('도전'),
            Text('도전 점수'),
            GetBuilder<ChalDataController>(
              init: chalDataController,
              builder: (controller) {
                return FutureBuilder(
                  future: controller.myHistoryList.value,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            MyHistoryModel item = snapshot.data[index];
                            return Container(
                              height: 50,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('곡 이름 ${item.songTitle}'),
                                    Row(
                                      children: [
                                        Text('id: ${item.songId}'),
                                        SizedBox(width: 10),
                                        ElevatedButton(
                                          child: Text('그래프'),
                                          onPressed: () {
                                            print('click graph ${item.songId}');
                                            Get.to(
                                                GraphPage(songId: item.songId));
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
