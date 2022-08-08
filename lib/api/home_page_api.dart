import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:musicplayer/model/home_page_model.dart';

class HomePageApi {
  Future<List<DataMusic>> getDataMusic(String? type, String? termSearch) async {
    try {
      String urlMusic = "";
      if (type == 'Init') {
        urlMusic =
            'https://itunes.apple.com/search?term=a&media=music&limit=50';
      } else {
        urlMusic = 'https://itunes.apple.com/search?term=' +
            termSearch! +
            '&media=music&limit=50';
      }

      http.Response response = await http.get(Uri.parse(urlMusic));
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
