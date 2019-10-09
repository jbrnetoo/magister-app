import 'package:magister_mobile/data/helpers/HelperBase.dart';
import 'package:magister_mobile/data/helpers/HelperProfessor.dart';
import 'package:magister_mobile/data/model/Curso.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HelperCurso {
  static final String cursoTable = "tb_curso";
  static final String idCursoColumn = "idCurso";
  static final String nomeColumn = "nome";
  static final String totalCreditoColumn = "total_credito";
  static final String idCoordenadorColumn = "id_coordenador";
  static final HelperCurso _instance = HelperCurso.getInstance();

  Database _db;

  factory HelperCurso() => _instance;
  HelperCurso.getInstance();

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
    final path = join(databasesPath, "curso.db");

    return openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE IF NOT EXISTS $cursoTable($idCursoColumn INTEGER PRIMARY KEY, $nomeColumn TEXT, $totalCreditoColumn DOUBLE,"
          "$idCoordenadorColumn INTEGER,"
          "FOREIGN KEY($idCoordenadorColumn) REFERENCES ${HelperProfessor.professorTable}(${HelperProfessor.idColumn}))");
    });
  }

  @override
  Future<int> delete(int id) async {
    Database database = await db;
    return await database.delete(cursoTable, 
    where: "$id = ?", 
    whereArgs: [id]);
  }

  @override
  Future<List> getAll() async {
    Database database = await db;
    List listMap = await database.rawQuery("SELECT * FROM $cursoTable");
    List<Curso> listCursos = new List();
    for (Map m in listMap) {
      listCursos.add(Curso.fromMap(m)); 
    }
    return listCursos;
  }

  @override
  Future<Curso> getFirst(int id) async {
    Database database = await db;
    List<Map> maps = await database.query(cursoTable,
      columns: [idCursoColumn, nomeColumn, totalCreditoColumn, idCoordenadorColumn],
      where: "$idCursoColumn = ?",
      whereArgs: [id]);
    if(maps.length > 0){
      return Curso.fromMap(maps.first);
    } else {
      return null;
    }
  }

  @override
  Future<int> getNumber() async {
    Database database = await db;
    return Sqflite.firstIntValue(await database.rawQuery("SELECT COUNT(*) FROM $cursoTable"));
  }

  @override
  Future<Curso> save(Curso curso) async {
    Database database = await db;
    curso.idCurso = await database.insert(cursoTable, curso.toMap());
    return curso;
  }

  @override
  Future<int> update(Curso data) async {
    Database database = await db;
    return database.update(cursoTable, data.toMap(),
    where: "$idCursoColumn = ?", 
    whereArgs: [data.idCurso]);
  }
}
