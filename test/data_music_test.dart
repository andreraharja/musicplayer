import 'package:flutter_test/flutter_test.dart';
import 'package:musicplayer/data/test_model.dart';

void main() {
  group("Data Music Test", () {
    TestDataMusic dataMusic = TestDataMusic();

    test("Data Music has an artist id with type int", () {
      expect(dataMusic.artistId, isA<int>());
    });

    test("Data Music has an artist name with type String", () {
      expect(dataMusic.artistName, isA<String>());
    });

    test('Default artist name "No Name" and artist id 0', () {
      expect(dataMusic.artistId, 0);
      expect(dataMusic.artistName, "No Name");
    });
  });

  group("Data Music Test", () {
    TestDataMusic dataMusic1 = TestDataMusic(artistId: 1);
    TestDataMusic dataMusic2 = TestDataMusic(artistName: "BIGBANG");
    TestDataMusic dataMusic3 = TestDataMusic(artistId: 1, artistName: "BIGBANG");

    test("Data Music single parameter id", () {
      expect(dataMusic1.artistId, equals(1));
      expect(dataMusic1.artistName, equals('No Name'));
    });

    test("Data Music single parameter name", () {
      expect(dataMusic2.artistId, equals(0));
      expect(dataMusic2.artistName, equals('BIGBANG'));
    });

    test("Data Music single parameter id & name", () {
      expect(dataMusic3.artistId, equals(1));
      expect(dataMusic3.artistName, equals('BIGBANG'));
    });
  });
}
