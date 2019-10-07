import 'package:magister_mobile/data/helpers/HelperCurso.dart';
import 'Professor.dart';
import 'package:flutter/material.dart';

class Curso {
  int idCurso;
  String nome;
  double totalCreditos;
  int idCoordenador;
  Professor coordenadaor;

  Curso();

  Curso.fromMap(Map map) {
    idCurso = map[HelperCurso.idCursoColumn];
    nome = map[HelperCurso.nomeColumn];
    totalCreditos = map[HelperCurso.totalCreditoColumn];
    idCoordenador = map[HelperCurso.idCoordenadorColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      HelperCurso.nomeColumn: nome,
      HelperCurso.totalCreditoColumn: totalCreditos,
      HelperCurso.idCoordenadorColumn: idCoordenador,
    };

    if (idCurso != null) {
      map[HelperCurso.idCursoColumn] = idCurso;
    }
    return map;
  }

  @override
  String toString() {
    return "Contact(id: $idCurso, nome: $nome, créditos: $totalCreditos, coordenador: $idCoordenador)";
  }
}

GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
TextEditingController idCursoController = TextEditingController();
TextEditingController nomeCursoController = TextEditingController();
TextEditingController idCoordenadorController = TextEditingController();

class Cursos extends StatelessWidget {
  Color color;

  Cursos({@required this.color});

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
                          labelText: "ID do Curso",
                          labelStyle: TextStyle(color: color, fontSize: 20.0)),
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      controller: idCursoController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira o ID do curso!";
                        } else if (int.parse(value) < 0) {
                          return "ID inválido!";
                        }
                        return null;
                      }),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "Curso",
                          labelStyle: TextStyle(color: color, fontSize: 20.0)),
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      controller: nomeCursoController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira o nome do curso!";
                        }
                        return null;
                      }),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "ID do Coordenador",
                          labelStyle: TextStyle(color: color, fontSize: 20.0)),
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      controller: idCoordenadorController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira o ID do coordenador!";
                        } else if (int.parse(value) < 0) {
                          return "ID inválido!";
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
                ]
              )
            )
          );
  }
}
