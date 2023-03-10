import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/music_player_controller.dart';
import 'package:musicplayer/view/music_player_search.dart';

import 'music_player_button.dart';
import 'music_player_list.dart';

class MusicPlayer extends StatelessWidget {
  MusicPlayer({Key? key}) : super(key: key);
  final MusicPlayerController _musicPlayerController =
      Get.put(MusicPlayerController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Music Player')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              MusicPlayerSearch(musicPlayerController: _musicPlayerController),
              const SizedBox(
                height: 15,
              ),
              MusicPlayerList(musicPlayerController: _musicPlayerController),
              Obx(() => _musicPlayerController.isTap.value
                  ? MusicPlayerButton(
                      musicPlayerController: _musicPlayerController)
                  : Container()),
            ],
          ),
        ),
      ),
    );
  }
}
