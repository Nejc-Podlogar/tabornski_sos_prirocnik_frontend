import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/pdf_custom_viewer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/models.dart' as models;

class MaterialsWidget extends StatelessWidget {
  final List<models.Material> materials;

  const MaterialsWidget({Key? key, required this.materials}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${AppLocalizations.of(context)!.materials}:',
                style: Theme.of(context).textTheme.headlineMedium,

              ),
            ]),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Center( // Add this
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: materials.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.all(10),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).hintColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    size: 24,
                                    Icons.file_copy_outlined,
                                    color: Theme.of(context).hintColor,
                                  ),
                                  onPressed: () {
                                      // Open the material pdf
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PDFScreen(path: materials[index].file, title: materials[index].name,),
                                        ),
                                      );
                                  },
                                ))),
                        SizedBox(
                          width: 100,
                          child: Text(
                            materials[index].name,
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ) // Add this
          ),
        )
      ],
    );
  }
}
