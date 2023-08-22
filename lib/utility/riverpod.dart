// import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rickandmorty/utility/models.dart';
import 'package:http/http.dart' as http;

// final fetchCharacter = FutureProvider.family(
//   (ref, String url) {
//     // const url = 'https://rickandmortyapi.com/api/character/?page=1';
//     return http.get(Uri.parse(url)).then(
//       (value) {
//         // print(Page.fromJson(value.body));
//         return model.Page.fromJson(value.body);
//       },
//     );
//   },
// );

final characterProvider = FutureProvider.family((ref, String url) {
  // var url = 'https://rickandmortyapi.com/api/character/{$id}';
  return http.get(Uri.parse(url)).then(
    (value) {
      print('fetching char: $url');
      // print(Character.fromJson(value.body));
      return Character.fromJson(value.body);
    },
  );
});
