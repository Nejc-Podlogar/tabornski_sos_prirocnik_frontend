
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final Color? titleColor;
  final Color? leadingColor;
  final bool showLeading;
  final Color? actionsColor;
  final bool showActions;
  final disableBackButton;


  @override
  final Size preferredSize;


  const CustomAppBar({
    Key? key,
    required this.title,
    this.titleColor = Colors.black,
    this.leadingColor = Colors.black,
    this.showLeading = true,
    this.actionsColor = Colors.black,
    this.showActions = true,
    this.disableBackButton = false,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 10,

      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading: showLeading ? IconButton(
        icon: Icon(
            Icons.house_outlined,
            color: leadingColor,
          weight: FontWeight.w300.value.toDouble(),
        ),
        onPressed: () {
          context.goNamed('home');
        },
      ) : disableBackButton ? Container() : null,
      title: Image.asset(
        'assets/images/taborniski_sos_prirocnik_logo.png',
        height: 60,
      ),
      centerTitle: true,
      actions: showActions ? <Widget>[
        IconButton(
          icon: Icon(
              Icons.info_outline_rounded,
              weight: FontWeight.w300.value.toDouble(),
              color: actionsColor,
          ),
          onPressed: () {

          },
        ),
      ] : null
    );
  }
  
}