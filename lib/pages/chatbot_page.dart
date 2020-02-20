import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ChatBotPage extends StatefulWidget {
  ChatBotPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChatBotPage createState() => new _ChatBotPage();
}

class _ChatBotPage extends State<ChatBotPage> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  int _currentIndex = 0;
  final List<Widget> _children = [];

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  void initState() {
    var messageTest = "";
    super.initState();
    final storage = new FlutterSecureStorage();
//    storage() async {
//      final storage = new FlutterSecureStorage();
//      String value = await storage.read(key: 'user');
//      return value;
//    }
    () async {
      String value = await storage.read(key: 'user');

      var url = 'http://3.92.227.229/bot';
      var toto = await http.post(
        url,
        body: {"question": "bonjour"},
        headers: {"x-access-token": value},
      );
      Map<String, dynamic> user = jsonDecode(toto.body);
      messageTest = user['message'];
      print('Howdy, ${user['message']}!');
      setState(() {
        ChatMessage message = new ChatMessage(
          text: messageTest,
          name: "Paul",
          type: false,
        );
        _messages.insert(0, message);
      });
    }();
  }

  void Response(query) async {
    _textController.clear();
    ChatMessage message = new ChatMessage(
      text: query,
      name: "Paul",
      type: false,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSubmitted(String text) {
    var messageTest = "";
    _textController.clear();
    final storage = new FlutterSecureStorage();
    () async {
      String value = await storage.read(key: 'user');
      var url = 'http://3.92.227.229/bot';
      var toto = await http.post(
        url,
        body: {"question": text},
        headers: {"x-access-token": value},
      );
      Map<String, dynamic> user = jsonDecode(toto.body);
      messageTest = user['message'];
      print('Howdy, ${user['message']}!');
      setState(() {
        ChatMessage message = new ChatMessage(
          text: text,
          name: "Promise",
          type: true,
        );
        _messages.insert(0, message);
      });
      Response(messageTest);
    }();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("ChatBot"),
      ),
      body: new Column(children: <Widget>[
        new Flexible(
            child: new ListView.builder(
          padding: new EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
        )),
        new Divider(height: 1.0),
        new Container(
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ]),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      new Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: new CircleAvatar(child: new Text('B')),
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(this.name,
                style: new TextStyle(fontWeight: FontWeight.bold)),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text(this.name, style: Theme.of(context).textTheme.subhead),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text),
            ),
          ],
        ),
      ),
      new Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: new CircleAvatar(
            child: new Text(
          this.name[0],
          style: new TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
