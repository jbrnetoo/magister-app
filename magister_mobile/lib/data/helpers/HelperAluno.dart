import 'package:magister_mobile/data/helpers/HelperBase.dart';
import 'package:magister_mobile/data/model/Aluno.dart';
import 'package:sqflite/sqflite.dart';

class HelperAluno extends HelperBase<Aluno> {

  static final String alunoTable = "tb_aluno";
  static final String idColumn = "idColumn";
  static final String nomeColumn = "nomeColumn";
  static final String totalCreditoColumn = "totalCreditoColumn";
  static final String dtNascColumn = "dtNascColumn";
  static final String mgpColumn = "mgpColumn";
  static final String idCursoColumn = "idCursoColumn";
  static final HelperAluno _instance = HelperAluno.getInstance();

  factory HelperAluno() => _instance;
  HelperAluno.getInstance();

  @override
  Future<Aluno> save(Aluno aluno) async {
    Database database = await db;
    aluno.idAluno = await database.insert(alunoTable, aluno.toMap());
    return aluno;
  }

  @override
  Future<Aluno> getFirst(int id) async {
    Database dbAluno = await db;
    List<Map> maps = await dbAluno.query(alunoTable,
        columns: [
          idColumn,
          nomeColumn,
          totalCreditoColumn,
          dtNascColumn,
          mgpColumn,
          idCursoColumn
        ],
        where: "$idColumn = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Aluno.fromMap(maps.first);
    } else {
      return null;
    }
  }

  @override
  Future<int> delete(int id) async {
    Database dbAluno = await db;
    return await dbAluno
        .delete(alunoTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  @override
  Future<int> update(Aluno aluno) async {
    Database database = await db;
    return database.update(alunoTable, aluno.toMap(),
    where: "$idColumn = ?",
    whereArgs: [aluno.idAluno]);
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
  Future<int> getNumber() async {
     Database database = await db;
    return Sqflite.firstIntValue(
      await database.rawQuery("SELECT COUNT(*) FROM $alunoTable"));
  }

  @override
  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }

}
