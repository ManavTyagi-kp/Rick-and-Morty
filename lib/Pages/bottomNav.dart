import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rickandmorty/Pages/chractersList.dart';
import 'package:rickandmorty/Pages/episodeList.dart';
import 'package:rickandmorty/utility/riverpod.dart';

import 'locationList.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  bool _search = false;
  late TabController _tabController;
  String query = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    print(_tabController.index);
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        appBar: AppBar(
          // scrolledUnderElevation: 100,
          forceMaterialTransparency: false,
          backgroundColor: const Color.fromARGB(255, 248, 224, 138),
          elevation: 10,
          shadowColor: const Color.fromARGB(186, 35, 32, 18),
          leading: _search
              ? TextButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () {
                    setState(() {
                      _search = false;
                      ref.watch(fetchChar.notifier).startQuery('');
                      ref.watch(fetchLoc.notifier).startQuery('');
                      ref.watch(fetchEpisode.notifier).startQuery('');
                    });
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                  ),
                )
              : const Icon(null),
          title: _search
              ? Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(169, 255, 250, 208),
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            return _searchController.clear();
                          },
                        ),
                        hintText: 'Search...',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        query = 'name=$value';
                        setState(() {
                          if (_tabController.index == 0) {
                            ref.watch(fetchChar.notifier).startQuery(query);
                          } else if (_tabController.index == 1) {
                            ref.watch(fetchLoc.notifier).startQuery(query);
                          } else {
                            ref.watch(fetchEpisode.notifier).startQuery(query);
                          }
                        });
                      },
                    ),
                  ),
                )
              : const Text('Rick and Morty'),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _search = true;
                });
              },
              icon: _search ? const Icon(null) : const Icon(Icons.search),
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                icon: Icon(Icons.person_4_outlined),
              ),
              Tab(
                icon: Icon(Icons.location_history),
              ),
              Tab(
                icon: Icon(Icons.live_tv),
              ),
            ],
          ),
        ),
        // backgroundColor: const Color.fromARGB(255, 248, 224, 138),
        backgroundColor: const Color.fromARGB(255, 248, 224, 138),
        body: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            CharacterListPod(),
            LocationListCustom(),
            EpisodeListPod(),
          ],
        ),
      );
    });
  }
}
