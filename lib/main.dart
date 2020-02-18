import 'package:flutter/material.dart';
import 'package:monsieur_people/pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
//      home: MenuPageWidget(),
      home: LoginPage(),
    );
  }
}
