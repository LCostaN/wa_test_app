import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wa_test_app/models/pets/dog.dart';

class DogRepository {
  String url = "https://api.thedogapi.com/v1/images/search?limit=20";
  String apiKey = "5d999c68-a6c8-409a-9e2e-ba249808ad50";

  Future<List<Dog>> getList() async {
    final response = await http.get(
      Uri.parse(url),
      headers: {"x-api-key": apiKey, "Content-Type": "application/json"},
    );
    
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as List;
      List<Dog> list = json.map((e) => Dog.fromJson(e)).toList();
      return list;
    } else {
      throw Exception('Failed to load Dog');
    }
  }
}
