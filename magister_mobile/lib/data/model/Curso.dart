import 'dart:io';

import 'package:magister_mobile/data/helpers/HelperCurso.dart';
import 'package:magister_mobile/data/views/CursoPage.dart';
import 'Professor.dart';
import 'package:flutter/material.dart';

class Curso {
  int idCurso;
  String nome;
  double totalCreditos;
  int idCoordenador;
  Professor coordenador;
  String img;

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

TextEditingController idCursoController = TextEditingController();
TextEditingController nomeCursoController = TextEditingController();
TextEditingController idCoordenadorController = TextEditingController();

class Cursos extends StatefulWidget {
  
  Color color;
  Cursos({@required this.color});

  @override
  _CursosState createState() => _CursosState(color: color);
}

class _CursosState extends State<Cursos> {
  HelperCurso helper = HelperCurso();
  List<Curso> cursos = List();
  Color color;
  _CursosState({@required this.color});

  @override
  void initState() {
    super.initState();
    // Curso c = new Curso();
    // c.idCurso = 8924;
    // c.nome = "Flavio";
    // c.totalCreditos = 44;
    // c.idCoordenador = 1234;
    // helper.save(c);
    _getAllCurso();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCursoPage();
        },
        child: Icon(Icons.add),
        backgroundColor: color,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: cursos.length,
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
                      image: cursos[index].img != null
                          ? FileImage(File(cursos[index].img))
                          : AssetImage("images/person.png")),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      cursos[index].nome ?? "",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "ID Curso: " + cursos[index].idCurso.toString() ?? "",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      "ID Coordenador: " + cursos[index].idCoordenador.toString() ?? "",
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
        _showCursoPage(curso: cursos[index]);
      },
    );
  }

  void _showCursoPage({Curso curso}) async {
    final recCurso = await Navigator.push(context,
      MaterialPageRoute(builder: (context) => CursoPage(curso: curso,color: color,))
      );
      if (recCurso != null) {
        if (curso != null) {
          await helper.update(recCurso);
        } else {
          await helper.save(recCurso);
        }
      _getAllCurso();
    } 
  }

  void _getAllCurso() {
    helper.getAll().then((list) {
      setState(() {
        cursos = list;
      });
    });
  }
}
