
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/post.dart';
import 'package:http/http.dart' as http;


class PostApiService {

  Future<Post> getLatestPost() async {

    final response = await http.get(
      Uri.parse('${dotenv.env['BASE_URL']}/posts/latest')
    );

    if (response.statusCode == 200) {
      final dynamic responseJson = jsonDecode(response.body);
      print(responseJson);
      return Post(
        title: responseJson ['title'],
        content: responseJson['content'],
        link: responseJson['link']
      );
    } else {
      throw Exception('Failed to load post');
    }

  }

}