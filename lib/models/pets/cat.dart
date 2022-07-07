import 'package:wa_test_app/models/breed.dart';
import 'package:wa_test_app/models/category.dart';
import 'package:wa_test_app/models/pet.dart';

class Cat extends Pet {
  Cat({
    required String id,
    required String url,
    List<Breed> breeds = const [],
    List<Category> categories = const [],
  }) : super(id: id, url: url, breeds: breeds, categories: categories);

  factory Cat.fromJson(Map<String, dynamic> json) {
    var id = json["id"];
    var url = json["url"];
    var breedList = (json["breeds"] as List?) ?? [];
    var breeds = breedList.map((breed) => Breed.fromJson(breed)).toList();
    var categoryList = (json["categories"] as List?) ?? [];
    var categories = categoryList.map((category) => Category.fromJson(category)).toList();

    return Cat(id: id, url: url, breeds: breeds, categories: categories);
  }

  @override
  String toString() {
    return """
      id: $id,
      url: $url,
      breeds: $breeds,
      categories: $categories,
    """;
  }
}
