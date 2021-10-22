import 'package:danso_db_pilot/db/db_helpers.dart';
import 'package:sqflite/sqflite.dart';

class DeleteDummy {
  DeleteDummy._();
  static final DeleteDummy _db = DeleteDummy._();
  factory DeleteDummy() => _db;

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await DBHelPer().initDB();
    return _database;
  }

  // 도전하기 더미 삭제
  deleteAllChal() async {
    final db = await database;
    db.rawDelete('DELETE FROM TB_CHAL');
  }

  // 연습하기 더미 삭제
  deleteAllExer() async {
    final db = await database;
    db.rawDelete('DELETE FROM TB_EXER');
  }
}
