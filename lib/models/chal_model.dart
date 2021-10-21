import 'package:flutter/material.dart';

class ChallangeModel {
  final int chalId;
  final int songId;
  final int chalScore;
  final String chalTime;

  ChallangeModel({
    this.songId,
    this.chalId,
    @required this.chalScore,
    @required this.chalTime,
  });
}
