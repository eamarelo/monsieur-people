import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class JobsCareers extends StatefulWidget {
  @override
  _JobsCareersState createState() => _JobsCareersState();
}

class _JobsCareersState extends State<JobsCareers> {
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
      "https://s3.amazonaws.com/images.seroundtable.com/pastel-haze-Google-1900px--1456937097.jpg",
      "https://france3-regions.francetvinfo.fr/nouvelle-aquitaine/sites/regions_france3/files/styles/top_big/public/assets/images/2019/01/11/maxnewsworldfour578097-4033475.jpg?itok=9g3sjjXU",
      "https://www.lerevenu.com/sites/site/files/styles/img_lg/public/field/image/capgemini_entreprise_3.jpg?itok=h8F08UYe",
      "https://img.phonandroid.com/2019/09/facebook-the-pirate-bay.jpg"
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
