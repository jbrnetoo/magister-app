import 'package:magister_mobile/data/model/Disciplina.dart';
import 'package:magister_mobile/data/helpers/HelperBase.dart';
import 'package:magister_mobile/data/helpers/HelperCurso.dart';
import 'package:sqflite/sqflite.dart';


class HelperDisciplina extends HelperBase<Disciplina> {
  
  static final String disciplinaTable = "tb_disciplina";
  static final String idColumn = "id_disciplina";
  static final String nomeColumn = "nome_disciplina";
  static final String creditosColumn = "creditos";
  static final String tipoDiscColumn = "tipo_disc";
  static final String horasObrigColumn = "horas_obrigatorias";
  static final String limiteFaltasColumn = "limite_faltas";
  static final String idCursoColumn = "id_curso";
      
  static final HelperDisciplina _instance = HelperDisciplina.getInstance();


  factory HelperDisciplina() => _instance;
  HelperDisciplina.getInstance();

  @override
  Future<Database> createTable() async{
    return db.then((db){
      db.execute("CREATE TABLE IF NOT EXISTS $disciplinaTable($idColumn INTEGER PRIMARY KEY, $nomeColumn TEXT, $creditosColumn DOUBLE,"
             "$tipoDiscColumn TEXT, $horasObrigColumn INTEGER, $limiteFaltasColumn INTEGER,"
             "FOREIGN KEY($idCursoColumn) REFERENCES ${HelperCurso.cursoTable}.(${HelperCurso.idCursoColumn}))");
      
      return db;
    });
  
  }

  @override
  Future<int> delete(int id) async{
    return db.then((database) async{
     return await database.delete(disciplinaTable, where: "$idColumn = ?", whereArgs: [id]);
    }); 
    
  }

  @override
  Future<List> getAll() async => db.then((database) async{
      List listMap = await database.rawQuery("SELECT * FROM $disciplinaTable");
      List<Disciplina> lista = List();
      for(Map m in listMap){
        lista.add(Disciplina.fromMap(m));
      }
      return lista;
   });

  @override
  Future<Disciplina> getFirst(int id) async => db.then((database) async{
    List<Map> maps = await database.query(disciplinaTable,
      columns: [idColumn, nomeColumn, creditosColumn, tipoDiscColumn, horasObrigColumn, limiteFaltasColumn, idCursoColumn],
      where: "$idColumn = ?",
      whereArgs: [id]);
    
    if(maps.length > 0){
      return Disciplina.fromMap(maps.first);
    } else {
      return null;
    }
      });

  @override
  Future<int> getNumber() async {
   return Sqflite.firstIntValue(
     await db.then((database){
        return database.rawQuery("SELECT COUNT(*) FROM $disciplinaTable");
     }));
  }

  @override
  Future<Disciplina> save(Disciplina disciplina) async {
     db.then((database) async{
     await database.insert(disciplinaTable, disciplina.toMap());
    });
    return null;
  }

  @override
  Future<int> update(Disciplina data) async => await db.then((database){
    return database.update(disciplinaTable,
        data.toMap(),
        where: "$idColumn = ?",
        whereArgs: [data.idDisc]);
    });

    // Future<Database> get db async {
    // if(_db != null){
    //   return _db;
    // } else {
    //   _db = await createTable();
    //   return _db;
    // }
  }