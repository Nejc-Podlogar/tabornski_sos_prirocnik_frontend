import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/forest_painter.dart';

class WelcomeView extends StatefulWidget {
  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  int currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int page) {
              setState(() {
                currentPage = page;
              });
            },
            children: [
              _buildPage(title: 'Začni', description: ''),
              _buildPage(title: 'Morsejeva abeceda', description: ''),
              _buildPage(title: 'Semafor', description: ''),
              _buildPage(title: 'Topografija', description: '')
            ],
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: currentPage < 3 ? Center(
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_forward,
                      size: 32.0,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (currentPage < 3) {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      }
                    },
                  ),
                )) : Center(
              child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),  // Rounded border
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("ZAČNI Z UPORABO", style: TextStyle(color: Colors.white)),
                        Container(width: 10,),
                        const Icon(Icons.arrow_forward, color: Colors.white)  // Right arrow
                      ],
                    ),
                  )
              ),
            )
          )
        ],
      ),
    );
  }

  Widget _buildPage({required String title, required String description}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.5,
              child: Container(
                color: Theme.of(context).primaryColor,
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 2,
              child: Image.asset(
                'assets/images/single_separator_forest.png',
                width: MediaQuery.of(context).size.width,
                height: 50, // Height of the border
                repeat: ImageRepeat.repeatX, // Repeat horizontally
              ),
            ),
          ],
        ),
        Expanded(
            child: Center(
          child: Text(
            description,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ))
      ],
    );
  }
}
