import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/theme_block/theme_state.dart';
import 'package:tabornski_sos_prirocnik_frontend/themes/default_dark.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/checkmark_switch.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/custom_dialog.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/navigation_bottom.dart';

import '../../blocs/theme_block/theme_bloc.dart';
import '../../blocs/theme_block/theme_event.dart';
import '../../generated/l10n.dart';
import '../../utils/shared_prefs.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _nameController = TextEditingController(text: 'uporabnik');
  bool _isEditing = false;
  bool _notificationsEnabled = false;
  bool _darkModeEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    // check for permission status
     Permission.notification.status.then((status) {
      if (status.isGranted) {
        setState(() {
          _notificationsEnabled = true;
        });
      }
    });
     _darkModeEnabled = context.read<ThemeBloc>().state is DarkThemeState;
  }

  void _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('username') ?? 'uporabnik';
    setState(() {
      _nameController.text = userName;
    });
  }

  @override
  void dispose() {
    // _saveUserName();
    _nameController.dispose();
    super.dispose();
  }

  void _saveUserName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _nameController.text);
    setState(() {
      _nameController.text = _nameController.text;
    });
  }

  void _clearLocalStorage() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        prefs.clear();
        _loadUserName();
      });
      showDialog(
        context: context,
        builder: (BuildContext context) => const CustomDialogNoButtons(
            title: '',
            content: 'All of local data has been deleted',
            icon: Icons.restore_from_trash_outlined,
            duration: Duration(seconds: 2)),
      );
    });
  }

  void _toggleNotifications(bool value) async {
    if (value) {
      var status = Permission.notification.status;
      if (await status.isDenied) {
        await Permission.notification.request();

        await Permission.notification.isGranted.then((status) {
          if(status) {
            showDialog(
              context: context,
              builder: (BuildContext context) => const CustomDialogNoButtons(
                  title: 'Notifications enabled',
                  content: 'You will now receive notifications',
                  icon: Icons.notifications_active_outlined,
                  duration: Duration(seconds: 2)),
            );

            setState(() {
              _notificationsEnabled = true;
            });
          }
        });
      }
    } else {
      await Permission.notification.status.then((status) {
        if (status.isGranted) {
          showDialog(
            context: context,
            builder: (BuildContext context) => const CustomDialogNoButtons(
                title: 'Manual notification disable required',
                content:
                'Please disable the notifications in your phone settings',
                icon: Icons.restore_from_trash_outlined,
                duration: Duration(seconds: 2)),
          );

          setState(() {
            _notificationsEnabled = true;
          });
        }
      });
    }
  }

  void showAboutDialog() async {
    await PackageInfo.fromPlatform().then((packageInfo) {
      String appName = packageInfo.appName;
      String version = packageInfo.version;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Close button at the top left
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  // Logo at the top
                  const CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage(
                        'assets/images/taborniski_sos_prirocnik_logo.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: 20),
                  // Custom content here
                  Text(appName,
                      style:
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text('Developed by: Nejc Podlogar',
                      style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  Text('Version $version', style: const TextStyle(fontSize: 12)),
                  const Text('© 2024 Nejc Podlogar',
                      style: TextStyle(fontSize: 10)),
                  const SizedBox(height: 50),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: primaryCardTheme.color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => LicensePage(
                                applicationName: appName,
                                applicationVersion: version,
                                applicationIcon: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 40.0,
                                  child: Image.asset(
                                      'assets/images/taborniski_sos_prirocnik_logo.png'),
                                ),
                                applicationLegalese: '© 2024 Nejc Podlogar',
                              ),
                            ));
                          },
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                            child: Text('View Licenses',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white)),
                          ),
                        ),
                      ])
                ],
              ),
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final S localisations = S.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
                height: 250,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/images/rsk_logo.png'),
                          backgroundColor: Colors.transparent,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(width: 50),
                            IntrinsicWidth(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minWidth: 100,
                                ),
                                child: TextField(
                                    textAlign: TextAlign.center,
                                    autofocus: _isEditing,
                                    onEditingComplete: () {
                                      _saveUserName();
                                      setState(() {
                                        _isEditing = false;
                                      });
                                    },
                                    onSubmitted: (value) {
                                      _saveUserName();
                                      setState(() {
                                        _isEditing = false;
                                      });
                                    },
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'JetBrains Mono',
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                    controller: _nameController,
                                    enabled: _isEditing,
                                    showCursor: _isEditing,
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                      border: _isEditing
                                          ? const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            )
                                          : InputBorder.none,
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                    )),
                              ),
                            ),
                            if (_isEditing)
                              IconButton(
                                icon: const Icon(
                                  Icons.save,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                onPressed: () {
                                  _saveUserName();
                                  setState(() {
                                    _isEditing = false;
                                  });
                                },
                              )
                            else
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isEditing = true;
                                  });
                                },
                              ),
                          ],
                        ),
                      ],
                    )),
                    Positioned(
                        top: 0,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(
                                  Icons.house_outlined,
                                  size: 32.0,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  context.go('/home');
                                },
                              ),
                              Text(
                                localisations.settings,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'JetBrains Mono',
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.info_outline_rounded,
                                  size: 32.0,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        )),
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.90,
              height: 36,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryCardTheme.color),
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  localisations.preferences.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'JetBrains Mono',
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(children: <Widget>[
                    Icon(Icons.nightlight_outlined,
                        color: primaryCardTheme.color),
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          localisations.darkMode,
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'JetBrains Mono',
                              fontWeight: FontWeight.w300,
                              color: primaryCardTheme.color),
                        ))
                  ]),
                  checkmarkSwitch(
                      value: _darkModeEnabled,
                      callback: (bool value) {
                        context.read<ThemeBloc>().add(ToggleThemeEvent());
                        setState(() {
                          _darkModeEnabled = value;
                        });
                      }
                  )
                ],
              ),
            ),
            Divider(
              color: primaryCardTheme.color,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(children: <Widget>[
                    Icon(
                      Icons.notifications_active_outlined,
                      color: primaryCardTheme.color,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        localisations.allowNotifications,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'JetBrains Mono',
                            fontWeight: FontWeight.w300,
                            color: primaryCardTheme.color),
                      ),
                    )
                  ]),
                  checkmarkSwitch(
                    value: _notificationsEnabled,
                    callback: (bool value) {
                      print('Toggling notifications: $value');
                      _toggleNotifications(value);
                    },
                  )
                ],
              ),
            ),
            Divider(
              color: primaryCardTheme.color,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(children: <Widget>[
                    Icon(
                      Icons.credit_card_outlined,
                      color: primaryCardTheme.color,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        localisations.permissions,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'JetBrains Mono',
                            fontWeight: FontWeight.w300,
                            color: primaryCardTheme.color),
                      ),
                    )
                  ]),

                  /// add a button

                  ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              primaryCardTheme.color!),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  25.0), // Set the corner radius here
                            ),
                          )),
                      child: Text(
                        localisations.manage.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontFamily: 'JetBrains Mono',
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
            ),
            Divider(
              color: primaryCardTheme.color,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(children: <Widget>[
                    Icon(
                      Icons.dataset_outlined,
                      color: primaryCardTheme.color,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        localisations.deleteData,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'JetBrains Mono',
                            fontWeight: FontWeight.w300,
                            color: primaryCardTheme.color),
                      ),
                    )
                  ]),

                  /// add a button
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryCardTheme.color),
                    child: IconButton(
                        onPressed: _clearLocalStorage,
                        icon: const Icon(Icons.restore_from_trash_outlined,
                            color: Colors.white)),
                  )
                ],
              ),
            ),
            Divider(
              color: primaryCardTheme.color,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                    onPressed: () => showAboutDialog(),
                    child: Text(localisations.about,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: primaryCardTheme.color,
                        )))
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}
