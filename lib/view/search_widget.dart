import 'package:flutter/material.dart';

import '../controller/home_page_controller.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
    required HomePageController homePageController,
  }) : _homePageController = homePageController, super(key: key);

  final HomePageController _homePageController;

  @override
  Widget build(BuildContext context) {
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
}