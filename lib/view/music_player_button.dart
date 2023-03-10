import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/music_player_controller.dart';

class MusicPlayerButton extends StatelessWidget {
  const MusicPlayerButton({
    Key? key,
    required MusicPlayerController musicPlayerController,
  }) : _musicPlayerController = musicPlayerController, super(key: key);

  final MusicPlayerController _musicPlayerController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.2,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Obx(() => Text(_musicPlayerController.selectedMusic.value.artistName! +
              ' - ' +
              _musicPlayerController.selectedMusic.value.trackName!)),
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.75,
                child: Obx(() => Slider(
                    activeColor: Colors.blue,
                    min: 0.0,
                    max: _musicPlayerController.currentPosition.value.toDouble(),
                    value: _musicPlayerController.currentPosition.value.toDouble(),
                    onChanged: (value) {
                      _musicPlayerController.seekMusic(value);
                    })),
              ),
              Expanded(
                  child: Text(_musicPlayerController.currentPositionLabel.value +
                      ' / ' +
                      _musicPlayerController.currentPositionLabel.value))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(() => _musicPlayerController.isPause.value
                  ? IconButton(
                  icon: const Icon(Icons.play_arrow),
                  onPressed: () {
                    _musicPlayerController.resumeMusic();
                  })
                  : IconButton(
                  icon: const Icon(Icons.pause),
                  onPressed: () {
                    _musicPlayerController.pauseMusic();
                  })),
              IconButton(
                  icon: const Icon(Icons.stop),
                  onPressed: () {
                    _musicPlayerController.stopMusic();
                  }),
            ],
          ),
        ],
      ),
    );
  }
}