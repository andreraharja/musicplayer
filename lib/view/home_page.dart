import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:musicplayer/controller/home_page_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final HomePageController _homePageController = Get.put(HomePageController());

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
              searchWidget(),
              const SizedBox(
                height: 15,
              ),
              listViewDataMusic(),
              Obx(() => _homePageController.isTap.value
                  ? controlWidget()
                  : Container()),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchWidget() {
    return TextField(
        onChanged: (value) {
          _homePageController.filterSearchResult(value);
        },
        controller: _homePageController.searchText,
        decoration: const InputDecoration(
            labelText: "Search",
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)))));
  }

  Widget listViewDataMusic() {
    return Obx(() => _homePageController.isLoading.value
        ? const Center(child: CircularProgressIndicator())
        : Expanded(
            child: ListView.separated(
                itemCount: _homePageController.resultDataMusic.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _homePageController.playMusic(
                          index, _homePageController.resultDataMusic[index]);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          height: Get.height * 0.1,
                          width: Get.height * 0.1,
                          child: Image.network(
                              _homePageController
                                  .resultDataMusic[index].artworkUrl100!,
                              fit: BoxFit.fill),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => Row(
                                    children: [
                                      _homePageController.isPlay[index]
                                          ? const Icon(
                                              Icons.audiotrack_outlined,
                                              color: Colors.blue,
                                            )
                                          : const Icon(
                                              Icons.audiotrack_outlined),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          _homePageController
                                              .resultDataMusic[index]
                                              .trackName!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                    ],
                                  )),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                  _homePageController
                                      .resultDataMusic[index].artistName!,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                  'Album : ' +
                                      _homePageController.resultDataMusic[index]
                                          .collectionName!,
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                        ),
                        Obx(() => _homePageController.isPlay[index]
                            ? SizedBox(
                                width: Get.width * 0.15,
                                child: Lottie.asset('assets/16581-audio.json',
                                    fit: BoxFit.fill))
                            : Container())
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

  Widget controlWidget() {
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
                    max: _homePageController.maxDuration.value.toDouble(),
                    value: _homePageController.currentPosition.value.toDouble(),
                    onChanged: (value) {
                      _homePageController.seekMusic(value);
                    })),
              ),
              Expanded(
                  child: Text(_homePageController.currentPositionLabel.value +
                      ' / ' +
                      _homePageController.maxDurationLabel.value))
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
