import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:rickandmorty/Pages/chractersList.dart';
import 'package:rickandmorty/Pages/episodeList.dart';
import 'package:rickandmorty/utility/models.dart' as models;

import 'locationList.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<BottomNav> {
  GlobalKey<CharacterListState> characterListKey =
      GlobalKey<CharacterListState>();
  GlobalKey<LocationListState> locationListKey = GlobalKey<LocationListState>();
  GlobalKey<EpisodeListState> episodeListKey = GlobalKey<EpisodeListState>();

  final TextEditingController _searchController = TextEditingController();
  bool _search = false;
  late TabController _tabController;
  String query = '';
  String charUrl = 'https://rickandmortyapi.com/api/character/';
  String locUrl = 'https://rickandmortyapi.com/api/location';
  String epiUrl = 'https://rickandmortyapi.com/api/episode';

  @override
  void initState() {
    super.initState();
    // _filteredData = _data;
    _tabController = TabController(length: 3, vsync: this);
    // _searchController.addListener(_performSearch);
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print(_tabController.index);
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 100,
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
                      characterListKey.currentState?.refresh(
                          'https://rickandmortyapi.com/api/character/');
                      locationListKey.currentState?.refresh(
                          'https://rickandmortyapi.com/api/location/');
                      episodeListKey.currentState
                          ?.refresh('https://rickandmortyapi.com/api/episode/');
                    });
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    // size: 45,
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
                          print(_tabController.index);
                          if (_tabController.index == 0) {
                            print('character');
                            charUrl =
                                'https://rickandmortyapi.com/api/character/?$query';
                            // CharacterList(url: charUrl);
                            characterListKey.currentState?.refresh(charUrl);
                          } else if (_tabController.index == 1) {
                            print('location');
                            print(query);
                            locUrl =
                                'https://rickandmortyapi.com/api/location/?$query';
                            // LocationList(url: locUrl);
                            locationListKey.currentState?.refresh(locUrl);
                          } else {
                            print('episode');
                            episodeListKey.currentState?.refresh(
                                'https://rickandmortyapi.com/api/episode?$query');
                          }
                          // _tabController.notifyListeners();
                          // characterListKey.currentState?.refresh(charUrl);
                        });

                        // CharacterList(
                        //     url:
                        //         'https://rickandmortyapi.com/api/character/?$query');
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
        backgroundColor: const Color.fromARGB(255, 248, 224, 138),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            CharacterList(key: characterListKey, url: charUrl),
            LocationList(
              key: locationListKey,
              url: locUrl,
            ),
            EpisodeList(
              key: episodeListKey,
            ),
          ],
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
