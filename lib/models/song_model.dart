import 'package:flutter/foundation.dart';

class SongModel {
  final int songId;
  final String songTitle;
  final String songPath;
  final String songJangdan;
  final String songLike;

  SongModel({
    this.songId,
    @required this.songTitle,
    @required this.songPath,
    @required this.songJangdan,
    @required this.songLike,
  });
}
