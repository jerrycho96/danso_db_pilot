import 'package:danso_db_pilot/controller/song_data_controller.dart';
import 'package:danso_db_pilot/db/db_helpers.dart';
import 'package:get/get.dart';

class LikeSongController extends GetxController {
  var likeSongList = [].obs;
  final SongController songController = Get.put(SongController());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLikeSongList();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    songController.getAllSongList();
  }

  void getLikeSongList() async {
    var data = await DBHelPer().readLikeSongList();
    if (data != null) {
      likeSongList.assignAll(data);
    }
    // update();
  }

  void updateLikeSongList({String songLike, int songId}) async {
    // var data = await
    var like = songLike == "true" ? "false" : "true";
    await DBHelPer().updateLikeSongList(like, songId);
    getLikeSongList();
  }
}
