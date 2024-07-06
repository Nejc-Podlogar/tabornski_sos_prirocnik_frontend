import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/post_cubit/post_cubit.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/card_info.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/custom_app_bar.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/navigation_bottom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    context.read<PostCubit>().getLatestPost();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

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
                child: Center(
                  child: Text(
                    localizations.appTitle,
                    style: const TextStyle(
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
          BlocBuilder<PostCubit, PostState>(
              builder: (BuildContext context, PostState state) {
                if (state is PostLoading) {
                  return const CircularProgressIndicator();
                }else if (state is PostSuccess) {
                  return Positioned(
                    top: 220, // Adjust this value to move the card up or down
                    child: InfoCard(
                      title: state.post.title,
                      description: state.post.content,
                      url: state.post.link,
                    ),
                  );
                } else if (state is PostFailure) {
                  return const Positioned(
                    top: 220, // Adjust this value to move the card up or down
                    child: InfoCard(
                      title: 'Taborniški S.O.S priročnik',
                      description: 'Aplikacija ki vam omogoča učenje morsejeve abecede, topografskih znakov. Prav tako imate na voljo prevajanje morse kode in semaforja. Na voljo je tudi gradivo za orientacijo.',
                      url: 'https://www.google.com',
                    ),
                  );
                }

                return Container();
              }
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
