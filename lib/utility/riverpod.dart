// import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmorty/service/apicall.dart';
import 'package:rickandmorty/utility/models.dart' as model;
import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'fetchloc.g.dart';

final fetchCharacter = FutureProvider.family(
  (ref, String url) async {
    print(url);
    return await DioClient().getUser(type: 'character', query: url);
  },
);

// Location Riverpod

final fetchLoc = AsyncNotifierProvider<FetchLoc, void>(() {
  return FetchLoc();
});

@riverpod
class FetchLoc extends AsyncNotifier<void> {
  model.Page? page;
  int pageIndex = 1;
  String query = '';
  @override
  Future<void> build() async {
    page = await DioClient().getUser(type: 'location', query: 'page=1&');
    pageIndex++;
    if (page != null) {
      ref.read(locListProvider.notifier).appendPage(page!.results);
    }
  }

  Future<AsyncValue> nextPage() async {
    int? pages = page!.info!.pages;
    if (page!.info!.next != null && pageIndex <= pages!) {
      page = await DioClient()
          .getUser(type: 'location', query: 'page=$pageIndex&$query');
      state = const AsyncValue.loading();
      pageIndex++;
      state = await AsyncValue.guard(() => Future.error('error'));

      if (page != null) {
        state = AsyncValue.data(page!.results);
        ref.read(locListProvider.notifier).appendPage(page!.results);
      }
    }
    return state;
  }

  Future<void> startQuery(String locquery) async {
    query = locquery;
    pageIndex = 2;
    try {
      page =
          await DioClient().getUser(type: 'location', query: 'page=1&$query');
    } catch (e) {
      print(e);
    }
    if (page != null) {
      ref.read(locListProvider.notifier).deleteList();
      ref.read(locListProvider.notifier).appendPage(page!.results);
    }
  }
}

final locListProvider = StateNotifierProvider<LocationNotifier, List>((ref) {
  return LocationNotifier();
});

final class LocationNotifier extends StateNotifier<List> {
  LocationNotifier() : super([]);

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

// Character Riverpod

final fetchChar = AsyncNotifierProvider<FetchChar, void>(() {
  return FetchChar();
});

@riverpod
class FetchChar extends AsyncNotifier<void> {
  var page;
  int pageIndex = 1;
  String query = '';
  @override
  Future<void> build() async {
    page = await DioClient().getUser(type: 'character', query: 'page=1&');
    pageIndex++;
    if (page != null) {
      ref.read(listProvider.notifier).appendPage(page!.results);
    }
  }

  Future<AsyncValue> nextPage() async {
    int? pages = page!.info!.pages;
    if (page!.info!.next != null && pageIndex <= pages!) {
      page = await DioClient()
          .getUser(type: 'character', query: 'page=$pageIndex&$query');
      state = const AsyncValue.loading();
      pageIndex++;
      state = await AsyncValue.guard(() => Future.error('error'));

      if (page != null) {
        state = AsyncValue.data(page!.results);
        ref.read(listProvider.notifier).appendPage(page!.results);
      }
    }
    return state;
  }

  Future<void> startQuery(String locquery) async {
    query = locquery;
    pageIndex = 2;
    try {
      page =
          await DioClient().getUser(type: 'character', query: 'page=1&$query');
    } catch (e) {
      print(e);
    }
    if (page != null) {
      ref.read(listProvider.notifier).deleteList();
      ref.read(listProvider.notifier).appendPage(page!.results);
    }
  }
}

final listProvider = StateNotifierProvider<CharacterNotifier, List>((ref) {
  return CharacterNotifier();
});

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

// Episode Riverpod

final fetchEpisode = AsyncNotifierProvider<FetchEpisode, void>(() {
  return FetchEpisode();
});

@riverpod
class FetchEpisode extends AsyncNotifier<void> {
  var page;
  int pageIndex = 1;
  String query = '';
  @override
  Future<void> build() async {
    page = await DioClient().getUser(type: 'episode', query: 'page=1&');
    pageIndex++;
    if (page != null) {
      ref.read(episodeListProvider.notifier).appendPage(page!.results);
    }
  }

  Future<AsyncValue> nextPage() async {
    int? pages = page!.info!.pages;
    if (page!.info!.next != null && pageIndex <= pages!) {
      page = await DioClient()
          .getUser(type: 'episode', query: 'page=$pageIndex&$query');
      state = const AsyncValue.loading();
      pageIndex++;
      state = await AsyncValue.guard(() => Future.error('error'));

      if (page != null) {
        state = AsyncValue.data(page!.results);
        ref.read(episodeListProvider.notifier).appendPage(page!.results);
      }
    }
    return state;
  }

  Future<void> startQuery(String locquery) async {
    query = locquery;
    pageIndex = 2;
    try {
      page = await DioClient().getUser(type: 'episode', query: 'page=1&$query');
    } catch (e) {
      print(e);
    }
    if (page != null) {
      ref.read(episodeListProvider.notifier).deleteList();
      ref.read(episodeListProvider.notifier).appendPage(page!.results);
    }
  }
}

final episodeListProvider = StateNotifierProvider<EpisodeNotifier, List>((ref) {
  return EpisodeNotifier();
});

final class EpisodeNotifier extends StateNotifier<List> {
  EpisodeNotifier() : super([]);

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

final characterProvider = FutureProvider.family((ref, String url) {
  // var url = 'https://rickandmortyapi.com/api/character/{$id}';
  return http.get(Uri.parse(url)).then(
    (value) {
      // print('fetching char: $url');
      // print(Character.fromJson(value.body));
      return model.Character.fromJson(value.body);
    },
  );
});
