import 'package:flutter/foundation.dart';

class ExerciseModel {
  final int exerId;
  final int songId;
  final String exerType;
  final String exerPath;
  final String exerTime;

  ExerciseModel({
    this.exerId,
    @required this.songId,
    @required this.exerType,
    @required this.exerPath,
    this.exerTime,
  });
}
