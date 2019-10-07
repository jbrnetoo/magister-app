import 'dart:io';
import 'package:flutter/material.dart';
import 'package:magister_mobile/data/model/Aluno.dart';

class AlunoPage extends StatefulWidget {
  final Aluno aluno;
  AlunoPage({this.aluno}); //Entre chaves significa que é opcional

  @override
  _AlunoPageState createState() => _AlunoPageState(color: null);
}

class _AlunoPageState extends State<AlunoPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _nomeFocus = FocusNode();
  final _nomeAlunoController = TextEditingController();
  final _idAlunoController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _idCurso = TextEditingController();
  final _mgpAlunoController = TextEditingController();

  Color color;
  bool _userEdited = false;
  Aluno _editedAluno;
  _AlunoPageState({@required this.color});

  @override
  void initState() {
    super.initState();

    if (widget.aluno == null) {
      _editedAluno = new Aluno();
    } else {
      _editedAluno = Aluno.fromMap(widget.aluno.toMap());
      _nomeAlunoController.text = _editedAluno.nomeAluno;
      _idAlunoController.text = _editedAluno.idAluno.toString();
      _dataNascimentoController.text = _editedAluno.datNasc.toString();
      _idCurso.text = _editedAluno.idCurso.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: color,
              title: Text(_editedAluno.nomeAluno ??
                  "Novo Aluno"), // O ?? significa se for null 'else'
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  if (_editedAluno.nomeAluno != null &&
                      _editedAluno.nomeAluno.isNotEmpty) {
                    Navigator.pop(context, _editedAluno);
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
                                  image: _editedAluno.img != null
                                      ? FileImage(File(_editedAluno.img))
                                      : AssetImage("images/person.png"))),
                        ),
                      )),
                      TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: "Nome do Aluno",
                              labelStyle:
                                  TextStyle(color: color, fontSize: 20.0)),
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                          controller: _nomeAlunoController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Insira o nome do aluno!";
                            }
                            return null;
                          },
                          onChanged: (text) {
                            _userEdited = true;
                            setState(() {
                              _editedAluno.nomeAluno = text;
                            });
                          }),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "ID do Aluno",
                            labelStyle:
                                TextStyle(color: color, fontSize: 20.0)),
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                        controller: _idAlunoController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira o ID do aluno!";
                          } else if (int.parse(value) < 0) {
                            return "ID inválido!";
                          }
                          return null;
                        },
                        onChanged: (text) {
                          _userEdited = true;
                          _editedAluno.idAluno = int.parse(text);
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                            labelText: "Data de Nascimento do Aluno",
                            labelStyle:
                                TextStyle(color: color, fontSize: 20.0)),
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                        controller: _dataNascimentoController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira a data de nascimento do aluno!";
                          } else if (int.parse(value) < 0) {
                            return "Data de nascimento inválida!";
                          }
                          return null;
                        },
                        onChanged: (text) {
                          _userEdited = true;
                          _editedAluno.datNasc = text;
                        },
                      ),
                       TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "ID do Curso",
                            labelStyle:
                                TextStyle(color: color, fontSize: 20.0)),
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                        controller: _idCurso,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira o ID do curso!";
                          } else if (int.parse(value) < 0) {
                            return "ID inválido!";
                          }
                          return null;
                        },
                        onChanged: (text) {
                          _userEdited = true;
                          _editedAluno.idCurso = int.parse(text);
                        },
                      ),
                       TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "MGP do Aluno",
                            labelStyle:
                                TextStyle(color: color, fontSize: 20.0)),
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                        controller: _mgpAlunoController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira a MGP do aluno!";
                          } else if (int.parse(value) < 0) {
                            return "MGP inválido!";
                          }
                          return null;
                        },
                        onChanged: (text) {
                          _userEdited = true;
                          _editedAluno.mgp = double.parse(text);
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
