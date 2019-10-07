import 'package:magister_mobile/data/helpers/HelperDisciplina.dart';
import 'package:magister_mobile/data/model/Curso.dart';
import 'package:flutter/material.dart';

class Disciplina{

  Disciplina();

  int idDisc;
  String nomeDisc;
  double creditos;
  String tipoDisc;
  int horasObrig;
  int limiteFaltas;
  int idCurso;
  Curso curso;

  int getDisc(){return this.idDisc;}
  String getNomeDisc(){return this.nomeDisc;}
  double getCreditos(){return this.creditos;}
  String getTipoDisc(){return this.tipoDisc;}
  int getHorasObrig(){return this.horasObrig;}
  int getLimitesFaltas(){return this.limiteFaltas;}
  int getIdCurso(){return this.idCurso;}

  void setID(int idDisc){}
  void setNomeDisc(String nomeDisc){}
  void setCreditos(double creditos){}
  void setTipoDisc(String tipoDisc){}
  void setHorasObrig(int horasObrig){}
  void setLimiteFaltas(int limiteFaltas){}
  void setCurso(Curso curso){
    this.curso = curso;
    this.idCurso = this.curso.idCurso;
  }

  Disciplina.fromMap(Map map){
    idDisc = map[HelperDisciplina.idColumn];
    nomeDisc = map[HelperDisciplina.nomeColumn];
    creditos = map[HelperDisciplina.creditosColumn];
    tipoDisc = map[HelperDisciplina.tipoDiscColumn];
    horasObrig = map[HelperDisciplina.horasObrigColumn];
    limiteFaltas = map[HelperDisciplina.limiteFaltasColumn];
    idCurso = map[HelperDisciplina.idCursoColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      HelperDisciplina.nomeColumn: nomeDisc,
      HelperDisciplina.creditosColumn: creditos,
      HelperDisciplina.tipoDiscColumn: tipoDisc,
      HelperDisciplina.horasObrigColumn: horasObrig,
      HelperDisciplina.limiteFaltasColumn: limiteFaltas,
      HelperDisciplina.idCursoColumn: idCurso,
    };

    if(idDisc != null){
      map[HelperDisciplina.idColumn] = idDisc;
    }
    return map;
  }

  @override
  String toString() {
    return "Contact(id: $idDisc, nome: $nomeDisc, créditos: $creditos, tipoDisc: $tipoDisc, horasObrig: $horasObrig,"
    "limiteFaltas: $limiteFaltas, idCurso: $idCurso)";
  }

}

GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
TextEditingController codigoDisciplinaController = TextEditingController();
TextEditingController nomeDisciplinaController = TextEditingController();
TextEditingController creditosDiscController = TextEditingController();
TextEditingController horasObrigatoriasController = TextEditingController();
TextEditingController limitesFaltasController = TextEditingController();

class Disciplinas extends StatelessWidget {
  Color color;
  
  Disciplinas({@required this.color});

  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Código da Disciplina",
                          labelStyle:
                              TextStyle(color: color, fontSize: 20.0)),
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      controller: codigoDisciplinaController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira o código da disciplina!";
                        } else if (int.parse(value) < 0) {
                          return "Codigo inválido!";
                        }
                        return null;
                      }),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "Disciplina",
                          labelStyle:
                              TextStyle(color: color, fontSize: 20.0)),
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      controller: nomeDisciplinaController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira o nome da disciplina!";
                        }
                        return null;
                      }),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Créditos",
                          labelStyle:
                              TextStyle(color: color, fontSize: 20.0)),
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      controller: creditosDiscController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira a quantidade de créditos!";
                        }
                        return null;
                      }),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Quantidade de Horas Obrigatórias",
                          labelStyle:
                              TextStyle(color: color, fontSize: 20.0)),
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      controller: horasObrigatoriasController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira a quantidade de horas!";
                        }
                        return null;
                      }),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Limite de Faltas",
                          labelStyle:
                              TextStyle(color: color, fontSize: 20.0)),
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      controller: limitesFaltasController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira o limite de faltas!";
                        }
                        return null;
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: RaisedButton(
                      color: color,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          // salvar dados.
                        }
                      },
                      child: Text(
                        'Salvar',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  )
                ])));
  }
}