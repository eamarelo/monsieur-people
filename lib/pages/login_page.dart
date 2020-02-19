import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:monsieur_people/models/user_model.dart';
import 'package:monsieur_people/pages/chatbot_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
        ),
        body: _bodyDependingOnLoading());
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
                Icon(
                  Icons.account_circle,
                  size: 48,
                  color: Colors.blue.withOpacity(0.6),
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
                  labelText: 'Username',
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
            //            GestureDetector(
//                onTapDown: (detail) {
//                  setState(() {
//                    _loginButtonColor = Colors.red;
//                  });
//                },
//                onTapCancel: () {
//                  setState(() {
//                    _loginButtonColor = Colors.deepPurple;
//                  });
//                },
//                onTapUp: (detail) {
//                  setState(() {
//                    _loginButtonColor = Colors.deepPurple;
//                  });
//                },
////                child: StaticLoginButtonWidget(_loginButtonColor))
//                child: LoginButtonWidget())
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
    if (username == 'admin' && password == 'password') {
      User user = User(username, password);
      print(user.toJSON());
      String encodedJSON = jsonEncode((user.toJSON()));
      print(encodedJSON);

      //save to shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user', encodedJSON);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ChatBotPage()));
    } else {
      setState(() {
        _isLoading = false;
        error = true;
      });
    }
  }
}
