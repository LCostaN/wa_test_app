import 'package:wa_test_app/models/pet.dart';
import 'package:wa_test_app/models/pets/cat.dart';
import 'package:wa_test_app/models/pets/dog.dart';
import 'package:wa_test_app/repository/pets/cat_repository.dart';
import 'package:wa_test_app/repository/pets/dog_repository.dart';

enum Pets {
  dog,
  cat,
}

class PetService {
  Future<Map<Pets, List<Pet>>> getAll() async {
    List<Dog> dogs = await getDogList();
    List<Cat> cats = await getCatList();
    
    Map<Pets, List<Pet>> map = {
      Pets.dog: dogs,
      Pets.cat: cats,
    };

    return map;
  }

  Future getDetails(Pets type, String id) async {}
  
  Future<List<Cat>> getCatList() async {
    List<Cat> list = await CatRepository().getList();
    
    return list;
  }

  Future<List<Dog>> getDogList() async {
    List<Dog> list = await DogRepository().getList();
    
    return list;
  }
}