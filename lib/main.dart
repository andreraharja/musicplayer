import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musicplayer/view/music_player.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          primaryColor: Colors.blue,
          appBarTheme: const AppBarTheme(color: Colors.blue)),
      debugShowCheckedModeBanner: false,
      title: 'Music Player',
      home: MusicPlayer(),
    );
  }
}
