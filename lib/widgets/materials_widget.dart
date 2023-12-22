import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/models.dart' as models;

class MaterialsWidget extends StatelessWidget {
  final List<models.Material> materials;

  const MaterialsWidget({Key? key, required this.materials}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Gradiva:',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'JetBrains Mono',
                  fontWeight: FontWeight.normal,
                ),

              ),
            ]),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Center( // Add this
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: materials.length,

                  itemBuilder: (context, index) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                    onPressed: () {},
                                  ))),
                          SizedBox(
                            width: 50,
                            child: Text(
                              materials[index].name,
                              style: const TextStyle(
                                fontFamily: 'JetBrains Mono',
                                color: Colors.black,
                                fontSize: 7,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                            ),
                          )
                        ],
                      )
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
