import 'package:flutter/material.dart';
import 'package:magister_mobile/data/model/Curso.dart';
import 'package:magister_mobile/data/model/Aluno.dart';
import 'package:magister_mobile/data/model/Disciplina.dart';
import 'package:magister_mobile/data/model/PeriodoLetivo.dart';
import 'package:magister_mobile/data/model/Professor.dart';
import 'package:magister_mobile/data/model/Turma.dart';

final _rowHeight = 100.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

class Objetos extends StatelessWidget {
  final String name;
  final ColorSwatch color;
  final IconData iconLocation;
  var classe;

  Objetos({
    Key key,
    @required this.name,
    @required this.color,
    @required this.iconLocation,
  })  : assert(name != null),
        assert(color != null),
        assert(iconLocation != null),
        super(key: key); 

  void _navigateToMagister(BuildContext context) {
    switch (name) {
      case ("Aluno"):
        classe = new Alunos(color: color,);
        break;
      case ("Curso"):
        classe = new Cursos(color: color,);
        break;
      case ("Disciplina"):
        classe = new Disciplinas(color: color,);
        break;
      case ("Periodo Letivo"):
        classe = new PeriodoLetivos(color: color,);
        break;
      case ("Professor"):
        classe = new Professores(color: color);
        break;
      case ("Turma"):
        classe = new Turmas(color: color,);
        break;
    }
    Navigator.of(context).push(MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            title: Text(name,
                style: TextStyle(fontFamily: "Kanit", fontSize: 25.0)),
            centerTitle: true,
            backgroundColor: color,
          ),
          body: classe
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    var inkWell = InkWell(
      borderRadius: _borderRadius,
      highlightColor: color,
      splashColor: color,
      onTap: () => _navigateToMagister(context),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(
                iconLocation,
                size: 60.0,
              ),
            ),
            Center(
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
          ],
        ),
      ),
    );
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _rowHeight,
        child: inkWell,
      ),
    );
  }
}
