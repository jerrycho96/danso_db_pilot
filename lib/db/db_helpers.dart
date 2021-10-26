import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../models/models.dart';

final String songTable = 'TB_SONG';

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
                chal_time   TEXT, 
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
                exer_time  TEXT, 
                PRIMARY KEY (exer_id)
            );

            ALTER TABLE TB_EXER
                ADD FOREIGN KEY (song_id) REFERENCES $songTable (song_id) ON UPDATE CASCADE;
          ''');
    }, onUpgrade: (db, oldVersion, newVersion) {});
  }

  // frequency query -> TB_USER
  //===========================================================================

  insertFr(UserModel user) async {
    final db = await database;
    await db.rawInsert(
        'INSERT INTO TB_USER (standard_fr) VALUES(?)', [user.standardFr]);
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
  insertSongData(SongDataModel song) async {
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
        'UPDATE $songTable SET song_title = ?, song_path = ?, song_jangdan = ?, song_like = ? WHERE song_id = ?',
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
  // insert challange data
  insertChalData(ChallangeModel chal) async {
    final db = await database;
    await db.rawInsert('INSERT INTO TB_CHAL (song_id, chal_score) VALUES(?,?)',
        [chal.songId, chal.chalScore]);
  }

  // read challange data
  readChalData(int id) async {
    final db = await database;
    var res =
        await db.rawQuery('SELECT * FROM TB_CHAL WHERE song_id = ?', [id]);
    return res;
  }

  // read all challange data
  Future<List<ChallangeModel>> getAllChal() async {
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM TB_CHAL');
    List<ChallangeModel> list = res.isNotEmpty
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
  //===========================================================================

  // EXERCISE query -> TB_EXER
  //===========================================================================
  // insert exercise data
  insertExerData(ExerciseModel exer) async {
    final db = await database;
    await db.rawInsert(
        'INSERT INTO TB_EXER (song_id, exer_type, exer_path, exer_time) VALUES(?,?,?,?)',
        [exer.songId, exer.exerType, exer.exerPath, exer.exerTime]);
  }

  Future<List<ExerciseModel>> readExerSoundData() async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT * FROM TB_EXER AS e INNER JOIN TB_SONG AS s ON e.song_id = s.song_id WHERE exer_type='sound'");
    List<ExerciseModel> list = res.isNotEmpty
        ? res
            .map(
              (value) => ExerciseModel(
                songTitle: value['song_title'],
                exerPath: value['exer_path'],
                exerTime: value['exer_time'],
              ),
            )
            .toList()
        : [];
    return list;
  }

  Future<List<ExerciseModel>> readExerVideoData() async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT * FROM TB_EXER AS e INNER JOIN TB_SONG AS s ON e.song_id = s.song_id WHERE exer_type='video'");
    List<ExerciseModel> list = res.isNotEmpty
        ? res
            .map(
              (value) => ExerciseModel(
                songTitle: value['song_title'],
                exerPath: value['exer_path'],
                exerTime: value['exer_time'],
              ),
            )
            .toList()
        : [];
    return list;
  }
  //===========================================================================

  // 마이페이지 - 기록 탭
  //===========================================================================
  //
  Future<List<MyHistoryModel>> readMyHistoryData() async {
    final db = await database;
    var res = await db.rawQuery(
        'SELECT s.song_title, c.song_id FROM TB_CHAL AS c INNER JOIN TB_SONG AS s ON c.song_id = s.song_id GROUP BY s.song_id');
    List<MyHistoryModel> list = res.isNotEmpty
        ? res
            .map(
              (value) => MyHistoryModel(
                songTitle: value['song_title'],
                songId: value['song_id'],
              ),
            )
            .toList()
        : [];
    print(list);
    return list;
  }

  // 마이페이지 - 기록 탭 - 그래프
  //===========================================================================
  //
  Future<List<MyHistoryModel>> readMyHistoryGraph(int songId) async {
    final db = await database;
    var res = await db.rawQuery(
        'SELECT chal_score, chal_time FROM TB_CHAL WHERE song_id=?', [songId]);
    List<MyHistoryModel> list = res.isNotEmpty
        ? res
            .map(
              (value) => MyHistoryModel(
                chalScore: value['chal_score'],
                chalTime: value['chal_time'],
              ),
            )
            .toList()
        : [];
    print(list);
    return list;
  }
  //===========================================================================

  // 마이페이지 - 관심곡 리스트
  //===========================================================================
  // 관심곡 리스트 불러오기
  Future<List<SongDataModel>> readLikeSongList() async {
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM TB_SONG WHERE song_like="true"');
    List<SongDataModel> list = res.isNotEmpty
        ? res
            .map(
              (value) => SongDataModel(
                songId: value['song_id'],
                songTitle: value['song_title'],
                songLike: value['song_like'],
              ),
            )
            .toList()
        : [];
    return list;
  }

  // 관심곡 업데이트
  updateLikeSongList(String songLike, int songId) async {
    final db = await database;
    await db.rawUpdate(
        'UPDATE TB_SONG SET song_like=? WHERE song_id=?', [songLike, songId]);
  }
}
