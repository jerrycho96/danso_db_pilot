import 'package:danso_db_pilot/db/db_helpers.dart';
import 'package:danso_db_pilot/db/insert_dummy.dart';
import 'package:danso_db_pilot/models/models.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SongController extends GetxController {
  var songList = Future.value([]).obs;

  @override
  void onInit() {
    super.onInit();
    getAllSongList();
  }

  updateLikeSongList({String songLike, int songId}) async {
    // var data = await
    var like = songLike == "true" ? "false" : "true";
    await DBHelPer().updateLikeSongList(like, songId);
    getAllSongList();
  }

  getAllSongList() async {
    // await DBHelPer().getAllSongs().then((value) => {songList = value});
    songList.value = DBHelPer().getAllSongs();
    update();
  }

  insertSongToJson() async {
    String jsonString = await rootBundle.loadString('assets/json/song.json');
    final res = songFromJsonFromJson(jsonString);
    print(res.songData[0].songJangdan);
    res.songData.forEach((element) async {
      await DBHelPer().insertSongData(element);
    });
    getAllSongList();
  }

  deleteAllSong() async {
    DBHelPer().deleteAllSongs();
    getAllSongList();
  }

  insertSongDummyData() async {
    await Dummy().insertSongDummy();
    getAllSongList();
    // update();
  }
}
