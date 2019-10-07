import 'package:magister_mobile/data/helpers/HelperPeriodoLetivo.dart';
import 'package:flutter/material.dart';

class PeriodoLetivo{
  int ano;
  int semestre;
  DateTime datInicio;
  DateTime datFim;

  int getAno(){return this.ano;}
  int getSemestre(){return this.semestre;}
  DateTime getDatInicio(){return this.datInicio;}
  DateTime getDatFim(){return this.datFim;}

  void setAno(int ano){}
  void setSemetre(int semestre){}
  void setDatInicio(DateTime datInicio){}
  void setDatFim(DateTime datFim){}

  PeriodoLetivo.fromMap(Map map){
    ano = map[HelperPeriodoLetivo.anoColumn];
    semestre = map[HelperPeriodoLetivo.semestreColumn];
    datInicio = map[HelperPeriodoLetivo.dtInicioColumn];
    datFim = map[HelperPeriodoLetivo.dtFimColumn];

  }

  Map toMap() {
    Map<String, dynamic> map = {
      HelperPeriodoLetivo.anoColumn: ano,
      HelperPeriodoLetivo.semestreColumn: semestre,
      HelperPeriodoLetivo.dtInicioColumn: datInicio,
      HelperPeriodoLetivo.dtFimColumn: datFim,
    };

    if(ano != null){
      map[HelperPeriodoLetivo.anoColumn] = ano;
    }
    return map;
  }

  @override
  String toString() {
    return "Contact(ano: $ano, semestre: $semestre, dataInicio: $datInicio, datFim: $datFim)";
  }
  
}


GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
TextEditingController anoController = TextEditingController();
TextEditingController semestreController = TextEditingController();
TextEditingController dataInicioController = TextEditingController();
TextEditingController dataFimController = TextEditingController();

class PeriodoLetivos extends StatelessWidget {
  Color color;

  PeriodoLetivos({@required this.color});

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
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                          labelText: "Data de Inicio",
                          labelStyle:
                              TextStyle(color: color, fontSize: 20.0)),
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      controller: dataInicioController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira a data de inicio!";
                        }
                        return null;
                      }),
                  TextFormField(
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                          labelText: "Data de Fim",
                          labelStyle:
                              TextStyle(color: color, fontSize: 20.0)),
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      controller: dataFimController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira a data de fim!";
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