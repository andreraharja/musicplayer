import 'package:flutter_test/flutter_test.dart';
import 'package:musicplayer/api/home_page_api.dart';
import 'package:musicplayer/model/home_page_model.dart';

void main() async {
  test('test init Data Music', () async {
    final client = HomePageApi();
    expect(await client.initDataMusic(), isA<List<DataMusic>>());
  });

  test('test Search Data Music', () async {
    final client = HomePageApi();
    expect(await client.getDataMusic("Owl City"), isA<List<DataMusic>>());
  });
}
