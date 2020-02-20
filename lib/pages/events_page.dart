import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pokemon Liste'),
        ),
        body: _onLoading());
  }

  Widget _builItem(int item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 100.0,
              width: 100.0,
              child: Container(
                  decoration: BoxDecoration(
                image: new DecorationImage(
                    image: new NetworkImage(
                        "https://kigurumi-france.com/blog/wp-content/uploads/2014/11/stitch-1200x844.jpg"),
                    fit: BoxFit.cover),
              )),
            ),
            Container(
              width: 12,
            ),
            Expanded(
              child: Text("tutu"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _onLoading() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return _builItem(index);
        });
  }
}
