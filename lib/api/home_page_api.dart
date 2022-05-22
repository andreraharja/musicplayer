import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:musicplayer/model/home_page_model.dart';

class HomePageApi {
  /// init list data music when first time app launch
  Future<List<DataMusic>> initDataMusic() async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://itunes.apple.com/search?term=a&media=music&limit=50'));
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
        List<DataMusic> dataResult = [];
        jsonData['results']
            .map((i) => dataResult.add(DataMusic.fromJson(i)))
            .toList();
        return dataResult;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  /// api for search data music
  Future<List<DataMusic>> getDataMusic(String termSearch) async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://itunes.apple.com/search?term=' +
              termSearch +
              '&media=music&limit=50'));
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
        List<DataMusic> dataResult = [];
        jsonData['results']
            .map((i) => dataResult.add(DataMusic.fromJson(i)))
            .toList();
        return dataResult;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
