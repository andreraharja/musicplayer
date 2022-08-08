import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_page_controller.dart';

class ControlWidget extends StatelessWidget {
  const ControlWidget({
    Key? key,
    required HomePageController homePageController,
  }) : _homePageController = homePageController, super(key: key);

  final HomePageController _homePageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.2,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Obx(() => Text(_homePageController.selectedMusic.value.artistName! +
              ' - ' +
              _homePageController.selectedMusic.value.trackName!)),
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.75,
                child: Obx(() => Slider(
                    activeColor: Colors.blue,
                    min: 0.0,
                    max: _homePageController.currentPosition.value.toDouble(),
                    value: _homePageController.currentPosition.value.toDouble(),
                    onChanged: (value) {
                      _homePageController.seekMusic(value);
                    })),
              ),
              Expanded(
                  child: Text(_homePageController.currentPositionLabel.value +
                      ' / ' +
                      _homePageController.currentPositionLabel.value))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(() => _homePageController.isPause.value
                  ? IconButton(
                  icon: const Icon(Icons.play_arrow),
                  onPressed: () {
                    _homePageController.resumeMusic();
                  })
                  : IconButton(
                  icon: const Icon(Icons.pause),
                  onPressed: () {
                    _homePageController.pauseMusic();
                  })),
              IconButton(
                  icon: const Icon(Icons.stop),
                  onPressed: () {
                    _homePageController.stopMusic();
                  }),
            ],
          ),
        ],
      ),
    );
  }
}