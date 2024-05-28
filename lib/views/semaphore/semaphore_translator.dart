import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/semaphore_bloc/semaphore_bloc.dart';
import 'package:tabornski_sos_prirocnik_frontend/models/semaphore.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/navigation_bottom.dart';

class SemaphoreTranslatorView extends StatefulWidget {
  const SemaphoreTranslatorView({Key? key}) : super(key: key);

  @override
  _SemaphoreTranslatorViewState createState() => _SemaphoreTranslatorViewState();
}

class _SemaphoreTranslatorViewState extends State<SemaphoreTranslatorView> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textTranslatedController = TextEditingController();

  final List<String> _translatedImages = [
    'assets/images/semaphore/flags/A_1.png',
    'assets/images/semaphore/flags/A_1.png',
    'assets/images/semaphore/flags/A_1.png',
    'assets/images/semaphore/flags/A_1.png',
    'assets/images/semaphore/flags/A_1.png',
    'assets/images/semaphore/flags/A_1.png',
    'assets/images/semaphore/flags/A_1.png',
    'assets/images/semaphore/flags/A_1.png',
    'assets/images/semaphore/flags/A_1.png',
    'assets/images/semaphore/flags/A_1.png',
    'assets/images/semaphore/flags/A_1.png',
    'assets/images/semaphore/flags/A_1.png',
    'assets/images/semaphore/flags/A_1.png',
    'assets/images/semaphore/flags/A_1.png',
    'assets/images/semaphore/flags/A_1.png',
    'assets/images/semaphore/flags/A_1.png',
    'assets/images/semaphore/flags/A_1.png',
    'assets/images/semaphore/flags/A_1.png',
    'assets/images/semaphore/flags/A_1.png',
    'assets/images/semaphore/flags/A_1.png',
    'assets/images/semaphore/flags/A_1.png',
  ];

  // Handle inpute translation
  void _handleInputTranslation(String input) {
    final semaphoreTranslationBloc = BlocProvider.of<SemaphoreBloc>(context);
    // add morseCodeLanguageModel from the current state and the input wit TranslateInput event
    semaphoreTranslationBloc.add(TranslateInputSemaphore(
        inputText: input,
        semaphoreLanguageModel:
        (semaphoreTranslationBloc.state as SemaphoreInitial)
            .languageSetting));
  }

  Row _buildButtonsRow(BuildContext context, dynamic leftButtonContent,
      dynamic rightButtonContent) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildLanguageButton(context, leftButtonContent,
            isOnlyButton: rightButtonContent == null),
        if (rightButtonContent != null) ...[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_forward,
              size: 40,
              color: Theme.of(context).appBarTheme.iconTheme?.color,
            ),
          ),
          _buildLanguageButton(context, rightButtonContent),
        ]
      ],
    );
  }

  SizedBox _buildLanguageButton(BuildContext context, dynamic content,
      {bool isOnlyButton = false}) {
    return SizedBox(
      width: isOnlyButton
          ? MediaQuery.of(context).size.width * 0.5
          : MediaQuery.of(context).size.width * 0.3,
      height: 60,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).hintColor,
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: () => _showtranslationTypeBottomSheet(context),
          child: content.endsWith('.svg')
              ? SvgPicture.asset(
            content,
            fit: BoxFit.contain,
          )
              : Text(
            content,
            textAlign: TextAlign.center,
          )),
    );
  }

  void _showtranslationTypeBottomSheet(BuildContext context) {
    final morseTranslationBloc = BlocProvider.of<SemaphoreBloc>(context);
    final currentTranslationType =
        (morseTranslationBloc.state as SemaphoreInitial)
            .languageSetting
            .semaphoreSetting;

    showModalBottomSheet(
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            )),
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildListTile(
                    context,
                    'Besedilo v Semafor (zastavice)',
                    SemaphoreLanguageSetting.textToFlags,
                    currentTranslationType,
                    morseTranslationBloc),
                _buildListTile(
                    context,
                    'Semafor (zastavice) v besedilo',
                    SemaphoreLanguageSetting.flagsToText,
                    currentTranslationType,
                    morseTranslationBloc),
                const SizedBox(height: 20),
              ],
            ),
          );
        });
  }

  Widget _buildListTile(
      BuildContext context,
      String title,
      SemaphoreLanguageSetting setting,
      SemaphoreLanguageSetting currentTranslationType,
      SemaphoreBloc morseTranslationBloc) {
    return Container(
      decoration: BoxDecoration(
        color: currentTranslationType == setting
            ? Theme.of(context).hintColor
            : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        title: Text(title,
            style: TextStyle(
                color: currentTranslationType != setting
                    ? Colors.black
                    : Colors.white)),
        trailing: currentTranslationType == setting
            ? const Icon(Icons.check, color: Colors.white)
            : null,
        onTap: () {
          morseTranslationBloc
              .add(UpdateTranslationTypeSemaphore(semaphoreLanguageType: setting));
          context.pop();
        },
      ),
    );
  }


  Widget translatedInfoBlock(BuildContext context, List<String> translatedImages) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 50),
      child: Center(
        child: Wrap(
          direction: Axis.horizontal,
          clipBehavior: Clip.hardEdge,
          alignment: WrapAlignment.start,
          children: <Widget>[
            for (String image in translatedImages)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  image,
                  width: 50,
                  height: 50,
                ),
              )],
        ),
      ),
    );
  }

  // Custom Flag Image Picker
  Future<void> _pickImage() async {
    await showModalBottomSheet(
        context: context,
        showDragHandle: true,

        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            )),
        builder: (BuildContext context) {
          // Create a new list where each SemaphoreElement has a unique flagImageURL
          var uniqueSemaphoreList = <SemaphoreElement>[];
          var urlMap = <String, bool>{};

          for (var element in SemaphoreLanguage.semaphoreList) {
            if (urlMap[element.flagImageURL] == null) {
              urlMap[element.flagImageURL.toString()] = true;
              uniqueSemaphoreList.add(element);
            }
          }

          return GridView.count(
            crossAxisCount: 3,
            children: uniqueSemaphoreList.map((SemaphoreElement element) {
              return GestureDetector(
                  onTap: () {
                    BlocProvider.of<SemaphoreBloc>(context).add(UpdateSemaphoreImage(image: element.flagImageURL));
                  },
                  child: Image.asset(
                    element.flagImageURL.toString(),
                    width: 50,
                    height: 50,
                  )
              );
            }).toList(),
          );
        }
    );

    final semaphoreBloc = BlocProvider.of<SemaphoreBloc>(context);
    semaphoreBloc.add(TranslateInputSemaphore(
      inputText: semaphoreBloc.state.languageSetting.flags,
      semaphoreLanguageModel: semaphoreBloc.state.languageSetting,
    ));
  }

  List<Widget> _buildTranslationWidget(BuildContext context, SemaphoreState state, bool isTextFieldEnabled) {
    if (state.languageSetting.semaphoreSetting == SemaphoreLanguageSetting.textToFlags || state.languageSetting.semaphoreSetting == SemaphoreLanguageSetting.none) {
      return <Widget> [
        Expanded(
          flex: 4, // 40% of the available space
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: SingleChildScrollView(
                child: TextField(
                  controller: _textEditingController,
                  enabled: isTextFieldEnabled,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: isTextFieldEnabled
                        ? 'Vnesi besedilo...'
                        : 'Izberi vrsto prevoda',
                    border: InputBorder.none,
                  ),
                  onChanged: _handleInputTranslation,
                ),
              ),
            ),
          ),
        ),
        const Divider(
          color: Colors.black,
          endIndent: 15,
          indent: 15,
          thickness: 1,
        ),
        Expanded(
            flex: 6,
            child: Stack(children: <Widget>[
              SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: translatedInfoBlock(context, state.languageSetting.flags ?? [])
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          onPressed: () {
                            _textEditingController.clear();
                            BlocProvider.of<SemaphoreBloc>(
                                context)
                                .add(ClearInputSemaphore());
                          },
                          icon: const Icon(
                              Icons.delete_outline_outlined)),
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: Column(
                                    children: [
                                      Expanded(child: translatedInfoBlock(context, state.languageSetting.flags ?? [])),
                                      IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.zoom_in_outlined)
                      )
                    ],
                  ))
            ])),
      ];
    } else if (state.languageSetting.semaphoreSetting == SemaphoreLanguageSetting.flagsToText) {
      return <Widget> [
        Expanded(
            flex: 6,
            child: Stack(children: <Widget>[
              GestureDetector(
                onTap: _pickImage,
                child: state.languageSetting.flags == null || state.languageSetting.flags!.isEmpty ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.touch_app_outlined),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Text('Izberi zastavice...'),
                      ),
                    ],
                  ),
                ) : SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: translatedInfoBlock(context, state.languageSetting.flags ?? [])
                  ),
                )
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: Column(
                                    children: [
                                      Expanded(child: translatedInfoBlock(context, state.languageSetting.flags ?? [])),
                                      IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.zoom_in_outlined)
                      )
                    ],
                  ))
            ])),
        const Divider(
          color: Colors.black,
          endIndent: 15,
          indent: 15,
          thickness: 1,
        ),
        Expanded(
          flex: 4, // 40% of the available space
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: SingleChildScrollView(
                    child: TextField(
                      controller: _textTranslatedController,
                      enabled: false,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Prevedno besedilo...',
                        border: InputBorder.none,
                      ),
                      onChanged: _handleInputTranslation,
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          onPressed: () {
                            _textEditingController.clear();
                            BlocProvider.of<SemaphoreBloc>(
                                context)
                                .add(ClearInputSemaphore());
                          },
                          icon: const Icon(
                              Icons.delete_outline_outlined)),
                      IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: _textTranslatedController.text));
                          },
                          icon: const Icon(Icons.copy_rounded)
                      )
                    ],
                  ))
            ],
          ),
        ),
      ];
    } else {
      return <Widget>[Container()];
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(
          title: 'Morse Code Translator',
          enablePopButton: true,
        ),
        bottomNavigationBar: CustomBottomNavigation(),
        body: Stack(children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: BlocBuilder<SemaphoreBloc, SemaphoreState>(
              builder: (context, state) {
                bool isTextFieldEnabled = true;
                if (state is SemaphoreInitial &&
                    state.languageSetting.semaphoreSetting ==
                        SemaphoreLanguageSetting.none) {
                  isTextFieldEnabled = false;

                  _textEditingController.text =
                      state.languageSetting.text ?? '';
                }

                if(state.languageSetting.semaphoreSetting == SemaphoreLanguageSetting.flagsToText) {
                  _textTranslatedController.text = state.languageSetting.text ?? '';
                }

                return Container(
                  height: MediaQuery.of(context).size.height * 0.58,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Column(children: _buildTranslationWidget(context, state, isTextFieldEnabled),),
                );
              },
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: IgnorePointer(
                ignoring: isKeyboardOpen,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child:
                  BlocBuilder<SemaphoreBloc, SemaphoreState>(
                    builder:
                        (BuildContext context, SemaphoreState state) {
                      if (state is SemaphoreInitial &&
                          state.languageSetting.semaphoreSetting ==
                              SemaphoreLanguageSetting.textToFlags) {
                        return _buildButtonsRow(context, 'Besedilo',
                            'assets/icons/morse_code_icon.svg');
                      } else if (state is SemaphoreInitial &&
                          state.languageSetting.semaphoreSetting ==
                              SemaphoreLanguageSetting.flagsToText) {
                        return _buildButtonsRow(context,
                            'assets/icons/morse_code_icon.svg', 'Besedilo');
                      } else {
                        // Create a button that will open a popup where the user can select the translation type
                        return _buildButtonsRow(
                            context, 'Izberi vrsto prevoda', null);
                      }
                    },
                  ),
                ),
              ))
        ]));
  }

}