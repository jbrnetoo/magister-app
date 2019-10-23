import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:magister_mobile/data/helpers/HelperAluno.dart';
import 'package:magister_mobile/data/helpers/HelperCurso.dart';
import 'package:magister_mobile/data/helpers/HelperDisciplina.dart';
import 'package:magister_mobile/data/helpers/HelperProfessor.dart';
import 'package:magister_mobile/data/helpers/HelperPeriodoLetivo.dart';

abstract class HelperBase<T> {
  static final String dataBaseName = "magister.db";
  Database _database;

  Future<T> getFirst(int id);
  Future<T> save(T curso);
  Future<int> delete(int id);
  Future<int> update(T data);
  Future<List> getAll();
  Future<int> getNumber();

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _create();
      return _database;
    }
  }

  // Future<Database> initDb() async {
  //   final databasesPath = await getDatabasesPath();
  //   final path = join(databasesPath, dataBaseName);

  //   return await openDatabase(path, version: 1, onCreate: _create);
  // }

  Future<Database> _create() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, dataBaseName);

    return openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
        "CREATE TABLE IF NOT EXISTS ${HelperProfessor.professorTable}(${HelperProfessor.idColumn} INTEGER PRIMARY KEY,"
        "${HelperProfessor.nomeColumn} TEXT, ${HelperProfessor.matriculaColumn} INTEGER)");
     
      await db.execute(
          "CREATE TABLE IF NOT EXISTS ${HelperCurso.cursoTable}(${HelperCurso.idCursoColumn} INTEGER PRIMARY KEY, ${HelperCurso.nomeColumn} TEXT,"
          "${HelperCurso.totalCreditoColumn} INTEGER, ${HelperCurso.idCoordenadorColumn} INTEGER, FOREIGN KEY(${HelperCurso.idCoordenadorColumn})"
          "REFERENCES ${HelperProfessor.professorTable}(${HelperProfessor.idColumn}))");
     
      await db.execute(
          "CREATE TABLE IF NOT EXISTS ${HelperAluno.alunoTable}(${HelperAluno.idColumn} INTEGER PRIMARY KEY, ${HelperAluno.nomeColumn} TEXT,"
          "${HelperAluno.totalCreditoColumn} INTEGER, ${HelperAluno.dtNascColumn} TEXT, ${HelperAluno.mgpColumn} DOUBLE, ${HelperAluno.idCursoColumn} INTEGER,"
          "FOREIGN KEY(${HelperAluno.idCursoColumn}) REFERENCES ${HelperCurso.cursoTable}(${HelperCurso.idCursoColumn}))");
      
      await db.execute(
          "CREATE TABLE IF NOT EXISTS ${HelperPeriodoLetivo.periodoLetivoTable}(${HelperPeriodoLetivo.anoColumn} INTEGER,"
          "${HelperPeriodoLetivo.semestreColumn} INTEGER, ${HelperPeriodoLetivo.dtInicioColumn} TEXT, ${HelperPeriodoLetivo.dtFimColumn} TEXT,"
          "PRIMARY KEY(${HelperPeriodoLetivo.anoColumn}, ${HelperPeriodoLetivo.semestreColumn}))");
      
      await db.execute(
          "CREATE TABLE IF NOT EXISTS ${HelperDisciplina.disciplinaTable}(${HelperDisciplina.idColumn} INTEGER PRIMARY KEY,"
           "${HelperDisciplina.nomeColumn} TEXT, ${HelperDisciplina.creditosColumn} INTEGER, ${HelperDisciplina.tipoDiscColumn} TEXT,"
           "${HelperDisciplina.horasObrigColumn} INTEGER, ${HelperDisciplina.limiteFaltasColumn} INTEGER, ${HelperDisciplina.idCursoColumn} INTEGER,"
           "FOREIGN KEY(${HelperDisciplina.idCursoColumn}) REFERENCES ${HelperCurso.cursoTable}(${HelperCurso.idCursoColumn}))");});
   
  }
}
