import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rickandmorty/utility/models.dart' as model;
import 'locationCard.dart';

class EpisodeList extends StatefulWidget {
  const EpisodeList({
    Key? key,
  }) : super(key: key);

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  late final PagingController<String, dynamic> _pagingController;

  @override
  void initState() {
    _pagingController = PagingController(
        firstPageKey: 'https://rickandmortyapi.com/api/episode');
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
      model.Page responseList = model.Page.fromJson(response.body);
      List postList = responseList.results;
      final isLastPage = responseList.info!.next.isNull;
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
      backgroundColor: Colors.black54,
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: PagedListView<String, dynamic>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: ((context, item, index) {
              return ListCard(type: 'episode', item: item);
            }),
          ),
        ),
      ),
    );
  }
}
