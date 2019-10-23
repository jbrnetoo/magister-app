import 'dart:io';

import 'package:magister_mobile/data/helpers/HelperDisciplina.dart';
import 'package:magister_mobile/data/model/Curso.dart';
import 'package:flutter/material.dart';
import 'package:magister_mobile/data/views/DisciplinaPage.dart';

class Disciplina{

  Disciplina();

  int idDisc;
  String nomeDisc;
  int creditos;
  String tipoDisc;
  int horasObrig;
  int limiteFaltas;
  int idCurso;
  Curso curso;  
  String img;

  Disciplina.fromMap(Map map){
    idDisc = map[HelperDisciplina.idColumn];
    nomeDisc = map[HelperDisciplina.nomeColumn];
    creditos = map[HelperDisciplina.creditosColumn];
    tipoDisc = map[HelperDisciplina.tipoDiscColumn];
    horasObrig = map[HelperDisciplina.horasObrigColumn];
    limiteFaltas = map[HelperDisciplina.limiteFaltasColumn];
    //idCurso = map[HelperDisciplina.idCursoColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      HelperDisciplina.nomeColumn: nomeDisc,
      HelperDisciplina.creditosColumn: creditos,
      HelperDisciplina.tipoDiscColumn: tipoDisc,
      HelperDisciplina.horasObrigColumn: horasObrig,
      HelperDisciplina.limiteFaltasColumn: limiteFaltas,
     // HelperDisciplina.idCursoColumn: idCurso,
    };

    if(idDisc != null){
      map[HelperDisciplina.idColumn] = idDisc;
    }
    return map;
  }

  @override
  String toString() {
    return "Contact(id: $idDisc, nome: $nomeDisc, créditos: $creditos, tipoDisc: $tipoDisc, horasObrig: $horasObrig,"
    "limiteFaltas: $limiteFaltas)";
  }

}

// TextEditingController codigoDisciplinaController = TextEditingController();
// TextEditingController nomeDisciplinaController = TextEditingController();
// TextEditingController tipoDiscController = TextEditingController();
// TextEditingController horasObrigatoriasController = TextEditingController();
// TextEditingController limitesFaltasController = TextEditingController();

class Disciplinas extends StatefulWidget {

  Color color;
  Disciplinas({@required this.color});

  @override
  _DisciplinasState createState() => _DisciplinasState(color: color);
}

class _DisciplinasState extends State<Disciplinas> {
  HelperDisciplina helper = HelperDisciplina();
  List<Disciplina> disciplinas = List();
  Color color;
  _DisciplinasState({@required this.color});

  @override
  void initState() {
    super.initState();
    if(size() != 0){
      _getAllDisciplinas();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDisciplinaPage();
        },
        child: Icon(Icons.add),
        backgroundColor: color,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: disciplinas.length,
          itemBuilder: (context, index) {
            return _cursoCard(context, index);
          }),
    );
  }

  Widget _cursoCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 70.0,
                height: 70.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: disciplinas[index].img != null
                          ? FileImage(File(disciplinas[index].img))
                          : AssetImage("images/person.png")),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      disciplinas[index].nomeDisc ?? "",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "ID Disciplina: " + disciplinas[index].idDisc.toString() ?? "",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      "Tipo: " + disciplinas[index].tipoDisc ?? "",
                      style: TextStyle(fontSize: 18.0),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _showDisciplinaPage(disciplina: disciplinas[index]);
      },
    );
  }

  void _showDisciplinaPage({Disciplina disciplina}) async {
    final recDisciplina = await Navigator.push(context,
      MaterialPageRoute(builder: (context) => DisciplinaPage(disciplina: disciplina, color: color ))
      );
      if (recDisciplina != null) {
        if (disciplina != null) {
          await helper.update(recDisciplina);
        } else {
          await helper.save(recDisciplina);
        }
     _getAllDisciplinas();
    } 
  }

  void _getAllDisciplinas() {
    helper.getAll().then((list) {
      setState(() {
        disciplinas = list;
      });
    });
  }

  size() async {
   int number = await helper.getNumber();
   return number;
  }

}
