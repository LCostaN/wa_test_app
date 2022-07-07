import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wa_test_app/models/pets/cat.dart';

class CatRepository {
  String url = "https://api.thecatapi.com/v1/images/search?limit=20";
  String apiKey = "f6411020-e210-4b4f-ada4-0347843f8375";

  Future<List<Cat>> getList() async {
    final response = await http.get(
      Uri.parse(url),
      headers: {"x-api-key": apiKey, "Content-Type": "application/json"},
    );
    
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as List;
      List<Cat> list = json.map((e) => Cat.fromJson(e)).toList();
      return list;
    } else {
      throw Exception('Failed to load Cat');
    }
  }
}
