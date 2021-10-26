import 'package:danso_db_pilot/db/db_helpers.dart';
import 'package:get/get.dart';

class ExerDataController extends GetxController {
  var myHistoryList = Future.value([]).obs;
  var myHistoryGraph = [].obs;
  var mySoundRecord = [].obs;
  var myVideoRecord = [].obs;

  @override
  void onInit() {
    super.onInit();
    getMySoundRecord();
    getMyVideoRecord();
  }

  // 녹음 듣기
  getMySoundRecord() async {
    var data = await DBHelPer().readExerSoundData();
    print(data);
    if (data != null) {
      mySoundRecord.assignAll(data);
    }
  }

  // 녹화 보기
  getMyVideoRecord() async {
    var data = await DBHelPer().readExerVideoData();
    print(data);
    if (data != null) {
      myVideoRecord.assignAll(data);
    }
  }
}
