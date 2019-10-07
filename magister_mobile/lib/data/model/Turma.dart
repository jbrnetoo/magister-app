import 'package:magister_mobile/data/helpers/HelperTurma.dart';
import 'package:flutter/material.dart';

class Turma{

  Turma();

  int ano;
  int semestre;
  int idDisc;
  int qtdVagas;
  int idProf;

  int getAno(){return this.ano;}
  int getSemestre(){return this.semestre;}
  int getIdDisc(){return this.idDisc;}
  int getQtdVagas(){return this.qtdVagas;}
  int getIdProf(){return this.idProf;}

  void setAno(int ano){}
  void setSemestre(int semestre){}
  void setIdDisc(int idDisc){}
  void setQtdVagas(int qtdVagas){}
  void setIdProf(int idProf){}

  Turma.fromMap(Map map){
    ano = map[HelperTurma.anoColumn];
    semestre = map[HelperTurma.semestreColumn];
    qtdVagas = map[HelperTurma.qtdVagasColumn];
    idDisc = map[HelperTurma.idDisciColumn];
    idDisc = map[HelperTurma.idProfColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      HelperTurma.anoColumn: ano,
      HelperTurma.semestreColumn: semestre,
      HelperTurma.qtdVagasColumn: qtdVagas,
      HelperTurma.idDisciColumn: idDisc,
      HelperTurma.idProfColumn: idProf,
    };

    if(ano != null){
      map[HelperTurma.anoColumn] = ano;
    }
    return map;
  }

  @override
  String toString() {
    return "Contact(ano: $ano, semestre: $semestre, qtdVagas: $qtdVagas, idDisc: $idDisc, idProf: $idProf)";
  }
  
}

GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
TextEditingController anoController = TextEditingController();
TextEditingController semestreController = TextEditingController();
TextEditingController qtdVagasController = TextEditingController();
TextEditingController idDiscController = TextEditingController();
TextEditingController idProfController = TextEditingController();

class Turmas extends StatelessWidget {
  Color color;

  Turmas({@required this.color});

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
                          labelText: "Ano",
                          labelStyle:
                              TextStyle(color: color, fontSize: 20.0)),
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      controller: anoController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira o Ano!";
                        }
                        return null;
                      }),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Semestre",
                          labelStyle:
                              TextStyle(color: color, fontSize: 20.0)),
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      controller: semestreController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira o semestre!";
                        }
                        return null;
                      }),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Quantidade de Vagas",
                          labelStyle:
                              TextStyle(color: color, fontSize: 20.0)),
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      controller: qtdVagasController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira a quantidade de vagas!";
                        }
                        return null;
                      }),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "ID da Disciplina",
                          labelStyle:
                              TextStyle(color: color, fontSize: 20.0)),
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      controller: idDiscController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira o ID da disciplina!";
                        }
                        return null;
                      }),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "ID do Professor",
                          labelStyle:
                              TextStyle(color: color, fontSize: 20.0)),
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      controller: idProfController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira o ID do professor!";
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