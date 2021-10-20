import 'dart:io';

import 'package:danso_db_pilot/models/song_model.dart';
import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart' as sql;
// import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

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

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
            CREATE TABLE TB_USER
            (
                standard_fr DOUBLE NOT NULL
            )
          ''');
      await db.execute('''
            CREATE TABLE $songTable
            (
                song_id       INT, 
                song_title    VARCHAR(45)   NOT NULL, 
                song_path     VARCHAR(999)  NOT NULL, 
                song_jangdan  VARCHAR(45)   NOT NULL, 
                song_like     VARCHAR(45)   NOT NULL, 
                PRIMARY KEY (song_id)
            )
          ''');
      await db.execute('''
            CREATE TABLE TB_CHAL
            (
                chal_id     INT, 
                song_id     INT, 
                chal_score  INT          NOT NULL, 
                chal_time   TIMESTAMP    NOT NULL, 
                PRIMARY KEY (chal_id)
            );

            ALTER TABLE TB_CHAL
                ADD FOREIGN KEY (song_id) REFERENCES $songTable (song_id) ON UPDATE CASCADE;
          ''');
      await db.execute('''
            CREATE TABLE TB_EXER
            (
                exer_id    INT, 
                song_id    INT, 
                exer_type  VARCHAR(45)     NOT NULL, 
                exer_path  VARCHAR(999)    NOT NULL, 
                exer_time  TIMESTAMP       NOT NULL, 
                PRIMARY KEY (exer_id)
            );

            ALTER TABLE TB_EXER
                ADD FOREIGN KEY (song_id) REFERENCES $songTable (song_id) ON UPDATE CASCADE;
          ''');
    }, onUpgrade: (db, oldVersion, newVersion) {});
  }

  // song query
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
        ? res.map((value) => SongModel(
            songId: value['song_id'],
            songTitle: value['song_title'],
            songPath: value['song_path'],
            songJangdan: value['song_jangdan'],
            songLike: value['song_like']))
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

  //===========================================================================
}
