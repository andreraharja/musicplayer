import 'package:equatable/equatable.dart';

class DataMusic extends Equatable{
  int artistId = 0;
  String artistName = "No Name";

  DataMusic({
    this.artistId = 0,
    this.artistName = "No Name",
  });

  DataMusic.fromJson(Map<String, dynamic> json) {
    artistId = json['artistId'];
    artistName = json['artistName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['artistId'] = artistId;

    data['artistName'] = artistName;

    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [artistId, artistName];
}
