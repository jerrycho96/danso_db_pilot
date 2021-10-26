import 'package:danso_db_pilot/db/db_helpers.dart';
import 'package:danso_db_pilot/models/models.dart';
import 'package:sqflite/sqflite.dart';

class Dummy {
  Dummy._();
  static final Dummy _db = Dummy._();
  factory Dummy() => _db;

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await DBHelPer().initDB();
    return _database;
  }

  // frequency query -> TB_USER
  //===========================================================================

  // insert dummy data
  insertFrDummy(UserModel user) async {
    final db = await database;
    await db.rawInsert('INSERT INTO TB_USER (standard_fr) VALUES(223.012345)');
  }

  // song query -> TB_SONG
  //===========================================================================

  // insert song dummy data
  insertSongDummy() async {
    final db = await database;
    await db.rawInsert(
        "INSERT INTO TB_SONG (song_title, song_path, song_jangdan, song_like) VALUES ('song_title 01', 'song_path 01', 'song_jangdan 01', 'song_like 01')");
    await db.rawInsert(
        "INSERT INTO TB_SONG (song_title, song_path, song_jangdan, song_like) VALUES ('song_title 02', 'song_path 02', 'song_jangdan 02', 'song_like 02')");
    await db.rawInsert(
        "INSERT INTO TB_SONG (song_title, song_path, song_jangdan, song_like) VALUES ('song_title 03', 'song_path 03', 'song_jangdan 03', 'song_like 03')");
    await db.rawInsert(
        "INSERT INTO TB_SONG (song_title, song_path, song_jangdan, song_like) VALUES ('song_title 04', 'song_path 04', 'song_jangdan 04', 'song_like 04')");
    await db.rawInsert(
        "INSERT INTO TB_SONG (song_title, song_path, song_jangdan, song_like) VALUES ('song_title 05', 'song_path 05', 'song_jangdan 05', 'song_like 05')");
    await db.rawInsert(
        "INSERT INTO TB_SONG (song_title, song_path, song_jangdan, song_like) VALUES ('song_title 06', 'song_path 06', 'song_jangdan 06', 'song_like 06')");
    await db.rawInsert(
        "INSERT INTO TB_SONG (song_title, song_path, song_jangdan, song_like) VALUES ('song_title 07', 'song_path 07', 'song_jangdan 07', 'song_like 07')");
    await db.rawInsert(
        "INSERT INTO TB_SONG (song_title, song_path, song_jangdan, song_like) VALUES ('song_title 08', 'song_path 08', 'song_jangdan 08', 'song_like 08')");
    await db.rawInsert(
        "INSERT INTO TB_SONG (song_title, song_path, song_jangdan, song_like) VALUES ('song_title 09', 'song_path 09', 'song_jangdan 09', 'song_like 09')");
    await db.rawInsert(
        "INSERT INTO TB_SONG (song_title, song_path, song_jangdan, song_like) VALUES ('song_title 10', 'song_path 10', 'song_jangdan 10', 'song_like 10')");
  }

  // challange query -> TB_CHAL
  //===========================================================================

  // insert challange dummy data
  insertChalDummy() async {
    final db = await database;
    await db.rawInsert(
        "INSERT INTO TB_CHAL (song_id, chal_score, chal_time) VALUES (01, 11, ?);",
        [DateTime.now().toString()]);
    await db.rawInsert(
        "INSERT INTO TB_CHAL (song_id, chal_score, chal_time) VALUES (01, 100, ?);",
        [DateTime.now().toString()]);
    await db.rawInsert(
        "INSERT INTO TB_CHAL (song_id, chal_score, chal_time) VALUES (02, 22, ?);",
        [DateTime.now().toString()]);
    await db.rawInsert(
        "INSERT INTO TB_CHAL (song_id, chal_score, chal_time) VALUES (03, 33, ?);",
        [DateTime.now().toString()]);
    await db.rawInsert(
        "INSERT INTO TB_CHAL (song_id, chal_score, chal_time) VALUES (04, 44, ?);",
        [DateTime.now().toString()]);
    await db.rawInsert(
        "INSERT INTO TB_CHAL (song_id, chal_score, chal_time) VALUES (05, 55, ?);",
        [DateTime.now().toString()]);
    await db.rawInsert(
        "INSERT INTO TB_CHAL (song_id, chal_score, chal_time) VALUES (06, 66, ?);",
        [DateTime.now().toString()]);
    await db.rawInsert(
        "INSERT INTO TB_CHAL (song_id, chal_score, chal_time) VALUES (07, 77, ?);",
        [DateTime.now().toString()]);
    await db.rawInsert(
        "INSERT INTO TB_CHAL (song_id, chal_score, chal_time) VALUES (08, 88, ?);",
        [DateTime.now().toString()]);
    await db.rawInsert(
        "INSERT INTO TB_CHAL (song_id, chal_score, chal_time) VALUES (09, 99, ?);",
        [DateTime.now().toString()]);
    await db.rawInsert(
        "INSERT INTO TB_CHAL (song_id, chal_score, chal_time) VALUES (10, 100, ?);",
        [DateTime.now().toString()]);
  }

  // exercise query -> TB_EXER
  //===========================================================================

  // insert exercise dummy data
  insertExerDummy() async {
    final db = await database;
    await db.rawInsert(
        "INSERT INTO TB_EXER (song_id, exer_type, exer_path, exer_time) VALUES (01, 'sound', 'exer_path 01', ?);",
        [DateTime.now().toString()]);
    await db.rawInsert(
        "INSERT INTO TB_EXER (song_id, exer_type, exer_path, exer_time) VALUES (02, 'sound', 'exer_path 02', ?);",
        [DateTime.now().toString()]);
    await db.rawInsert(
        "INSERT INTO TB_EXER (song_id, exer_type, exer_path, exer_time) VALUES (03, 'sound', 'exer_path 03', ?);",
        [DateTime.now().toString()]);
    await db.rawInsert(
        "INSERT INTO TB_EXER (song_id, exer_type, exer_path, exer_time) VALUES (04, 'video', 'exer_path 04', ?);",
        [DateTime.now().toString()]);
    await db.rawInsert(
        "INSERT INTO TB_EXER (song_id, exer_type, exer_path, exer_time) VALUES (05, 'sound', 'exer_path 05', ?);",
        [DateTime.now().toString()]);
    await db.rawInsert(
        "INSERT INTO TB_EXER (song_id, exer_type, exer_path, exer_time) VALUES (06, 'sound', 'exer_path 06', ?);",
        [DateTime.now().toString()]);
    await db.rawInsert(
        "INSERT INTO TB_EXER (song_id, exer_type, exer_path, exer_time) VALUES (07, 'sound', 'exer_path 07', ?);",
        [DateTime.now().toString()]);
    await db.rawInsert(
        "INSERT INTO TB_EXER (song_id, exer_type, exer_path, exer_time) VALUES (08, 'video', 'exer_path 08', ?);",
        [DateTime.now().toString()]);
    await db.rawInsert(
        "INSERT INTO TB_EXER (song_id, exer_type, exer_path, exer_time) VALUES (09, 'video', 'exer_path 09', ?);",
        [DateTime.now().toString()]);
    await db.rawInsert(
        "INSERT INTO TB_EXER (song_id, exer_type, exer_path, exer_time) VALUES (10, 'video', 'exer_path 10', ?);",
        [DateTime.now().toString()]);
  }
}
