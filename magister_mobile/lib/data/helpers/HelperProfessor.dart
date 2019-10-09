import 'package:magister_mobile/data/helpers/HelperBase.dart';
import 'package:magister_mobile/data/model/Professor.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HelperProfessor extends HelperBase<Professor> {

  static final String professorTable = "tb_professor";
  static final String idColumn = "id";
  static final String nomeColumn = "nome";
  static final String matriculaColumn = "matricula";
  
  Database _db;
  
  static final HelperProfessor _instance = HelperProfessor.getInstance();

  factory HelperProfessor() => _instance;
  HelperProfessor.getInstance();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await createTable();
      return _db;
    }
  }

  @override
  Future<Database> createTable() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, HelperBase.dataBaseName);

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE IF NOT EXIST $professorTable($idColumn INTEGER PRIMARY KEY, $nomeColumn TEXT, $matriculaColumn INTEGER)");
    });
  }

@override
  Future<Professor> save(Professor professor) async {
    Database database = await db;
    professor.id = await database.insert(professorTable, professor.toMap());
    return professor;
  }

@override
  Future<Professor> getFirst(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(professorTable,
        columns: [
          idColumn,
          nomeColumn,
          matriculaColumn
        ],
        where: "$idColumn = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Professor.fromMap(maps.first);
    } else {
      return null;
    }
  }

@override
  Future<int> delete(int id) async {
    Database dbProfessor = await db;
    return await dbProfessor
        .delete(professorTable, where: "$idColumn = ?", whereArgs: [id]);
  }

@override
  Future<int> update(Professor professor) async {
    Database dbContact = await db;
    return await dbContact.update(professorTable, professor.toMap(),
        where: "$idColumn = ?", whereArgs: [professor.id]);
  }

@override
  Future<List> getAll() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $professorTable");
    List<Professor> listProf = List();
    for (Map m in listMap) {
      listProf.add(Professor.fromMap(m));
    }
    return listProf;
  }

@override
  Future<int> getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT COUNT(*) FROM $professorTable"));
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }
}
