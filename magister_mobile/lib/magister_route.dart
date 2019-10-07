import 'package:flutter/material.dart';
import 'package:magister_mobile/objetos.dart';

final _backgroundColor = Colors.blue[100];
//const baseColor = Colors.blueAccent;

class MagisterRoute extends StatefulWidget {
  const MagisterRoute();
  @override
  _MagisterRouteState createState() => _MagisterRouteState();
}

class _MagisterRouteState extends State<MagisterRoute> {
  final _objects = <Objetos>[];

  static const _objectNames = <String>[
    'Aluno',
    'Curso',
    'Disciplina',
    'Periodo Letivo',
    'Professor',
    'Turma'
  ];

  static const _baseColors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.blueGrey,
    Colors.green,
    Colors.cyan,
    Colors.red,
  ];

  static const _icons = <IconData>[
    Icons.person,
    Icons.school,
    Icons.book,
    Icons.calendar_view_day,
    Icons.person,
    Icons.people,
  ];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _objectNames.length; i++) {
      _objects.add(Objetos(
        name: _objectNames[i],
        color: _baseColors[i],
        iconLocation: _icons[i],
      ));
    }
  }

  // static const _objectWidgets = <Class>[

  // ];

  Widget _buildObjectWidgets() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => _objects[index],
      itemCount: _objects.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 0.0,
      title: Text(
        'Magister Mobile',
        style:
            TextStyle(color: Colors.black, fontSize: 30.0, fontFamily: "Kanit"),
      ),
      centerTitle: true,
      backgroundColor: _backgroundColor,
    );

    final listview = Container(
      color: _backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: _buildObjectWidgets(),
    );

    return Scaffold(
      appBar: appBar,
      body: listview,
    );
  }
}
