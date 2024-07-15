
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tabornski_sos_prirocnik_frontend/models/orientation.dart';

class OrientationApiService {

  Future<dynamic> getExercise(int numberOfElements, categories) async {
    //Create a json body custom for the following request
    Map<String, dynamic> createBodyJson() {
      return {
        'numberOfElements': numberOfElements,
        'type': categories.map((OrientationTopoCategory e) => e.name).toList()
      };
    }
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(createBodyJson());

    final response = await http.post(
      Uri.parse('${dotenv.env['BASE_URL']}/orientation/get-exercise'),
      headers: headers,
      body: body
    );

    if (response.statusCode == 200) {
      final dynamic responseList = jsonDecode(response.body);
      return OrientationExercise(
          names: List<String>.from(responseList['names']),
          images: List<String>.from(responseList['imageLoc']),
          areCombinationsCorrect: List<bool>.from(responseList['areCombinationsCorrect'])
      );
    } else {
      throw Exception('Failed to load exercise');
    }

  }

}