import 'dart:io';

import 'package:magister_mobile/data/helpers/HelperAluno.dart';
import 'package:magister_mobile/data/model/Curso.dart';
import 'package:flutter/material.dart';
import 'package:magister_mobile/data/views/AlunoPage.dart';

class Aluno {
  Aluno();

  int idAluno;
  String nomeAluno;
  int totCreditos;
  String datNasc;
  double mgp;
  int idCurso;
  Curso curso;
  String img;

  Aluno.fromMap(Map map) {
    idAluno = map[HelperAluno.idColumn];
    nomeAluno = map[HelperAluno.nomeColumn];
    datNasc = map[HelperAluno.dtNascColumn];
    mgp = map[HelperAluno.mgpColumn];
    // totCreditos = map[HelperAluno.totalCreditoColumn];
    //idCurso = map[HelperAluno.idCursoColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      HelperAluno.nomeColumn: nomeAluno,
      // HelperAluno.totalCreditoColumn: totCreditos,
      HelperAluno.dtNascColumn: datNasc,
      HelperAluno.mgpColumn: mgp,
      // HelperAluno.idCursoColumn: idCurso,
    };

    if (idAluno != null) {
      map[HelperAluno.idColumn] = idAluno;
    }
    return map;
  }

  @override
  String toString() {
    return "Contact(id: $idAluno, nome: $nomeAluno, créditos: $totCreditos, dataNasc: $datNasc, mgp: $mgp)";
  }
}

TextEditingController matriculaAlunoController = TextEditingController();
TextEditingController nomeAlunoController = TextEditingController();
TextEditingController dataNascimentoController = TextEditingController();
TextEditingController mgpAlunoController = TextEditingController();

class Alunos extends StatefulWidget {
  Color color;
  Alunos({@required this.color});

  @override
  _AlunosState createState() => _AlunosState(color: color);
}

class _AlunosState extends State<Alunos> {
  HelperAluno helper = HelperAluno();
  List<Aluno> alunos = List();
  Color color;
  _AlunosState({@required this.color});

  @override
  void initState() {
    super.initState();
    if(size() != 0){
      _getAllAluno();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAlunoPage();
        },
        child: Icon(Icons.add),
        backgroundColor: color,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: alunos.length,
          itemBuilder: (context, index) {
            return _alunoCard(context, index);
          }),
    );
  }

  Widget _alunoCard(BuildContext context, int index) {
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
                      image: alunos[index].img != null
                          ? FileImage(File(alunos[index].img))
                          : AssetImage("images/person.png")),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      alunos[index].nomeAluno ?? "",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "ID: " + alunos[index].idAluno.toString() ?? "",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      "MPG: " + alunos[index].mgp.toString() ?? "",
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
        _showAlunoPage(aluno: alunos[index]);
      },
    );
  }

  void _showAlunoPage({Aluno aluno}) async {
    final recAluno = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AlunoPage(
                  aluno: aluno, color: color
                )));
    if (recAluno != null) {
      if (aluno != null) {
        await helper.update(recAluno);
      } else {
        await helper.save(recAluno);
      }
      _getAllAluno();
    }
  }

  void _getAllAluno() {
    helper.getAll().then((list) {
      setState(() {
        alunos = list;
      });
    });
  }

   size() async {
   int number = await helper.getNumber();
   return number;
  }
}
