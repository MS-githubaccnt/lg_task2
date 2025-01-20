import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/appbar.dart';
import './home.dart';
import './settings.dart';
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    SettingsPage(),
    HomePage(),
  ];
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar as PreferredSizeWidget,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor:Colors.white,
          unselectedItemColor:Colors.white,
        backgroundColor:Color.fromRGBO(69, 123, 157, 1) ,
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
          _currentIndex=index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.settings,
            color:Colors.white,
            ),
            label:"Settings"),
            BottomNavigationBarItem(icon:Icon(Icons.home,
            color:Colors.white,),
            label:"Home") 
        ]),
    );

  }}