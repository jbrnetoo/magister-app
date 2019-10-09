import 'package:magister_mobile/data/helpers/HelperBase.dart';
import 'package:magister_mobile/data/model/Aluno.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'HelperCurso.dart';

class HelperAluno {

  static final String alunoTable = "tb_aluno";
  static final String idColumn = "idColumn";
  static final String nomeColumn = "nomeColumn";
  static final String totalCreditoColumn = "totalCreditoColumn";
  static final String dtNascColumn = "dtNascColumn";
  static final String mgpColumn = "mgpColumn";
  static final String idCursoColumn = "idCursoColumn";
  static final HelperAluno _instance = HelperAluno.getInstance();

  Database _db;

  factory HelperAluno() => _instance;

  HelperAluno.getInstance();

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
    final path = join(databasesPath, "aluno.db");

    return openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE IF NOT EXISTS $alunoTable($idColumn INTEGER PRIMARY KEY, $nomeColumn TEXT,"
          "$dtNascColumn TEXT, $mgpColumn DOUBLE)");
          // "FOREIGN KEY ($idCursoColumn) REFERENCES ${HelperCurso.cursoTable}(${HelperCurso.idCursoColumn}))");
    });
  }

  @override
  Future<int> delete(int id) async {
    Database database = await db;
    return await database.delete(alunoTable, 
    where: "$idColumn = ?", 
    whereArgs: [id]);
  }

  @override
  Future<List> getAll() async {
    Database database = await db;
    List listMap = await database.rawQuery("SELECT * FROM $alunoTable");
    List<Aluno> listaAlunos = List();
    for (Map m in listMap) {
      listaAlunos.add(Aluno.fromMap(m));
    }
    return listaAlunos;
  }

  @override
  Future<Aluno> getFirst(int id) async {
    Database database = await db;
    List<Map> maps = await database.query(alunoTable,
      columns: [idColumn, nomeColumn, totalCreditoColumn, dtNascColumn, mgpColumn, idCursoColumn],
      where: "$idColumn = ?",
      whereArgs: [id]);
    if(maps.length > 0){
      return Aluno.fromMap(maps.first);
    } else {
      return null;
    }
  }

  @override
  Future<int> getNumber() async {
     Database database = await db;
    return Sqflite.firstIntValue(await database.rawQuery("SELECT COUNT(*) FROM $alunoTable"));
  }

  @override
  Future<Aluno> save(Aluno aluno) async {
    Database database = await db;
    aluno.idAluno = await database.insert(alunoTable, aluno.toMap());
    return aluno;
  }

  @override
  Future<int> update(Aluno aluno) async {
    Database database = await db;
    return database.update(alunoTable, aluno.toMap(),
    where: "$idColumn = ?",
    whereArgs: [aluno.idAluno]);
  }
}
