import 'dart:io';
import 'package:flutter/material.dart';
import 'package:magister_mobile/data/model/Professor.dart';

class ProfessorPage extends StatefulWidget {
  final Professor professor;
  ProfessorPage({this.professor}); //Entre chaves significa que é opcional

  @override
  _ProfessorPageState createState() => _ProfessorPageState(color: null);
}

class _ProfessorPageState extends State<ProfessorPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _nomeFocus = FocusNode();
  final _nomeController = TextEditingController();
  final _idController = TextEditingController();
  final _matriculaController = TextEditingController();

  Color color;
  bool _userEdited = false;
  Professor _editedProfessor;
  _ProfessorPageState({@required this.color});

  @override
  void initState() {
    super.initState();
    if (widget.professor == null) {
      _editedProfessor = new Professor();
    } else {
      _editedProfessor = Professor.fromMap(widget.professor.toMap());
      _nomeController.text = _editedProfessor.nome;
      _idController.text = _editedProfessor.id.toString();
      _matriculaController.text = _editedProfessor.matricula.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: color,
              title: Text(_editedProfessor.nome ??
                  "Novo Professor"), // O ?? significa se for null 'else'
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  if (_editedProfessor.nome != null &&
                      _editedProfessor.nome.isNotEmpty) {
                    Navigator.pop(context, _editedProfessor);
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
                                  image: _editedProfessor.img != null
                                      ? FileImage(File(_editedProfessor.img))
                                      : AssetImage("images/person.png"))),
                        ),
                      )),
                      TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: "Nome do Professor",
                              labelStyle: TextStyle(
                                  color: color, fontSize: 20.0)),
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                          controller: _nomeController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Insira o nome do professor!";
                            }
                            return null;
                          },
                          onChanged: (text) {
                            _userEdited = true;
                            setState(() {
                              _editedProfessor.nome = text;
                            });
                          }),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "ID do Professor",
                            labelStyle:
                                TextStyle(color: color, fontSize: 20.0)),
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                        controller: _idController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira o ID do professor!";
                          } else if (int.parse(value) < 0) {
                            return "ID inválido!";
                          }
                          return null;
                        },
                        onChanged: (text) {
                          _userEdited = true;
                          _editedProfessor.id = int.parse(text);
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Matrícula do Professor",
                            labelStyle:
                                TextStyle(color: color, fontSize: 20.0)),
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                        controller: _matriculaController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira a matrícula do professor!";
                          } else if (int.parse(value) < 0) {
                            return "Matrícula inválida!";
                          }
                          return null;
                        },
                        onChanged: (text) {
                          _userEdited = true;
                          _editedProfessor.matricula = int.parse(text);
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
