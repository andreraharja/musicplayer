import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controller/home_page_controller.dart';

class ListViewDataMusic extends StatelessWidget {
  const ListViewDataMusic({
    Key? key,
    required HomePageController homePageController,
  }) : _homePageController = homePageController, super(key: key);

  final HomePageController _homePageController;

  @override
  Widget build(BuildContext context) {
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
}