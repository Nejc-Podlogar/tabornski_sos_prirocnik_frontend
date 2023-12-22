import 'package:flutter/material.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/card_info.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/custom_app_bar.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/navigation_bottom.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Taborniški\nS.O.S\nPriročnik',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'JetBrains Mono',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 150), // Replaced Container with SizedBox
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.70,
                child: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'JetBrains Mono',
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const Positioned(
            top: 220, // Adjust this value to move the card up or down
            child: InfoCard(
              title: 'Zadnja novica',
              description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
              url: 'https://www.google.com',
            ),
          ),
          // Positioned at the top to overlay the body content
          const Positioned(
            top: 0, // Align to top
            left: 0,
            right: 0,
            child: CustomAppBar(
              title: '',
              showLeading: false,
              showActions: true,
              actionsColor: Colors.white,
              leadingColor: Colors.white,
              titleColor: Colors.white,
              disableBackButton: true,
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}
