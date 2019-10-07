import 'package:magister_mobile/data/helpers/HelperBase.dart';
import 'package:magister_mobile/data/helpers/HelperCurso.dart';
import 'package:magister_mobile/data/model/Aluno.dart';
import 'package:sqflite/sqflite.dart';


class HelperAluno extends HelperBase<Aluno> {
  
  static final String alunoTable = "tb_aluno";
  static final String idColumn = "id";
  static final String nomeColumn = "nome_aluno";
  static final String totalCreditoColumn = "total_credito";
  static final String dtNascColumn = "id_data_nasc";
  static final String mgpColumn = "mgp";
  static final String idCursoColumn = "id";
      
  static final HelperAluno _instance = HelperAluno.getInstance();


  factory HelperAluno() => _instance;
  HelperAluno.getInstance();

  @override
  Future<Database> createTable() async{

    return db.then((db){
      db.execute("CREATE TABLE IF NOT EXISTS $alunoTable($idColumn INTEGER PRIMARY KEY, $nomeColumn TEXT,"
             "$dtNascColumn TEXT, $mgpColumn INTEGER)");
             //"FOREIGN KEY ($idCursoColumn) REFERENCES ${HelperCurso.cursoTable}(${HelperCurso.idCursoColumn}))");
      
      return db;
    });
  
  } 

  @override
  Future<int> delete(int id) async{
    return db.then((database) async{
     return await database.delete(alunoTable, where: "$idColumn = ?", whereArgs: [id]);
    }); 
    
  }

  @override
  Future<List> getAll() async { //=> db.then((database) async{
      Database database = await createTable();
      List listMap = await database.rawQuery("SELECT * FROM $alunoTable");
      List<Aluno> lista = List();
      for(Map m in listMap){
        lista.add(Aluno.fromMap(m));
      }
      return lista;
   }

  @override
  Future<Aluno> getFirst(int id) async => db.then((database) async{
    List<Map> maps = await database.query(alunoTable,
      columns: [idColumn, nomeColumn, totalCreditoColumn, dtNascColumn, mgpColumn, idCursoColumn],
      where: "$idColumn = ?",
      whereArgs: [id]);
    
    if(maps.length > 0){
      return Aluno.fromMap(maps.first);
    } else {
      return null;
    }
      });

  @override
  Future<int> getNumber() async {
   return Sqflite.firstIntValue(
     await db.then((database){
        return database.rawQuery("SELECT COUNT(*) FROM $alunoTable");
     }));
  }

  @override
  Future<Aluno> save(Aluno aluno) async {
     db.then((database) async{
     await database.insert(alunoTable, aluno.toMap());
    });
    return null;
  }

  @override
  Future<int> update(Aluno data) async => await db.then((database){
    return database.update(alunoTable,
        data.toMap(),
        where: "$idColumn = ?",
        whereArgs: [data.idAluno]);
    });
  }
