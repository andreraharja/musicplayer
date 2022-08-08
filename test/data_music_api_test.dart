import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:musicplayer/api/data_music_api.dart';
import 'package:musicplayer/model/data_music_model.dart';
import 'data_music_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  http.Client client = MockClient();

  test("Init Data Music Test", () async {
    when(client.get(Uri.parse(
            "https://itunes.apple.com/search?term=a&media=music&country=id&limit=1")))
        .thenAnswer((_) async {
      return Future.value(http.Response('''{
      "resultCount": 1,
      "results": [
          {
          "artistId": 318754656,
          "artistName": "BIGBANG",
          "collectionName": "A - Single",
          "trackName": "BANG BANG BANG",
          "collectionCensoredName": "A - Single",
          "trackCensoredName": "BANG BANG BANG",
          "artistViewUrl": "https://music.apple.com/id/artist/bigbang/318754656?uo=4",
          "collectionViewUrl": "https://music.apple.com/id/album/bang-bang-bang/1314236918?i=1314237014&uo=4",
          "trackViewUrl": "https://music.apple.com/id/album/bang-bang-bang/1314236918?i=1314237014&uo=4",
          "previewUrl": "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/df/19/72/df1972eb-1fe9-72a3-f86c-251e8e622291/mzaf_6303264544088989414.plus.aac.p.m4a",
          "artworkUrl30": "https://is2-ssl.mzstatic.com/image/thumb/Music115/v4/d1/10/bf/d110bf3e-ed84-016f-578c-a203c908be4c/A_digital_single_cover.jpg/30x30bb.jpg",
          "artworkUrl60": "https://is2-ssl.mzstatic.com/image/thumb/Music115/v4/d1/10/bf/d110bf3e-ed84-016f-578c-a203c908be4c/A_digital_single_cover.jpg/60x60bb.jpg",
          "artworkUrl100": "https://is2-ssl.mzstatic.com/image/thumb/Music115/v4/d1/10/bf/d110bf3e-ed84-016f-578c-a203c908be4c/A_digital_single_cover.jpg/100x100bb.jpg",
          "collectionPrice": 9000.00,
          "trackPrice": 7000.00,
          "releaseDate": "2015-06-01T12:00:00Z",
          "collectionExplicitness": "notExplicit",
          "trackExplicitness": "notExplicit",
          "discCount": 1,
          "discNumber": 1,
          "trackCount": 2,
          "trackNumber": 1,
          "trackTimeMillis": 220178,
          "country": "IDN",
          "currency": "IDR",
          "primaryGenreName": "Hip-Hop/Rap",
          "isStreamable": true
          }
          ]
      }''', 200));
    });
    List<DataMusic> dataMusic = await HomePageApi().getDataMusicTest("Init", null, client);
    expect(dataMusic[0], equals(DataMusic(artistId: 318754656, artistName: "BIGBANG")));
  });
}
