import 'package:danso_db_pilot/db/db_helpers.dart';
import 'package:danso_db_pilot/db/insert_dummy.dart';
import 'package:danso_db_pilot/models/models.dart';
import 'package:get/get.dart';

class SongController extends GetxController {
  var songList = Future.value([]).obs;

  @override
  void onInit() {
    super.onInit();
    getAllSongList();
  }

  getAllSongList() async {
    // await DBHelPer().getAllSongs().then((value) => {songList = value});
    songList.value = DBHelPer().getAllSongs();
    update();
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
