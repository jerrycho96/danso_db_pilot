import 'package:danso_db_pilot/db/db_helpers.dart';
import 'package:get/get.dart';

class ChalDataController extends GetxController {
  var myHistoryList = Future.value([]).obs;
  var myHistoryGraph = [].obs;

  @override
  void onInit() {
    super.onInit();
    getMyHistoryList();
  }

  getMyHistoryList() {
    myHistoryList.value = DBHelPer().readMyHistoryData();
    update();
  }

  getMyHistoryGraphData(int songId) async {
    var data = await DBHelPer().readMyHistoryGraph(songId);
    if (data != null) {
      myHistoryGraph.assignAll(data);
    }
  }
}
