part of 'character.dart';

class CharacterLocation {
  CharacterLocation({required this.name, required this.url});

  String name;
  String url;

  factory CharacterLocation.fromJson(Map<String, dynamic> json) =>
      CharacterLocation(name: json["name"], url: json["url"]);

  Map<String, dynamic> toJson() => {"name": name, "url": url};
}
