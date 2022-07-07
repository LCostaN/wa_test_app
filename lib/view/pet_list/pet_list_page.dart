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
  List<Pets> filterPets = [...Pets.values];
  List<Pet> showPets = [];

  bool loading = false;
  bool filterIsOpen = false;

  ScrollController gridController = ScrollController();

  @override
  void initState() {
    super.initState();
    gridController.addListener(() {
      var nextPageTrigger = 0.95 * gridController.position.maxScrollExtent;

      if (gridController.position.pixels > nextPageTrigger && !loading) {
        loadPets();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadPets();
    });
  }

  @override
  void dispose() {
    gridController.dispose();
    super.dispose();
  }

  Future<void> loadPets() async {
    if (loading) return;

    setState(() => loading = true);

    Map<Pets, List<Pet>> newEntries = await PetService().getAll();

    newEntries.forEach((key, newList) { // Add entries to allPets
      allPets.update(
        key,
        (oldList) {
          oldList.addAll(newList);
          return oldList;
        },
        ifAbsent: () => newList,
      );
    });

    List<Pet> newShowList = []; // Only new entries to be shuffled
    newEntries.forEach((pet, list) {
      if (filterPets.contains(pet)) {
        newShowList.addAll(list);
      }
    });

    newShowList.shuffle();
    showPets.addAll(newShowList);

    setState(() => loading = false);
  }

  void filterAll() {
    setState(() => loading = false);

    showPets = [];
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
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: Visibility(
                visible: filterIsOpen,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: filterIsOpen ? Pets.values.length : 0,
                  itemBuilder: (context, index) {
                    var currentFilter = Pets.values[index];

                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () => toggleFilter(currentFilter),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                filterPets.contains(currentFilter)
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_off,
                              ),
                              const SizedBox(width: 12),
                              Text(currentFilter.name.toUpperCase()),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                controller: gridController,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: showPets.length + (loading ? 1 : 0),
                itemBuilder: (context, index) => index == showPets.length
                    ? const CircularProgressIndicator()
                    : GestureDetector(
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

  void toggleFilter(Pets filter) {
    if (filterPets.contains(filter)) {
      setState(() => filterPets.remove(filter));
    } else {
      setState(() => filterPets.add(filter));
    }

    filterAll();
  }

  void goToDetails(Pet pet) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PetDetailsPage(pet: pet),
      ),
    );
  }

  void openFilter() {
    setState(() => filterIsOpen = !filterIsOpen);
  }
}
