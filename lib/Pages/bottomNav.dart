import 'package:flutter/material.dart';
import 'package:rickandmorty/Pages/chractersList.dart';
import 'package:rickandmorty/Pages/episodeList.dart';

import 'locationList.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // _filteredData = _data;
    _searchController.addListener(_performSearch);
  }

  Future<void> _performSearch() async {
    setState(() {
      _isLoading = true;
    });
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 23, 21, 138),
                Color.fromARGB(255, 228, 195, 51)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
          child: Container(
            width: MediaQuery.of(context).size.width - 150,
            height: 40,
            decoration: BoxDecoration(
                color: const Color.fromARGB(162, 255, 255, 255),
                borderRadius: BorderRadius.circular(100)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        /* Clear the search field */
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedIndex: currentIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_4_outlined),
            label: 'Characters',
          ),
          NavigationDestination(
            icon: Icon(Icons.location_history),
            label: 'Locations',
          ),
          NavigationDestination(
            icon: Icon(Icons.live_tv),
            label: 'Episodes',
          ),
        ],
      ),
      body: [
        const CharacterList(),
        const LocationList(),
        const EpisodeList(),
      ][currentIndex],
    );
  }
}
