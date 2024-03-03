import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tabornski_sos_prirocnik_frontend/models/models.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/MorseCodeCustomDisplay.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/custom_app_bar.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/navigation_bottom.dart';

class MorseCodeMaterials extends StatefulWidget {
  const MorseCodeMaterials({Key? key}) : super(key: key);

  @override
  _MorseCodeMaterialsViewState createState() => _MorseCodeMaterialsViewState();
}

class _MorseCodeMaterialsViewState extends State<MorseCodeMaterials> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<MorseCodeElement> _morseCodeMaterials = MorseCodeLanguage.morseCodeList;
  Set<FilterType> selection = {};

  @override
  void initState() {
    super.initState();
    selection.clear();
    selection.add(FilterType.All);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: const CustomAppBar(title: 'Morse Code Materials', enablePopButton: true),
      bottomNavigationBar: CustomBottomNavigation(),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Center(
            child: Wrap(
              spacing: 8.0,
              children: FilterType.values.map((filterType) {
                return ChoiceChip(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: selection.contains(filterType)
                          ? Colors.transparent
                          : Theme.of(context).hintColor,
                      width: 1.5
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: selection.contains(filterType)
                        ? Colors.white
                        : Colors.black,
                  ),
                  selectedColor: Theme.of(context).hintColor,
                  label: Text(
                    filterType.name,
                  ),
                  selected: selection.contains(filterType),
                  onSelected: (selected) {
                    setState(() {
                      selection.clear();
                      selection.add(filterType);
                    });
                  },
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _morseCodeMaterials.length,
              itemBuilder: (context, index) {
                final morseCodeMaterial = _morseCodeMaterials[index];
                if (selection.contains(morseCodeMaterial.filterType) ||
                    selection.contains(FilterType.All)) {
                  return GestureDetector(
                    onTap: () => Clipboard.setData(ClipboardData(text: morseCodeMaterial.morseCode)),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding:
                              const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: SizedBox(
                            height: 45,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Text(
                                    morseCodeMaterial.letter,
                                    style: const TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.white,
                                  thickness: 2,
                                  indent: 10,
                                  endIndent: 10,
                                  width: 20,
                                ),
                                Expanded(
                                  child: Center(
                                      child: MorseCodeCustomDisplay(morseCodeText: morseCodeMaterial.morseCode,)
                                  ),
                                ),
                              ],
                            )
                          ),
                        )),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
