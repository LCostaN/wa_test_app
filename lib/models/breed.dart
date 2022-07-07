class Breed {
  final String id;
  final String name;
  final String temperament;

  Breed({
    required this.id,
    required this.name,
    required this.temperament,
  });

  factory Breed.fromJson(Map<String, dynamic> json) {
    var id = json["id"].toString();
    var name = json["name"];
    var temperament = json["temperament"];

    return Breed(id: id, name: name, temperament: temperament);
  }
}
