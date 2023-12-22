// custom_bottom_navigation.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tabornski_sos_prirocnik_frontend/routing/route_definitions.dart';

class CustomBottomNavigation extends StatefulWidget {

  CustomBottomNavigation({super.key});

  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (_currentIndex) {
      case 0:
        context.go(RouteNames.morseCode);
        break;
      case 1:
        Navigator.of(context).pushNamed('/home');
        break;
      case 2:
        context.go(RouteNames.orientation);
        break;
      case 3:
        context.go(RouteNames.settings);
        break;
      default:
        context.go('/settings');
        break;
    }

  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: _currentIndex,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
              Icons.more_horiz_sharp,
              color: Colors.black,
          ),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon(
              Icons.flag_outlined,
              color: Colors.black,
          ),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon(
              Icons.map_outlined,
              color: Colors.black,
          ),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon(
              Icons.settings_outlined,
              color: Colors.black,
          ),
          label: '',
        ),
      ],
    );
  }
}
