import 'package:cached_network_image/cached_network_image.dart';
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

  Widget _myListView(BuildContext context) {
    // backing data
    final events = [
      "https://i.eurosport.com/2020/02/12/2773902-57300050-2560-1440.jpg?w=750https://i.eurosport.com/2020/02/12/2773902-57300050-2560-1440.jpg?w=750",
      "https://upload.wikimedia.org/wikipedia/commons/b/b9/Football_iu_1996.jpg",
      "https://weezevent.com/wp-content/uploads/2019/01/12145054/organiser-soiree.jpg",
      "https://lh3.googleusercontent.com/proxy/gogrx8j2ypPWffJlxEaK3-qDRfNT3zPTJgn1l0CHZS2sFfc9RKYntSfnWhIlwqdhfFHdt3r5kS8I30N4a4u9pE5f-9HHokQBPGidheA1vs3itNcPdBof7KGhw5D0tnkEsjkkFfZIyH8yIMpqGYCNOrC4DKTUAkUwnbx1Fw",
      "https://www.saintsebastien.fr/sites/default/files/pmaa-diapo.jpg",
      "https://www.leparisien.fr/resizer/uwIK850Hf9hpl82WYQ8ZBtlZWeU=/932x582/arc-anglerfish-eu-central-1-prod-leparisien.s3.amazonaws.com/public/RH6Y7HZPSC7ZAEHTKLAV67WFS4.jpg"
    ];

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return CachedNetworkImage(
          imageUrl: events[index],
          placeholder: (context, url) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  height: 48.0,
                  width: 48.0,
                  child: CircularProgressIndicator()),
            ],
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        );
      },
    );
  }

  Widget _onLoading() {
    return _myListView(context);
  }
}
