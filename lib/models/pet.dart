import 'package:wa_test_app/models/breed.dart';
import 'package:wa_test_app/models/category.dart';

class Pet {
  final String id;
  final String url;
  final List<Breed> breeds;
  final List<Category> categories;

  Pet({required this.breeds, required this.categories, required this.id, required this.url});
}
