import 'package:flutter/material.dart';
import 'package:magister_mobile/magister_route.dart';

void main() => runApp(MagisterMobileApp());

class MagisterMobileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Magister Mobile',
      home: MagisterRoute(),
    );
    return materialApp;
  }
}
