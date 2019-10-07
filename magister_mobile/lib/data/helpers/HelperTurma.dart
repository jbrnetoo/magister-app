import 'package:magister_mobile/data/helpers/HelperBase.dart';
import 'package:magister_mobile/data/helpers/HelperDisciplina.dart';
import 'package:magister_mobile/data/helpers/HelperProfessor.dart';
import 'package:magister_mobile/data/model/Turma.dart';
import 'package:sqflite/sqflite.dart';

class HelperTurma extends HelperBase<Turma> {
  
  static final String turmaTable = "tb_turma";
  static final String anoColumn = "ano";
  static final String semestreColumn = "semestre";
  static final String qtdVagasColumn = "qtd_vagas";
  static final String idDisciColumn = "id_disc";
  static final String idProfColumn = "id_prof";
      
  static final HelperTurma _instance = HelperTurma.getInstance();


  factory HelperTurma() => _instance;
  HelperTurma.getInstance();

  @override
  Future<Database> createTable() async{
    return db.then((db){
      db.execute("CREATE TABLE IF NOT EXISTS $turmaTable({$anoColumn, $semestreColumn} INTEGER PRIMARY KEY, $qtdVagasColumn TEXT,"
       "FOREIGN KEY($idDisciColumn) REFERENCES ${HelperDisciplina.disciplinaTable}.(${HelperDisciplina.idColumn},"
             "FOREIGN KEY($idProfColumn) REFERENCES ${HelperProfessor.professorTable}.(${HelperProfessor.idColumn}))");
      
      return db;
    });
  
  }

  @override
  Future<int> delete(int id) async{
    return db.then((database) async{
     return await database.delete(turmaTable, where: "{$anoColumn, $semestreColumn} = ?", whereArgs: [id]);
    }); 
    
  }

  @override
  Future<List> getAll() async => db.then((database) async{
      List listMap = await database.rawQuery("SELECT * FROM $turmaTable");
      List<Turma> lista = List();
      for(Map m in listMap){
        lista.add(Turma.fromMap(m));
      }
      return lista;
   });

  @override
  Future<Turma> getFirst(int id) async => db.then((database) async{
    List<Map> maps = await database.query(turmaTable,
      columns: [anoColumn, semestreColumn, qtdVagasColumn, idDisciColumn, idProfColumn],
      where: "{$anoColumn, $semestreColumn} = ?",
      whereArgs: [id]);
    
    if(maps.length > 0){
      return Turma.fromMap(maps.first);
    } else {
      return null;
    }
      });

  @override
  Future<int> getNumber() async {
   return Sqflite.firstIntValue(
     await db.then((database){
        return database.rawQuery("SELECT COUNT(*) FROM $turmaTable");
     }));
  }

  @override
  Future<Turma> save(Turma turma) async {
     db.then((database) async{
     await database.insert(turmaTable, turma.toMap());
    });
    return null;
  }

  @override
  Future<int> update(Turma data) async => await db.then((database){
    return database.update(turmaTable,
        data.toMap(),
        where: "{$anoColumn, $semestreColumn} = ?",
        whereArgs: [data.ano]);
    });

    // Future<Database> get db async {
    // if(_db != null){
    //   return _db;
    // } else {
    //   _db = await createTable();
    //   return _db;
    // }
  }
