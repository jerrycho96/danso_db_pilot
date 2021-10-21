import 'dart:io';

import 'package:danso_db_pilot/models/chal_model.dart';
import 'package:danso_db_pilot/models/song_model.dart';
import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart' as sql;
// import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../models/song_model.dart';

final String songTable = 'TB_SONG';

// 더미 데이터
List<SongModel> songList = [
  SongModel(
    songTitle: 'song_title 01',
    songPath: 'song_path 01',
    songJangdan: 'song_jangdan 01',
    songLike: 'false',
  ),
  SongModel(
    songTitle: 'song_title 02',
    songPath: 'song_path 02',
    songJangdan: 'song_jangdan 02',
    songLike: 'false',
  ),
  SongModel(
    songTitle: 'song_title 03',
    songPath: 'song_path 03',
    songJangdan: 'song_jangdan 03',
    songLike: 'false',
  ),
  SongModel(
    songTitle: 'song_title 04',
    songPath: 'song_path 04',
    songJangdan: 'song_jangdan 04',
    songLike: 'false',
  ),
];

class DBHelPer {
  DBHelPer._();
  static final DBHelPer _db = DBHelPer._();
  factory DBHelPer() => _db;

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'DansoDB.db');

    return await openDatabase(path, version: 2, onCreate: (db, version) async {
      await db.execute('''
            CREATE TABLE TB_USER
            (
                standard_fr DOUBLE NOT NULL
            )
          ''');
      await db.execute('''
            CREATE TABLE $songTable
            (
                song_id       INTEGER,
                song_title    TEXT    NOT NULL, 
                song_path     TEXT    NOT NULL, 
                song_jangdan  TEXT    NOT NULL, 
                song_like     TEXT    NOT NULL, 
                PRIMARY KEY (song_id)
            )
          ''');
      await db.execute('''
            CREATE TABLE TB_CHAL
            (
                chal_id     INTEGER, 
                song_id     INTEGER     NOT NULL, 
                chal_score  INTEGER     NOT NULL, 
                chal_time   TIMESTAMP   NOT NULL, 
                PRIMARY KEY (chal_id)
            );

            ALTER TABLE TB_CHAL
                ADD FOREIGN KEY (song_id) REFERENCES $songTable (song_id) ON UPDATE CASCADE;
          ''');
      await db.execute('''
            CREATE TABLE TB_EXER
            (
                exer_id    INTEGER, 
                song_id    INTEGER      NOT NULL, 
                exer_type  TEXT         NOT NULL, 
                exer_path  TEXT         NOT NULL, 
                exer_time  TIMESTAMP    NOT NULL, 
                PRIMARY KEY (exer_id)
            );

            ALTER TABLE TB_EXER
                ADD FOREIGN KEY (song_id) REFERENCES $songTable (song_id) ON UPDATE CASCADE;
          ''');
    }, onUpgrade: (db, oldVersion, newVersion) {});
  }

  // frequency query -> TB_USER
  //===========================================================================
  insertFr() async {
    final db = await database;
    await db.rawInsert('INSERT INTO TB_USER (standard_fr) VALUES(?)');
  }

  // updateFr() async {
  //   final db = await database;
  //   await db.rawUpdate('UPDATE ');
  // }

  deleteFr() async {
    final db = await database;
    await db.rawDelete('DELETE FROM TB_USER');
  }
  //===========================================================================

  // song query -> TB_SONG
  //===========================================================================
  // insert song data
  insertSongData(SongModel song) async {
    final db = await database;
    await db.rawInsert(
        'INSERT INTO $songTable (song_title, song_path, song_jangdan, song_like) VALUES(?,?,?,?)',
        [song.songTitle, song.songPath, song.songJangdan, song.songLike]);
  }

  // read song data
  readSongData(int id) async {
    final db = await database;
    var res =
        await db.rawQuery('SELECT * FROM $songTable WHERE song_id = ?', [id]);
    return res;
  }

  // read all song data
  Future<List<SongModel>> getAllSongs() async {
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM $songTable');
    List<SongModel> list = res.isNotEmpty
        ? res
            .map((value) => SongModel(
                songId: value['song_id'],
                songTitle: value['song_title'],
                songPath: value['song_path'],
                songJangdan: value['song_jangdan'],
                songLike: value['song_like']))
            .toList()
        : [];
    return list;
  }

  // delete all song
  deleteAllSongs() async {
    final db = await database;
    db.rawDelete('DELETE FROM $songTable');
  }

  // delete song
  deleteSong(int id) async {
    final db = await database;
    var res = db.rawDelete('DELETE FROM $songTable WHERE song_id = ?', [id]);
    return res;
  }

  //Update
  updateSong(SongModel song) async {
    final db = await database;
    var res = db.rawUpdate(
        '''UPDATE $songTable SET song_title = ?, song_path = ?, song_jangdan = ?, song_like = ? WHERE song_id = ?''',
        [
          song.songTitle,
          song.songPath,
          song.songJangdan,
          song.songLike,
          song.songId
        ]);
    return res;
  }
  //===========================================================================

  // CHALLANGE query -> TB_CHAL
  //===========================================================================
  // insert song data
  insertChalData(ChallangeModel chal) async {
    final db = await database;
    await db.rawInsert(
        'INSERT INTO TB_CHAL (song_id, chal_score, chal_time) VALUES(?,?,?)',
        [chal.songId, chal.chalScore, chal.chalTime]);
  }

  //===========================================================================

}
