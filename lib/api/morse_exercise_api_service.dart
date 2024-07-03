

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tabornski_sos_prirocnik_frontend/models/models.dart';
import 'package:http/http.dart' as http;

class MorseExerciseApiService {

  Future<MorseCodeLanguage> getSpecificExercise(MorseCodeLearningParams params) async {

    //Create a json body custom for the following request
    Map<String, dynamic> createBodyJson() {
      return {
        'type': params.learningAmount.name.toString(),
        'translateType': params.learningType.name.toString(),
        'numberOfElements': params.numberOfIterations,
      };
    }
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(createBodyJson());


    final response = await http.post(
    Uri.parse('${dotenv.env['BASE_URL']}/morse-exercise/get-exercise'),
    headers: headers,
    body: body);


    if (response.statusCode == 200) {
      final dynamic responseList = jsonDecode(response.body);
      return MorseCodeLanguage(
        value: List<String>.from(responseList['value']),
        translatedValue: List<String>.from(responseList['translatedValue']),
        languageSetting: params.learningType,
      );
    } else {
      throw Exception('Failed to load exercise');
    }
  }

}