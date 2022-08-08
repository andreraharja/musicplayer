import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:musicplayer/model/data_music_model.dart';

class HomePageApi {
  Future<List<DataMusic>> getDataMusicTest(String? type, String? termSearch, http.Client client) async {
    try {
      String urlMusic = "";
      if (type == 'Init') {
        urlMusic =
            'https://itunes.apple.com/search?term=a&media=music&country=id&limit=1';
      } else {
        urlMusic = 'https://itunes.apple.com/search?term=' +
            termSearch! +
            '&media=music&limit=1';
      }

      http.Response response = await client.get(Uri.parse(urlMusic));
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
        List<DataMusic> dataResult = [];
        jsonData['results']
            .map((i) => dataResult.add(DataMusic.fromJson(i)))
            .toList();
        return dataResult;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      return [];
    }
  }
}
