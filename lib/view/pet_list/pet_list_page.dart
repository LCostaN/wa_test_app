import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wa_test_app/models/pet.dart';
import 'package:wa_test_app/services/pet_service.dart';
import 'package:wa_test_app/view/common/wa_app_bar.dart';
import 'package:wa_test_app/view/common/wa_app_drawer.dart';
import 'package:wa_test_app/view/pet_details/pet_details_page.dart';

class PetListPage extends StatefulWidget {
  const PetListPage({Key? key}) : super(key: key);

  @override
  State<PetListPage> createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  Map<Pets, List<Pet>> allPets = {};
  List<Pets> filterPets = Pets.values;
  List<Pet> showPets = [];

  bool loading = true;
  bool filterIsOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadPets();
    });
  }

  Future<void> loadPets() async {
    setState(() => loading = true);

    allPets = await PetService().getAll();
    allPets.forEach((pet, list) {
      if (filterPets.contains(pet)) {
        showPets.addAll(list);
      }
    });

    showPets.shuffle();

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WaAppBar(
        title: "Pet List",
        actions: [
          IconButton(onPressed: openFilter, icon: const Icon(Icons.filter_alt)),
        ],
      ),
      drawer: const WaAppDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // AnimatedSize(
            //   duration: const Duration(milliseconds: 300),
            //   child: ListView.builder(
            //     itemCount: filterIsOpen ? Pets.values.length : 0,
            //     itemBuilder: (context, index) => RadioListTile(value: value, groupValue: groupValue, onChanged: onChanged),
            //   ),
            // ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: showPets.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => goToDetails(showPets[index]),
                  child: GridTile(
                    child: CachedNetworkImage(
                      imageUrl: showPets[index].url,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void goToDetails(Pet pet) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PetDetailsPage(pet:pet),
      ),
    );
  }

  void openFilter() {
    setState(() => filterIsOpen = !filterIsOpen);
  }
}
