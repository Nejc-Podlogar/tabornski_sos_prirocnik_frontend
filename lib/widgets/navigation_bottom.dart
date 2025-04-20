import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tabornski_sos_prirocnik_frontend/routing/route_definitions.dart';

class CustomBottomNavigation extends StatefulWidget {
  CustomBottomNavigation({Key? key}) : super(key: key); // Added Key to constructor

  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int _getIndexFromRoute(String? location) {
    if (location == null) return 0; // Handle null location gracefully
    if (location.contains(RoutePaths.morseCode)) return 0;
    if (location.contains(RoutePaths.semaphore)) return 1;
    if (location.contains(RoutePaths.orientation)) return 2;
    if (location.contains(RoutePaths.settings)) return 3;
    return 0; // Default to no highlighted tab
  }

  void _onItemTapped(int index) {
    switch (index) {
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
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? currentLocation = GoRouterState.of(context).uri.toString(); // Safely access location
    final int highlightedIndex = _getIndexFromRoute(currentLocation);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: highlightedIndex == -1 ? 0 : highlightedIndex, // Default to 0 if no tab is highlighted
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).iconTheme.color,
      onTap: _onItemTapped,
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz_sharp),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.flag_outlined),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          label: '',
        ),
      ],
    );
  }
}
