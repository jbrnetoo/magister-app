import 'package:magister_mobile/data/helpers/HelperBase.dart';
import 'package:magister_mobile/data/model/Curso.dart';
import 'package:sqflite/sqflite.dart';

class HelperCurso extends HelperBase<Curso> {
  static final String cursoTable = "tb_curso";
  static final String idCursoColumn = "idCurso";
  static final String nomeColumn = "nome";
  static final String totalCreditoColumn = "total_credito";
  static final String idCoordenadorColumn = "id_coordenador";
  static final HelperCurso _instance = HelperCurso.getInstance();

  factory HelperCurso() => _instance;
  HelperCurso.getInstance();

  @override
  Future<Curso> save(Curso curso) async {
    Database database = await db;
    curso.idCurso = await database.insert(cursoTable, curso.toMap());
    return curso;
  }

  @override
   Future<Curso> getFirst(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(cursoTable,
        columns: [
          idCursoColumn,
          nomeColumn,
          totalCreditoColumn,
          idCoordenadorColumn
        ],
        where: "$idCursoColumn = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Curso.fromMap(maps.first);
    } else {
      return null;
    }
  }

  @override
  Future<int> delete(int id) async {
    Database database = await db;
    return await database.delete(cursoTable, 
    where: "$idCursoColumn = ?", 
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
  Future<int> update(Curso curso) async {
    Database database = await db;
    return database.update(cursoTable, curso.toMap(),
    where: "$idCursoColumn = ?", 
    whereArgs: [curso.idCurso]);
  }

  @override
  Future<int> getNumber() async {
    Database database = await db;
    return Sqflite.firstIntValue(await database.rawQuery("SELECT COUNT(*) FROM $cursoTable"));
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }
}
