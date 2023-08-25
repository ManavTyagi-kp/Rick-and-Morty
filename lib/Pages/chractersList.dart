import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rickandmorty/utility/models.dart' as models;

import 'CharacterCard.dart';

class CharacterList extends StatefulWidget {
  String url;
  CharacterList({
    required this.url,
    Key? key,
  }) : super(key: key);

  @override
  State<CharacterList> createState() => CharacterListState();
}

class CharacterListState extends State<CharacterList>
    with AutomaticKeepAliveClientMixin {
  // late String url;
  late final PagingController<String, dynamic> _pagingController;
  // final TextEditingController _searchController = TextEditingController();
  // bool _search = true;
  // String _query = '';

  @override
  void initState() {
    _pagingController = PagingController(firstPageKey: widget.url);
    _pagingController.addPageRequestListener((url) {
      _fetchPage(url);
    });
    super.initState();
  }

  void refresh(String url) {
    setState(() {
      widget.url = url;
      _fetchPage(url);
    });
    _pagingController.refresh();
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
      final isLastPage = responseList.info!.next == null;
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
    super.build(context);
    print('built');
    return Scaffold(
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

  @override
  bool get wantKeepAlive => false;
}
