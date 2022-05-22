import 'package:flutter_test/flutter_test.dart';
import 'package:musicplayer/api/home_page_api.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:musicplayer/model/home_page_model.dart';

@GenerateMocks([HomePageApi], customMocks: [MockSpec<HomePageApi>(returnNullOnMissingStub: true)])
Future<void> main() async {
  var homePageApi = MockHomePageApi();

  test("returns init data music", () async {
    const model = List<DataMusic>;
    when(homePageApi.initDataMusic().then((_) async {
      return model;
    }));
    final res = homePageApi.initDataMusic();
    expect(res, isA<List<DataMusic>>());
    expect(res, model);
  });

  test('return init data music throws Exception', () {
    when(homePageApi.initDataMusic().then((_) async {
      throw Exception();
    }));
    final res = homePageApi.initDataMusic();
    expect(res, throwsException);
  });
}
