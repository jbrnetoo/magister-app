import 'dart:io';

import 'package:flutter/material.dart';
import 'package:magister_mobile/data/model/Curso.dart';

class CursoPage extends StatefulWidget {
  Color color;
  final Curso curso;
  CursoPage({this.curso, this.color}); //Entre chaves significa que é opcional

  @override
  _CursoPageState createState() => _CursoPageState(color: color);
}

class _CursoPageState extends State<CursoPage> {

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _nomeFocus = FocusNode();
  TextEditingController _idCursoController = TextEditingController();
  TextEditingController _nomeCursoController = TextEditingController();
  TextEditingController _idCoordenadorController = TextEditingController();
  TextEditingController _totalCreditosController = TextEditingController();

  Color color;
  _CursoPageState({@required this.color});
  bool _userEdited = false;
  Curso _editedCurso;


  @override
  void initState() {
    super.initState();

    if (widget.curso == null) {
      _editedCurso = new Curso();
    } else {
      _editedCurso = Curso.fromMap(widget.curso.toMap());
      _nomeCursoController.text = _editedCurso.nome;
      _idCursoController.text = _editedCurso.idCurso.toString();
      _totalCreditosController.text = _editedCurso.totalCreditos.toString();
      _idCoordenadorController.text = _editedCurso.idCoordenador.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: color,
              title: Text(_editedCurso.nome ??  // O ?? significa se for null 'else'
                  "Novo Curso",  style: TextStyle(
                    fontFamily: "Kanit", fontSize: 25.0
                    ),
                  ), 
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  if (_editedCurso.nome != null &&
                      _editedCurso.nome.isNotEmpty) {
                    Navigator.pop(context, _editedCurso);
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
                                  image: _editedCurso.img != null
                                      ? FileImage(File(_editedCurso.img))
                                      : AssetImage("images/person.png"))),
                        ),
                      )),
                      TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: "Nome do Curso",
                              labelStyle:
                                  TextStyle(color: color, fontSize: 20.0)),
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                          controller: _nomeCursoController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Insira o nome do curso!";
                            }
                            return null;
                          },
                          onChanged: (text) {
                            _userEdited = true;
                            setState(() {
                              _editedCurso.nome = text;
                            });
                          }),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "ID do Curso",
                            labelStyle:
                                TextStyle(color: color, fontSize: 20.0)),
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                        controller: _idCursoController,
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
                          _editedCurso.idCurso = int.parse(text);
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Total de Creditos do Curso",
                            labelStyle:
                                TextStyle(color: color, fontSize: 20.0)),
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                        controller: _totalCreditosController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira o total de creditos!";
                          } else if (double.parse(value) < 0.0) {
                            return "Inserção inválida!";
                          }
                          return null;
                        },
                        onChanged: (text) {
                          _userEdited = true;
                          _editedCurso.totalCreditos = double.parse(text);
                        },
                      ),
                       TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "ID do Coordenador do Curso",
                            labelStyle:
                                TextStyle(color: color, fontSize: 20.0)),
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                        controller: _idCoordenadorController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira o ID do coordenador do curso!";
                          } else if (int.parse(value) < 0) {
                            return "ID inválido!";
                          }
                          return null;
                        },
                        onChanged: (text) {
                          _userEdited = true;
                          _editedCurso.idCoordenador = int.parse(text);
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
