import 'package:magister_mobile/data/helpers/HelperBase.dart';
import 'package:magister_mobile/data/model/PeriodoLetivo.dart';
import 'package:sqflite/sqflite.dart';

class HelperPeriodoLetivo extends HelperBase<PeriodoLetivo> {
  
  static final String periodoLetivoTable = "tb_periodo_letivo";
  static final String anoColumn = "ano";
  static final String semestreColumn = "semestre";
  static final String dtInicioColumn = "dat_inicio";
  static final String dtFimColumn = "dat_fim";
      
  static final HelperPeriodoLetivo _instance = HelperPeriodoLetivo.getInstance();


  factory HelperPeriodoLetivo() => _instance;
  HelperPeriodoLetivo.getInstance();

  @override
  Future<Database> createTable() async{
    return db.then((db){
      db.execute("CREATE TABLE IF NOT EXISTS $periodoLetivoTable({$anoColumn, $semestreColumn} INTEGER PRIMARY KEY, $dtInicioColumn TEXT,"
       "$dtFimColumn TEXT)");      
      return db;
    });
  
  }

  @override
  Future<int> delete(int id) async{
    return db.then((database) async{
     return await database.delete(periodoLetivoTable, where: "{$anoColumn, $semestreColumn} = ?", whereArgs: [id]);
    }); 
    
  }

  @override
  Future<List> getAll() async => db.then((database) async{
      List listMap = await database.rawQuery("SELECT * FROM $periodoLetivoTable");
      List<PeriodoLetivo> lista = List();
      for(Map m in listMap){
        lista.add(PeriodoLetivo.fromMap(m));
      }
      return lista;
   });

  @override
  Future<PeriodoLetivo> getFirst(int id) async => db.then((database) async{
    List<Map> maps = await database.query(periodoLetivoTable,
      columns: [anoColumn, semestreColumn, dtInicioColumn, dtFimColumn],
      where: "{$anoColumn, $semestreColumn} = ?",
      whereArgs: [id]);
    
    if(maps.length > 0){
      return PeriodoLetivo.fromMap(maps.first);
    } else {
      return null;
    }
      });

  @override
  Future<int> getNumber() async {
   return Sqflite.firstIntValue(
     await db.then((database){
        return database.rawQuery("SELECT COUNT(*) FROM $periodoLetivoTable");
     }));
  }

  @override
  Future<PeriodoLetivo> save(PeriodoLetivo periodoLetivo) async {
     db.then((database) async{
     await database.insert(periodoLetivoTable, periodoLetivo.toMap());
    });
    return null;
  }

  @override
  Future<int> update(PeriodoLetivo data) async => await db.then((database){
    return database.update(periodoLetivoTable,
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
