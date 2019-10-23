import 'dart:io';
import 'package:flutter/material.dart';
import 'package:magister_mobile/data/model/Disciplina.dart';

class DisciplinaPage extends StatefulWidget {
  Color color;
  final Disciplina disciplina;
  DisciplinaPage({this.disciplina, this.color});

  @override
  _DisciplinaPageState createState() => _DisciplinaPageState(color: color);
}

class _DisciplinaPageState extends State<DisciplinaPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _nomeFocus = FocusNode();
  TextEditingController _codigoDisciplinaController = TextEditingController();
  TextEditingController _nomeDisciplinaController = TextEditingController();
  TextEditingController _creditoController = TextEditingController();
  TextEditingController _tipoDiscController = TextEditingController();
  TextEditingController _horasObrigatoriasController = TextEditingController();
  TextEditingController _limitesFaltasController = TextEditingController();

  Color color;
  _DisciplinaPageState({@required this.color});
  bool _userEdited = false;
  Disciplina _editedDisciplina;

  @override
  void initState() {
    super.initState();

    if (widget.disciplina == null) {
      _editedDisciplina = new Disciplina();
    } else {
      _editedDisciplina = Disciplina.fromMap(widget.disciplina.toMap());
      _nomeDisciplinaController.text = _editedDisciplina.nomeDisc;
      _codigoDisciplinaController.text = _editedDisciplina.idDisc.toString();
      _creditoController.text = _editedDisciplina.creditos.toString();
      _tipoDiscController.text = _editedDisciplina.tipoDisc.toString();
      _horasObrigatoriasController.text =
          _editedDisciplina.horasObrig.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: color,
              title: Text(
                _editedDisciplina
                        .nomeDisc ?? // O ?? significa se for null 'else'
                    "Nova Disciplina",
                style: TextStyle(fontFamily: "Kanit", fontSize: 25.0),
              ),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  if (_editedDisciplina.nomeDisc != null &&
                      _editedDisciplina.nomeDisc.isNotEmpty) {
                    Navigator.pop(context, _editedDisciplina);
                  } else {
                    FocusScope.of(context).requestFocus(_nomeFocus);
                  }
                }
              },
              child: Icon(Icons.save),
              backgroundColor: color,
            ),
            body: SingleChildScrollView(
                padding: EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      GestureDetector(
                          child: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Container(
                          width: 130.0,
                          height: 130.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: _editedDisciplina.img != null
                                      ? FileImage(File(_editedDisciplina.img))
                                      : AssetImage("images/person.png"))),
                        ),
                      )),
                      TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: "Nome da Disciplina",
                              labelStyle:
                                  TextStyle(color: color, fontSize: 20.0)),
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                          controller: _nomeDisciplinaController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Insira o nome da disciplina!";
                            }
                            return null;
                          },
                          onChanged: (text) {
                            _userEdited = true;
                            setState(() {
                              _editedDisciplina.nomeDisc = text;
                            });
                          }),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Código da Disciplina",
                            labelStyle:
                                TextStyle(color: color, fontSize: 20.0)),
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                        controller: _codigoDisciplinaController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira o código da disciplina!";
                          } else if (int.parse(value) < 0) {
                            return "Código inválido!";
                          }
                          return null;
                        },
                        onChanged: (text) {
                          _userEdited = true;
                          _editedDisciplina.idCurso = int.parse(text);
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Total de Creditos da Disciplina",
                            labelStyle:
                                TextStyle(color: color, fontSize: 20.0)),
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                        controller: _creditoController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira o total de creditos!";
                          } else if (int.parse(value) < 0.0) {
                            return "Inserção inválida!";
                          }
                          return null;
                        },
                        onChanged: (text) {
                          _userEdited = true;
                          _editedDisciplina.creditos = int.parse(text);
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: "Tipo da Disciplina",
                            labelStyle:
                                TextStyle(color: color, fontSize: 20.0)),
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                        controller: _tipoDiscController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira o tipo da disciplina!";
                          }
                          return null;
                        },
                        onChanged: (text) {
                          _userEdited = true;
                          _editedDisciplina.tipoDisc = text;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Horas Obrigatórias",
                            labelStyle:
                                TextStyle(color: color, fontSize: 20.0)),
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                        controller: _horasObrigatoriasController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira a quantidade de horas!";
                          } else if (int.parse(value) < 0.0) {
                            return "Inserção inválida!";
                          }
                          return null;
                        },
                        onChanged: (text) {
                          _userEdited = true;
                          _editedDisciplina.horasObrig = int.parse(text);
                        },
                      ),
                    ],
                  ),
                ))));
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar Alterações"),
              content: Text("Se sair as alterações serão perdidas."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
