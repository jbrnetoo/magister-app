import 'dart:io';

import 'package:magister_mobile/data/helpers/HelperProfessor.dart';
import 'package:flutter/material.dart';
import 'package:magister_mobile/data/views/ProfessorPage.dart';

class Professor {
  int id;
  String nome;
  int matricula;
  String img;

  Professor();

  Professor.fromMap(Map map) {
    id = map[HelperProfessor.idColumn];
    nome = map[HelperProfessor.nomeColumn];
    matricula = map[HelperProfessor.matriculaColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      HelperProfessor.nomeColumn: nome,
      HelperProfessor.matriculaColumn: matricula
    };

    if (id != null) {
      map[HelperProfessor.idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Professor(id: $id, nome: $nome, matricula: $matricula)";
  }
}

TextEditingController idProfController = TextEditingController();
TextEditingController nomeProfController = TextEditingController();
TextEditingController matriculaProfController = TextEditingController();

class Professores extends StatefulWidget {
  Color color;
  Professores({@required this.color});

  @override
  _ProfessoresState createState() => _ProfessoresState(color: color);
}

class _ProfessoresState extends State<Professores> {
  HelperProfessor helper = HelperProfessor();
  List<Professor> professores = List();
  Color color;
  _ProfessoresState({@required this.color});

  @override
  void initState() {
    super.initState();
    // Professor p = new Professor();
    // p.id = 1234;
    // p.matricula = 4321;
    // p.nome = "Joao";
    // helper.save(p);
    _getAllProfessores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showProfessorPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.cyan,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: professores.length,
          itemBuilder: (context, index) {
            return _professorCard(context, index);
          }),
    );
  }

  Widget _professorCard(BuildContext context, int index) {
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
                      image: professores[index].img != null
                          ? FileImage(File(professores[index].img))
                          : AssetImage("images/person.png")),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      professores[index].nome ?? "",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "ID: " + professores[index].id.toString() ?? "",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      "Matricula: " + professores[index].matricula.toString() ??
                          "",
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
        _showProfessorPage(professor: professores[index]);
      },
    );
  }

  void _showProfessorPage({Professor professor}) async {
    final recProfessor = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfessorPage(
                  professor: professor, color: color,
                )));
    if (recProfessor != null) {
      if (professor != null) {
        await helper.update(recProfessor);
      } else {
        await helper.save(recProfessor);
      }
      _getAllProfessores();
    }
  }

  void _getAllProfessores() {
    helper.getAll().then((list) {
      setState(() {
        professores = list;
      });
    });
  }
}
