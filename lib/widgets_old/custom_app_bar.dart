
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tabornski_sos_prirocnik_frontend/routing/route_definitions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final Color? titleColor;
  final Color? leadingColor;
  final bool showLeading;
  final Color? actionsColor;
  final bool showActions;
  final bool disableBackButton;
  final bool enablePopButton;


  @override
  final Size preferredSize;


  const CustomAppBar({
    Key? key,
    required this.title,
    this.titleColor,
    this.leadingColor,
    this.showLeading = true,
    this.actionsColor,
    this.showActions = true,
    this.disableBackButton = false,
    this.enablePopButton = false
  }) : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final Color _leadingColor = leadingColor ?? Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    final Color _actionsColor = actionsColor ?? Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    final Color _titleColor = titleColor ?? Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return AppBar(
      elevation: 10,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      leading: showLeading ? IconButton(
        icon: Icon(
            enablePopButton ? Icons.arrow_back_ios_rounded : Icons.home_outlined,
            color: _leadingColor,
          weight: FontWeight.w300.value.toDouble(),
        ),
        onPressed: () => enablePopButton ? context.pop(context) : context.goNamed(RouteNames.home),
      ) : disableBackButton ? Container() : null,
      title: Image.asset(
        'assets/images/taborniski_sos_prirocnik_logo.png',
        height: 60,
      ),
      foregroundColor: _titleColor,
      centerTitle: true,
      actions: showActions ? <Widget>[
        IconButton(
          icon: Icon(
              Icons.info_outline_rounded,
              weight: FontWeight.w300.value.toDouble(),
              color: _actionsColor,
          ),
          onPressed: () {

          },
        ),
      ] : null
    );
  }
  
}