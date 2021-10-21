import 'package:flutter/material.dart';
import 'package:danso_db_pilot/db/db_helpers.dart';

import 'dart:math';

import 'models/song_model.dart';

// 더미 데이터
List<SongModel> songList = [
  SongModel(
    songTitle: 'song_title 01',
    songPath: 'song_path 01',
    songJangdan: 'song_jangdan 01',
    songLike: 'false',
  ),
  SongModel(
    songTitle: 'song_title 02',
    songPath: 'song_path 02',
    songJangdan: 'song_jangdan 02',
    songLike: 'false',
  ),
  SongModel(
    songTitle: 'song_title 03',
    songPath: 'song_path 03',
    songJangdan: 'song_jangdan 03',
    songLike: 'false',
  ),
  SongModel(
    songTitle: 'song_title 04',
    songPath: 'song_path 04',
    songJangdan: 'song_jangdan 04',
    songLike: 'false',
  ),
];

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'SongModel Database'),
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
          future: DBHelPer().getAllSongs(),
          builder:
              (BuildContext context, AsyncSnapshot<List<SongModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  SongModel item = snapshot.data[index];
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      DBHelPer().deleteSong(item.songId);
                      setState(() {});
                    },
                    child: Center(
                      child: Text(
                          '${item.songId} ${item.songTitle} ${item.songJangdan} ${item.songLike}'),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(Icons.refresh),
              onPressed: () {
                DBHelPer().deleteAllSongs();
                setState(() {});
              },
            ),
            SizedBox(height: 8.0),
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                songList.forEach((element) {
                  DBHelPer().insertSongData(element);
                });
                setState(() {});
              },
            ),
          ],
        ));
  }
}
