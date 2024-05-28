import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabornski_sos_prirocnik_frontend/models/semaphore.dart';
import 'package:tabornski_sos_prirocnik_frontend/utils/custom_converters.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/custom_app_bar.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/navigation_bottom.dart';

class SemaphoreMaterialsView extends StatefulWidget {
  @override
  _SemaphoreMaterialsState createState() => _SemaphoreMaterialsState();
}

class _SemaphoreMaterialsState extends State<SemaphoreMaterialsView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<SemaphoreElement> _semaphoreMaterials = SemaphoreLanguage.semaphoreList;
  Set<FilterSemaphoreType> selection = {};

  @override
  void initState() {
    super.initState();
    selection.clear();
    selection.add(FilterSemaphoreType.All);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: const CustomAppBar(title: 'Semaphore Materials', enablePopButton: true,),
      bottomNavigationBar: CustomBottomNavigation(),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Center(
            child: Wrap(
              spacing: 8.0,
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              children: FilterSemaphoreType.values.map((filterType) {
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
                  onSelected: (bool selected) {
                    setState(() {
                      selection.clear();
                      selection.add(filterType);
                    });
                  },
                );
              }).toList(),
            )
          ),
          const SizedBox(height: 20),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 15.0
                    ),
                    itemCount: _semaphoreMaterials.where((element) => selection.contains(element.filterType) || selection.contains(FilterSemaphoreType.All)).length,
                    itemBuilder: (BuildContext context, int index) {
                      final semaphoreElement = _semaphoreMaterials.where((element) => selection.contains(element.filterType) || selection.contains(FilterSemaphoreType.All)).toList()[index];
                      return Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(semaphoreElement.flagImageURL ?? '', width: MediaQuery.of(context).size.width * 0.3),
                                Text(
                                  Convertors.convertFlagTitleToReadableText(semaphoreElement.letter),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
          )
        ]
      ),
    );
  }
}