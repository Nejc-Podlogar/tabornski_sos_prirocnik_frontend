

import 'package:flutter/material.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/custom_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewContainer extends StatelessWidget {

  final String url;

  WebviewContainer({required this.url});

  @override
  Widget build(BuildContext context) {

    final controller = WebViewController()..setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (url) {
          print('Page started loading: $url');
        },
      )
    );



    return Scaffold(
      appBar: const CustomAppBar(title: 'Taborniški SOS priročnik'),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }

}