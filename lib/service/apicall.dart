import 'package:dio/dio.dart';
import 'package:rickandmorty/utility/models.dart';

// String baseUrl = 'https://rickandmortyapi.com/api/';
// String locUrl = 'https://rickandmortyapi.com/api/location/?';
// String epiUrl = 'https://rickandmortyapi.com/api/episode/?';

class DioClient {
  final dio = Dio();
  final _baseUrl = 'https://rickandmortyapi.com/api/';

  Future<Page?> getUser({required String type, required String query}) async {
    Page? page;
    try {
      print('url: ${_baseUrl + type + '/?' + query}');
      return dio.get(_baseUrl + type + '/?' + query).then((value) {
        return Page.fromMap(value.data);
      });
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }
    return page;
  }
}
