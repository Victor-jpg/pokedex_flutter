class Stat {
  int? baseStat;
  String? name;

  Stat({this.baseStat, this.name});

  Stat.fromJson(Map<String, dynamic> json) {
    baseStat = json["base_stat"];
    name = json["stat"]["name"];
  }
}

class Type {
  String? name;

  Type({this.name});

  Type.fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }
}

class Move {
  String? name;

  Move({this.name});

  Move.fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }
}

class PokemonDetailsModel {
  int? id;
  String? name;
  int? baseExperience;
  int? height;
  bool? isDefault;
  int? order;
  int? weight;
  String? backDefault;
  String? frontDefault;
  String? homeFrontDefault;
  List<Stat>? stats;
  List<Move>? moves;
  List<Type>? types;

  PokemonDetailsModel(
      {this.baseExperience,
      this.height,
      this.id,
      this.stats,
      this.isDefault,
      this.types,
      this.moves,
      this.frontDefault,
      this.name,
      this.homeFrontDefault,
      this.order,
      this.backDefault,
      this.weight});

  PokemonDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    baseExperience = json["base_experience"];
    isDefault = json["is_default"];
    height = json["height"];
    order = json["order"];
    weight = json["weight"];
    backDefault = json["sprites"]["back_default"];
    frontDefault = json["sprites"]["front_default"];
    homeFrontDefault = json["sprites"]["other"]["home"]["front_default"];
    moves =
        json["moves"].map<Move>((move) => Move.fromJson(move["move"])).toList();
    stats = json["stats"].map<Stat>((stat) => Stat.fromJson(stat)).toList();
    types =
        json["types"].map<Type>((type) => Type.fromJson(type["type"])).toList();
  }
}
