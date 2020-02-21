import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfilPage extends StatefulWidget {
  @override
  _UserProfilePage createState() => _UserProfilePage();
}

class _UserProfilePage extends State<ProfilPage> {
  String _fullName = "Clémence Moukouknoff";
  String _status = "Software Developer";
  String _photo = "Software Developer";
  var past = [
    "https://i.eurosport.com/2020/02/12/2773902-57300050-2560-1440.jpg?w=750",
    "https://weezevent.com/wp-content/uploads/2019/01/12145054/organiser-soiree.jpg",
    "https://www.saintsebastien.fr/sites/default/files/pmaa-diapo.jpg"
  ];
  var futur = [
    "https://upload.wikimedia.org/wikipedia/commons/b/b9/Football_iu_1996.jpg",
    "https://lh3.googleusercontent.com/proxy/gogrx8j2ypPWffJlxEaK3-qDRfNT3zPTJgn1l0CHZS2sFfc9RKYntSfnWhIlwqdhfFHdt3r5kS8I30N4a4u9pE5f-9HHokQBPGidheA1vs3itNcPdBof7KGhw5D0tnkEsjkkFfZIyH8yIMpqGYCNOrC4DKTUAkUwnbx1Fw",
    "https://www.leparisien.fr/resizer/uwIK850Hf9hpl82WYQ8ZBtlZWeU=/932x582/arc-anglerfish-eu-central-1-prod-leparisien.s3.amazonaws.com/public/RH6Y7HZPSC7ZAEHTKLAV67WFS4.jpg",
    "https://s3.amazonaws.com/images.seroundtable.com/pastel-haze-Google-1900px--1456937097.jpg",
    "https://www.lerevenu.com/sites/site/files/styles/img_lg/public/field/image/capgemini_entreprise_3.jpg?itok=h8F08UYe"
  ];
  bool isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  Future<event> _loadData() async {
    isloading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = await prefs.getString('user');
    var url = 'http://3.92.227.229/user/show';
    var toto = await http.get(
      url,
      headers: {"x-access-token": value},
    );
    Map<String, dynamic> user = jsonDecode(toto.body);
    _fullName = '${user['nom']} ${user['prenom']}';
    _photo = '${user['photo']}';
    _status = '${user['classe']}';
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pokemon Liste'),
        ),
        body: _onLoading());
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          image: new DecorationImage(
              image: new NetworkImage(_photo), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(
            color: Colors.white,
            width: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );
    return Text(
      _fullName,
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        _status,
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildBack(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        "Ses précédents événements",
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildComming(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        "Ses événements à venir",
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildCarouselPreviously(BuildContext context) {
    return Stack(children: [
      CarouselSlider(
        enlargeCenterPage: true,
        height: 250.0,
        items: past.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  image: new DecorationImage(
                      image: new NetworkImage("$i"), fit: BoxFit.cover),
                ),
              );
            },
          );
        }).toList(),
      )
    ]);
  }

  Widget _buildCarouselFutur(BuildContext context) {
    return Stack(children: [
      CarouselSlider(
        enlargeCenterPage: true,
        height: 250.0,
        items: futur.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  image: new DecorationImage(
                      image: new NetworkImage("$i"), fit: BoxFit.cover),
                ),
              );
            },
          );
        }).toList(),
      )
    ]);
  }

  Widget _onLoading() {
    if (isloading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return _buildtoto(context);
    }
  }

  Widget _buildtoto(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    print(past);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  _buildProfileImage(),
                  _buildFullName(),
                  _buildStatus(context),
                  SizedBox(height: 40),
                  _buildBack(context),
                  _buildCarouselPreviously(context),
                  SizedBox(
                    height: 30,
                  ),
                  _buildComming(context),
                  _buildCarouselFutur(context)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class event {
  final String eventsName;
  final String description;
  final String dateEvent;
  final String categorie;
  final String photo;

  event(
      {this.eventsName,
      this.description,
      this.dateEvent,
      this.categorie,
      this.photo});

  factory event.fromJson(Map<String, dynamic> json) {
    return event(
      eventsName: json['eventsName'],
      description: json['description'],
      dateEvent: json['dateEvent'],
      categorie: json['categorie'],
      photo: json['photo'],
    );
  }
}
