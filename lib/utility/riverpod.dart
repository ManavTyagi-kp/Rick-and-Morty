import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmorty/service/apicall.dart';
import 'package:rickandmorty/utility/models.dart' as model;
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// Notifiers
@riverpod
class Fetch extends AsyncNotifier<void> {
  final String type;
  Fetch({required this.type});
  model.Page? page;
  int pageIndex = 1;
  String query = '';
  var provider;
  @override
  Future<void> build() async {
    page = await DioClient().getUser(type: type, query: 'page=1&');
    provider = type == 'character'
        ? ref.read(listProvider.notifier)
        : type == 'location'
            ? ref.read(locListProvider.notifier)
            : ref.read(episodeListProvider.notifier);
    pageIndex++;
    if (page != null) {
      provider.appendPage(page!.results);
    }
  }

  Future<AsyncValue> nextPage() async {
    int? pages = page!.info!.pages;
    if (page!.info!.next != null && pageIndex <= pages!) {
      try {
        page = await DioClient()
            .getUser(type: type, query: 'page=$pageIndex&$query');
      } catch (e) {
        print(e);
      }

      state = const AsyncValue.loading();
      pageIndex++;
      state = await AsyncValue.guard(() => Future.error('error'));

      if (page != null) {
        state = AsyncValue.data(page!.results);
        provider.appendPage(page!.results);
      }
    }
    return state;
  }

  Future<void> startQuery(String locquery) async {
    query = locquery;
    pageIndex = 2;
    try {
      page = await DioClient().getUser(type: type, query: 'page=1&$query');
    } catch (e) {
      print(e);
    }
    if (page != null) {
      provider.deleteList();
      provider.appendPage(page!.results);
    }
  }
}

final class CharacterNotifier extends StateNotifier<List> {
  CharacterNotifier() : super([]);

  void appendPage(List newList) {
    state = [...state];
    newList.forEach((element) {
      state.add(element);
    });
    // print(state);
  }

  void deleteList() {
    state = [...state];
    state.removeRange(0, state.length);
  }
}

///

// Location Riverpod (Notifier Provider)

final fetchLoc = AsyncNotifierProvider<Fetch, void>(() {
  return Fetch(type: 'location');
});

final locListProvider = StateNotifierProvider<CharacterNotifier, List>((ref) {
  return CharacterNotifier();
});

// Character Riverpod (Notifier Provider)

final fetchChar = AsyncNotifierProvider<Fetch, void>(() {
  return Fetch(type: 'character');
});

final listProvider = StateNotifierProvider<CharacterNotifier, List>((ref) {
  return CharacterNotifier();
});

// Episode Riverpod (Notifier Provider)

final fetchEpisode = AsyncNotifierProvider<Fetch, void>(() {
  return Fetch(type: 'episode');
});

final episodeListProvider =
    StateNotifierProvider<CharacterNotifier, List>((ref) {
  return CharacterNotifier();
});

final characterProvider = FutureProvider.family((ref, String url) {
  return http.get(Uri.parse(url)).then(
    (value) {
      return model.Character.fromJson(value.body);
    },
  );
});
