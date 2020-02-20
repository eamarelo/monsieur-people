import 'package:flutter/material.dart';
import 'package:monsieur_people/pages/chatbot_page.dart';
import 'package:monsieur_people/pages/description_jobs_page.dart';
import 'package:monsieur_people/pages/events_page.dart';
import 'package:monsieur_people/pages/jobs_careers_page.dart';
import 'package:monsieur_people/pages/profil_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 2;
  final List<Widget> _children = [
    DescriptionJobsPage(),
    EventsPage(),
    ChatBotPage(),
    JobsCareers(),
    ProfilPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Image.asset('assets/icoInfos.png', height: 50),
            title: Text(''),
          ),
          new BottomNavigationBarItem(
            icon: Image.asset('assets/icoEvent.png', height: 50),
            title: Text(''),
          ),
          new BottomNavigationBarItem(
            icon: Image.asset('assets/IA.png', height: 60),
            title: Text(''),
          ),
          new BottomNavigationBarItem(
            icon: Image.asset('assets/icoWork.png', height: 50),
            title: Text(''),
          ),
          new BottomNavigationBarItem(
              icon: Image.asset('assets/icoProfile.png', height: 50),
              title: Text(''))
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
