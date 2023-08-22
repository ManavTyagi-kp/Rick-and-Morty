import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rickandmorty/utility/models.dart' as models;

import 'CharacterCard.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({
    Key? key,
  }) : super(key: key);

  @override
  State<CharacterList> createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  late String url;
  late final PagingController<String, dynamic> _pagingController;

  @override
  void initState() {
    _pagingController = PagingController(
        firstPageKey: 'https://rickandmortyapi.com/api/character/?page=1');
    _pagingController.addPageRequestListener((url) {
      _fetchPage(url);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(String url) async {
    print(url);
    try {
      final response = await get(Uri.parse(url));
      models.Page responseList = models.Page.fromJson(response.body);
      List postList = responseList.results;
      final isLastPage = responseList.info!.next!.isNull;
      if (isLastPage) {
        _pagingController.appendLastPage(postList);
      } else {
        _pagingController.appendPage(postList, responseList.info!.next);
      }
    } catch (e) {
      print("error --> $e");
      _pagingController.error = e;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('built');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty App'),
      ),
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: PagedListView<String, dynamic>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: ((context, item, index) {
              return CharacterCard(data: models.Character.fromMap(item));
            }),
          ),
        ),
      ),
    );
  }
}
