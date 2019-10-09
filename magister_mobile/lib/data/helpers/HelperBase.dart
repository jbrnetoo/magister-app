import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class HelperBase<T> {
  static final String dataBaseName = "magister.db";
  Database _db;

  Future<Database> createTable();
  Future<T> getFirst(int id);
  Future<T> save(T curso);
  Future<int> delete(int id);
  Future<int> update(T data);
  Future<List> getAll();
  Future<int> getNumber();

  Future<Database> get db async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, dataBaseName);

    if (_db == null) {
      _db = await openDatabase(path, version: 1);
      return _db;
    }
    return _db;
  }

  
}
