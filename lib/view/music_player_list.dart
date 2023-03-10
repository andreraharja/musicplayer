import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:musicplayer/controller/music_player_controller.dart';

class MusicPlayerList extends StatelessWidget {
  const MusicPlayerList({
    Key? key,
    required MusicPlayerController musicPlayerController,
  })  : _musicPlayerController = musicPlayerController,
        super(key: key);

  final MusicPlayerController _musicPlayerController;

  @override
  Widget build(BuildContext context) {
    return Obx(() => _musicPlayerController.isLoading.value
        ? const Center(child: CircularProgressIndicator())
        : Expanded(
            child: ListView.separated(
                itemCount: _musicPlayerController.resultDataMusic.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _musicPlayerController.playMusic(
                          index, _musicPlayerController.resultDataMusic[index]);
                    },
                    child: Row(
                      children: [
                        artworkArtist(index),
                        const SizedBox(
                          width: 20,
                        ),
                        detailArtist(index, context),
                        flagPlay(index)
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 2,
                  );
                })));
  }

  Widget artworkArtist(int index) {
    return SizedBox(
      height: Get.height * 0.1,
      width: Get.height * 0.1,
      child: Image.network(
          _musicPlayerController.resultDataMusic[index].artworkUrl100!,
          fit: BoxFit.fill),
    );
  }

  Widget detailArtist(int index, BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Row(
                children: [
                  _musicPlayerController.isPlay[index]
                      ? const Icon(
                          Icons.audiotrack_outlined,
                          color: Colors.blue,
                        )
                      : const Icon(Icons.audiotrack_outlined),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      _musicPlayerController.resultDataMusic[index].trackName!,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 5,
          ),
          Text(_musicPlayerController.resultDataMusic[index].artistName!,
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(
            height: 3,
          ),
          Text(
              'Album : ' +
                  _musicPlayerController.resultDataMusic[index].collectionName!,
              style: Theme.of(context).textTheme.caption),
        ],
      ),
    );
  }

  Widget flagPlay(int index) {
    return Obx(() => _musicPlayerController.isPlay[index]
        ? SizedBox(
            width: Get.width * 0.15,
            child: Lottie.asset('assets/16581-audio.json', fit: BoxFit.fill))
        : Container());
  }
}
