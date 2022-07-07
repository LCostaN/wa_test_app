import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wa_test_app/models/breed.dart';
import 'package:wa_test_app/models/category.dart';
import 'package:wa_test_app/models/pet.dart';
import 'package:wa_test_app/view/common/wa_app_bar.dart';

class PetDetailsPage extends StatefulWidget {
  const PetDetailsPage({Key? key, required this.pet}) : super(key: key);

  final Pet pet;

  @override
  State<PetDetailsPage> createState() => _PetDetailsPageState();
}

class _PetDetailsPageState extends State<PetDetailsPage> {
  bool breedsIsOpen = false;
  bool categoriesIsOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WaAppBar(title: "Pet Details"),
      body: SafeArea(
        child: ListView(
          children: [
            CachedNetworkImage(imageUrl: widget.pet.url),
            ListTile(
              title: const Text("ID"),
              trailing: Text(widget.pet.id),
            ),
            ListTile(
              title: const Text("Breeds"),
              trailing: Text(widget.pet.breeds.length.toString()),
              onTap: widget.pet.breeds.isNotEmpty ? openBreeds : null,
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: buildBreeds(widget.pet.breeds),
            ),
            ListTile(
              title: const Text("Categories"),
              trailing: Text(widget.pet.categories.length.toString()),
              onTap: widget.pet.categories.isNotEmpty ? openCategories : null,
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: buildCategories(widget.pet.categories),
            ),
          ],
        ),
      ),
    );
  }

  void openBreeds() {
    setState(() => breedsIsOpen = !breedsIsOpen);
  }

  void openCategories() {
    setState(() => categoriesIsOpen = !categoriesIsOpen);
  }

  Widget buildCategories(List<Category> list) {
    double height = categoriesIsOpen ? min(list.length * 60, 300) : 0;

    return AnimatedContainer(
      height: height,
      duration: const Duration(milliseconds: 300),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, i) => ListTile(
          title: Text(list[i].name),
          leading: Text(list[i].id.toString()),
        ),
      ),
    );
  }

  Widget buildBreeds(List<Breed> list) {
    double height = breedsIsOpen ? min(list.length * 60, 300) : 0;

    return AnimatedContainer(
      height: height,
      duration: const Duration(milliseconds: 300),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, i) => ListTile(
          leading: Text(list[i].id),
          title: Text(list[i].name),
          subtitle: Text(list[i].temperament),
        ),
      ),
    );
  }
}
