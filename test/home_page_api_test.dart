import 'package:flutter_test/flutter_test.dart';
import 'package:musicplayer/api/home_page_api.dart';
import 'package:musicplayer/model/home_page_model.dart';

void main() {
  final client = HomePageApi();

  test('test init Data Music', () async {
    expect(await client.initDataMusic(), isA<List<DataMusic>>());
  });

  test('test Search Data Music', () async {
    expect(await client.getDataMusic("Owl City"), isA<List<DataMusic>>());
  });
}
