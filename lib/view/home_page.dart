import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/home_page_controller.dart';
import 'package:musicplayer/view/search_widget.dart';

import 'control_widget.dart';
import 'list_view_widget.dart';

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
              SearchWidget(homePageController: _homePageController),
              const SizedBox(
                height: 15,
              ),
              ListViewDataMusic(homePageController: _homePageController),
              Obx(() => _homePageController.isTap.value
                  ? ControlWidget(homePageController: _homePageController)
                  : Container()),
            ],
          ),
        ),
      ),
    );
  }
}
