import 'package:magister_mobile/data/model/Disciplina.dart';
import 'package:magister_mobile/data/helpers/HelperBase.dart';
import 'package:sqflite/sqflite.dart';

class HelperDisciplina extends HelperBase<Disciplina> {
  static final String disciplinaTable = "tb_disciplina";
  static final String idColumn = "idColumn";
  static final String nomeColumn = "nomeColumn";
  static final String creditosColumn = "creditosColumn";
  static final String tipoDiscColumn = "tipoDiscColumn";
  static final String horasObrigColumn = "horasObrigColumn";
  static final String limiteFaltasColumn = "limiteFaltasColumn";
  static final String idCursoColumn = "idCursoColumn";
  static final HelperDisciplina _instance = HelperDisciplina.getInstance();

  factory HelperDisciplina() => _instance;
  HelperDisciplina.getInstance();

  @override
  Future<Disciplina> save(Disciplina disciplina) async {
    Database database = await db;
    disciplina.idDisc = await database.insert(disciplinaTable, disciplina.toMap());
    return disciplina;
  }

  @override
  Future<Disciplina> getFirst(int id) async {
    Database dbDisciplina = await db;
    List<Map> maps = await dbDisciplina.query(disciplinaTable,
        columns: [
          idColumn,
          nomeColumn,
          creditosColumn,
          tipoDiscColumn,
          horasObrigColumn,
          limiteFaltasColumn,
          idCursoColumn
        ],
        where: "$idColumn = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Disciplina.fromMap(maps.first);
    } else {
      return null;
    }
  }

  @override
  Future<int> delete(int id) async {
    Database database = await db;
    return await database.delete(disciplinaTable, 
    where: "$idColumn = ?", 
    whereArgs: [id]);
  }

  @override
  Future<List> getAll() async {
    Database database = await db;
    List listMap = await database.rawQuery("SELECT * FROM $disciplinaTable");
    List<Disciplina> listDisc = new List();
    for (Map m in listMap) {
      listDisc.add(Disciplina.fromMap(m)); 
    }
    return listDisc;
  }
  
  @override
  Future<int> update(Disciplina disc) async {
    Database database = await db;
    return database.update(disciplinaTable, disc.toMap(),
    where: "$idColumn = ?", 
    whereArgs: [disc.idDisc]);
  }

  @override
  Future<int> getNumber() async {
    Database database = await db;
    return Sqflite.firstIntValue(await database.rawQuery("SELECT COUNT(*) FROM $disciplinaTable"));
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }
}
