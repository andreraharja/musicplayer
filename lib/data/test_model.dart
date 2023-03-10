import 'package:equatable/equatable.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class ItunesMusicPlayer {
  Future<List<TestDataMusic>> testDataMusic(String? type, String? termSearch, http.Client client);
}

// ignore: must_be_immutable
class TestDataMusic extends Equatable implements ItunesMusicPlayer{
  int artistId = 0;
  String artistName = "No Name";

  TestDataMusic({
    this.artistId = 0,
    this.artistName = "No Name",
  });

  TestDataMusic.fromJson(Map<String, dynamic> json) {
    artistId = json['artistId'];
    artistName = json['artistName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['artistId'] = artistId;

    data['artistName'] = artistName;

    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [artistId, artistName];

  @override
  Future<List<TestDataMusic>> testDataMusic(String? type, String? termSearch, http.Client client) async {
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
        List<TestDataMusic> dataResult = [];
        jsonData['results']
            .map((i) => dataResult.add(TestDataMusic.fromJson(i)))
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
