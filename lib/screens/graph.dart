import 'package:danso_db_pilot/controller/chal_data_controller.dart';
import 'package:danso_db_pilot/db/db_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({Key key, @required this.songId}) : super(key: key);
  final songId;

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  final ChalDataController chalDataController = Get.put(ChalDataController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chalDataController.getMyHistoryGraphData(widget.songId);
  }

  @override
  Widget build(BuildContext context) {
    var listData = chalDataController.myHistoryGraph;
    return Scaffold(
      appBar: AppBar(
        title: Text('그래프 데이터 화면'),
      ),
      body: Obx(
        () => Container(
          color: Colors.grey,
          child: ListView.builder(
            itemCount: listData.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('${listData[index].chalScore} 점'),
                    Text('${listData[index].chalTime}'),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
