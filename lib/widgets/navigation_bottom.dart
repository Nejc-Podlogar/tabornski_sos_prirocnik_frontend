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

    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });

      switch (_currentIndex) {
        case 0:
          context.goNamed(RouteNames.morseCode);
          break;
        case 1:
          context.goNamed(RouteNames.semaphore);
          break;
        case 2:
          context.goNamed(RouteNames.orientation);
          break;
        case 3:
          context.goNamed(RouteNames.settings);
          break;
        default:
          context.goNamed(RouteNames.home);
          break;
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _currentIndex,
      selectedIconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      unselectedIconTheme: Theme.of(context).iconTheme,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
              Icons.more_horiz_sharp,
          ),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon(
              Icons.flag_outlined,
          ),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon(
              Icons.map_outlined,
          ),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon(
              Icons.settings_outlined,
          ),
          label: '',
        ),
      ],
    );
  }
}
