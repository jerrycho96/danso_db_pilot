import 'package:danso_db_pilot/controller/song_data_controller.dart';
import 'package:danso_db_pilot/db/delete_dymmy.dart';
import 'package:danso_db_pilot/db/insert_dummy.dart';
import 'package:danso_db_pilot/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:danso_db_pilot/db/db_helpers.dart';
import 'package:get/get.dart';

import 'models/models.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Danso Database'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SongController songController = Get.put(SongController());

  @override
  void initState() {
    // songController.insertSongToJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('도전하기 점수 화면 이동'),
                  onPressed: () {
                    Get.to(ChallangeScreen());
                  },
                ),
                ElevatedButton(
                  child: Text('연습하기 데이터 화면 이동'),
                  onPressed: () {
                    Get.to(ExerCiseScreen());
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('관심곡 화면 이동'),
                  onPressed: () {
                    Get.to(LikeScreen());
                  },
                ),
                // ElevatedButton(
                //   child: Text('연습하기 데이터 화면 이동'),
                //   onPressed: () {
                //     Get.to(ExerCiseScreen());
                //   },
                // ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('도전하기 점수 더미 추가'),
                  onPressed: () {
                    Dummy().insertChalDummy();
                    print('도전하기 더미 추가');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                ),
                ElevatedButton(
                  child: Text('연습하기 더미 추가'),
                  onPressed: () {
                    Dummy().insertExerDummy();
                    print('연습하기 더미 추가');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('도전하기 더미 삭제'),
                  onPressed: () {
                    DeleteDummy().deleteAllChal();
                    print('도전하기 더미 삭제');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                ),
                ElevatedButton(
                  child: Text('연습하기 더미 삭제'),
                  onPressed: () {
                    DeleteDummy().deleteAllExer();
                    print('연습하기 더미 삭제');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                ),
              ],
            ),
            Text(
              '음악 json 데이터',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            GetBuilder<SongController>(
              init: songController,
              builder: (controller) {
                return FutureBuilder(
                  future: controller.songList.value,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            SongModel item = snapshot.data[index];
                            return Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) {
                                DBHelPer().deleteSong(item.songId);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        '${item.songId} ${item.songTitle} ${item.songJangdan} ${item.songLike}'),
                                    IconButton(
                                        icon: Icon(item.songLike == "true"
                                            ? Icons.star
                                            : Icons.star_outline),
                                        onPressed: () {
                                          // var b = item.songLike == 'true';
                                          controller.updateLikeSongList(
                                              songId: item.songId,
                                              songLike: item.songLike);
                                        }),
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
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FloatingActionButton(
              heroTag: null,
              child: Icon(Icons.refresh),
              onPressed: () {
                songController.deleteAllSong();
                print('음악 삭제버튼 선택');
              },
            ),
            SizedBox(height: 8.0),
            FloatingActionButton(
              heroTag: null,
              child: Icon(Icons.add),
              onPressed: () {
                // songController.insertSongDummyData();
                songController.insertSongToJson();
                print('음악 추가 버튼 선택');
              },
            ),
          ],
        ));
  }
}
