import 'package:flutter/material.dart';
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
  final TextEditingController _searchController = TextEditingController();
  bool _search = false;
  late TabController _tabController;
  String query = '';

  @override
  void initState() {
    super.initState();
    // _filteredData = _data;
    _tabController = TabController(length: 3, vsync: this);
    // _searchController.addListener(_performSearch);
  }

  Future<void> _performSearch(String url) async {
    setState(() {
      _search = true;
    });
    try {
      final response = await get(Uri.parse(url));
      models.Page responseList = models.Page.fromJson(response.body);
      List postList = responseList.results;
      final isLastPage = responseList.info!.next == null;
    } catch (e) {
      print("error --> $e");
    }
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    print(_tabController.index);
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
                        border: InputBorder.none),
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
        children: const <Widget>[
          CharacterList(),
          LocationList(),
          EpisodeList(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
