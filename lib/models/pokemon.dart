class PokemonModel {
  String? name;
  String? url;
  int? id;

  String get imageUrl =>
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/$id.png";

  PokemonModel({this.url, this.name});

  PokemonModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    url = json["url"];
    id = int.parse(url!.split("/")[6]);
  }
}
