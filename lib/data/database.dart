import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  late Database db;

  Future<void> initDatabase() async {
    print("/////////////////////////");
    String path = join(await getDatabasesPath(), 'wallet.db');
    db = await openDatabase(path, version: 1,
        onCreate: (database, version) async {
      await database.execute(
          'CREATE TABLE transactions (id INTEGER PRIMARY KEY, title TEXT, content TEXT, amount REAL, date TEXT)');
      print("Database created and table initialized");
    });
  }

  Future<void> insertTransaction(
      String title, String content, double amount, String date) async {
    print("************************");
    await db.transaction((txn) async {
      int id = await txn.rawInsert(
          'INSERT INTO transactions(title, content, amount, date) VALUES(?, ?, ?, ?)',
          [title, content, amount, date]);
      print('Inserted transaction with id: $id');
    });
  }

  Future<List<Map<String, dynamic>>> getAllTransactions() async {
    return await db.rawQuery('SELECT * FROM transactions');
  }
}
