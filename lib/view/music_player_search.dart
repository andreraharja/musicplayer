import 'package:flutter/material.dart';
import 'package:musicplayer/controller/music_player_controller.dart';

class MusicPlayerSearch extends StatelessWidget {
  const MusicPlayerSearch({
    Key? key,
    required MusicPlayerController musicPlayerController,
  })  : _musicPlayerController = musicPlayerController,
        super(key: key);

  final MusicPlayerController _musicPlayerController;

  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: (value) {
          _musicPlayerController.filterSearchResult(value);
        },
        controller: _musicPlayerController.searchText,
        decoration: const InputDecoration(
            labelText: "Search",
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)))));
  }
}
