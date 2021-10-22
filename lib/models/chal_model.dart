import 'package:flutter/foundation.dart';

class ChallangeModel {
  final int chalId;
  final int songId;
  final int chalScore;
  final String chalTime;

  ChallangeModel({
    this.songId,
    @required this.chalId,
    @required this.chalScore,
    this.chalTime,
  });
}
