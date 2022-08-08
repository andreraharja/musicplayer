import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/api/home_page_api.dart';
import 'package:musicplayer/model/home_page_model.dart';

class HomePageController extends GetxController {
  TextEditingController searchText = TextEditingController();
  var dataMusic = List<DataMusic>.empty().obs;
  var resultDataMusic = List<DataMusic>.empty().obs;
  var selectedMusic = DataMusic().obs;
  var isPlay = List<bool>.empty().obs;
  var isLoading = true.obs;
  var isTap = false.obs;
  var isPause = false.obs;
  var tempIndex = 0;
  var currentPosition = 0.obs;
  var currentPositionLabel = "00:00".obs;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void onInit() async {
    dataMusic.value = await HomePageApi().getDataMusic('Init', null);
    resultDataMusic.addAll(dataMusic);
    isPlay.value = List.generate(resultDataMusic.length, (i) => false);
    isLoading(false);
    super.onInit();
  }

  void filterSearchResult(String txtSearch) async {
    isLoading(true);
    if (txtSearch.isNotEmpty) {
      List<DataMusic> dataSearchList = [];
      dataSearchList = await HomePageApi().getDataMusic(null, txtSearch);
      resultDataMusic.clear();
      resultDataMusic.addAll(dataSearchList);
    } else {
      resultDataMusic.clear();
      resultDataMusic.addAll(dataMusic);
    }
    isPlay.clear();
    isPlay.value = List.generate(resultDataMusic.length, (i) => false);
    isLoading(false);
  }

  void playMusic(int index, DataMusic dataMusic) async {
    int result = await audioPlayer.play(dataMusic.previewUrl!);
    if (result == 1) {
      isPlay[tempIndex] = false;
      isPlay[index] = true;
      isTap.value = true;
      isPause(false);
      tempIndex = index;
      selectedMusic.value = dataMusic;

      getPositionDuration();
      getAudioComplete(index);
    }
  }

  void getPositionDuration() {
    audioPlayer.onDurationChanged.listen((Duration d) {
      currentPosition.value = d.inMilliseconds;

      int shours = Duration(milliseconds: currentPosition.value).inHours;
      int sminutes = Duration(milliseconds: currentPosition.value).inMinutes;
      int sseconds = Duration(milliseconds: currentPosition.value).inSeconds;

      int rhours = shours;
      int rminutes = sminutes - (shours * 60);
      int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

      if (rhours == 0) {
        currentPositionLabel.value = "$rminutes:$rseconds";
      } else {
        currentPositionLabel.value = "$rhours:$rminutes:$rseconds";
      }
    });
  }

  void getAudioComplete(index) {
    audioPlayer.onPlayerCompletion.listen((event) {
      isPause(true);
      isPlay[index] = false;
    });
  }

  void seekMusic(value) async {
    int seekval = value.round();
    int result = await audioPlayer.seek(Duration(milliseconds: seekval));
    if (result == 1) {
      currentPosition.value = seekval;
    }
  }

  void pauseMusic() async {
    int result = await audioPlayer.pause();
    if (result == 1) {
      isPause(true);
    }
  }

  void resumeMusic() async {
    int result = await audioPlayer.resume();
    if (result == 1) {
      isPause(false);
    }
  }

  void stopMusic() async {
    int result = await audioPlayer.stop();
    if (result == 1) {
      isTap(false);
      isPlay[isPlay.indexWhere((element) => element == true)] = false;
    }
  }
}
