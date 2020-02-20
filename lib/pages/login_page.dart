import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:monsieur_people/models/user_model.dart';
import 'package:monsieur_people/pages/home_page.dart';
import 'package:monsieur_people/widgets/generic_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//  Color _loginButtonColor = Colors.deepPurple;

  bool _isLoading = false;
  bool error = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  User _currentCat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _bodyDependingOnLoading());
  }

  _textFieldBorder({bool isFocused = false}) {
    return OutlineInputBorder(
        borderSide: BorderSide(
            color: isFocused ? Colors.lightBlue : Colors.blue, width: 1));
  }

  Widget _bodyDependingOnLoading() {
    if (_isLoading) {
      return _progressIndicator();
    } else {
      return _contentLoginForm();
    }
  }

  Widget _progressIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _contentLoginForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/logo.png",
                  width: 250,
                  height: 150,
                  fit: BoxFit.fill,
                ),
              ],
            ),
            Container(
              height: 16,
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Email',
                  focusedBorder: _textFieldBorder(),
                  enabledBorder: _textFieldBorder()),
            ),
            Container(
              height: 16,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Password',
                  focusedBorder: _textFieldBorder(),
                  enabledBorder: _textFieldBorder()),
            ),
            Container(
              height: 32,
            ),
            GenericButtonWidget('Login', _loginPressed),
            Container(
              height: 16,
            ),
            Row(
              children: <Widget>[
                error == true ? Text('Wrong identity') : Container()
              ],
            )
          ],
        ),
      ),
    );
  }

  _loginPressed() async {
    print('Login pressed');
    setState(() {
      error = false;
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 1));

    String username = _usernameController.text;
    String password = _passwordController.text;
    var url = 'http://3.92.227.229/login';
    var response =
        await http.post(url, body: {"email": username, "password": password});
    Map<String, dynamic> user = jsonDecode(response.body);
    print('Howdy, ${user['token']}!');
    if (user['token'].length != 0) {
      String encodedJSON = jsonEncode(user['token']);
      //save to shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user', encodedJSON);
      String stringValue = prefs.getString('user');
      print("---------" + stringValue);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      setState(() {
        _isLoading = false;
        error = true;
      });
    }
  }
}
