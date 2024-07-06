import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tabornski_sos_prirocnik_frontend/routing/route_definitions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../themes/default_dark.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String description;
  final String? url;

  const InfoCard({Key? key, required this.title, required this.description, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppLocalizations localizations = AppLocalizations.of(context)!;

    // create an info card that is the 85% of the screen width
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 200,
      child: Card(
        color: primaryCardTheme.color,
        shape: primaryCardTheme.shape,
        elevation: 2,
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'JetBrains Mono',
                        fontWeight: FontWeight.normal,
                        color: primaryCardTextStyle.color,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      description,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'JetBrains Mono',
                        fontWeight: FontWeight.normal,
                        color: primaryCardTextStyle.color,
                      ),
                    ),
                  ],
                ),
                url != null ? Positioned(
                    right: 0,
                    bottom: 0,
                    child: ElevatedButton(
                      onPressed: () => context.pushNamed(RouteNames.webview, extra: { 'url': url ?? ''}),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),  // Rounded border
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Text(
                              localizations.readMore,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'JetBrains Mono',
                              )
                          )
                      ),
                    )
                ) : const SizedBox.shrink()
              ],
            )
        ),

      ),
    );
  }
}