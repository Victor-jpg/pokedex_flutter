import 'package:compart/models/pokemon.dart';
import 'package:compart/models/pokemon_details.dart';
import 'package:dio/dio.dart';

class PokemonResponse<T1> {
  bool? success;
  String? message;
  T1? data;

  PokemonResponse({this.data, this.message, this.success});
}

class PokemonAPI {
  var dio = Dio();

  Future<PokemonResponse> getPokemonDetails(int id) async {
    var url = "https://pokeapi.co/api/v2/pokemon/$id";

    try {
      Response response = await dio.get(url);

      PokemonDetailsModel pokemon = PokemonDetailsModel.fromJson(response.data);

      return PokemonResponse(
          success: true,
          message: "Pokemon buscado com sucesso!",
          data: pokemon);
    } catch (e) {
      return PokemonResponse(
          success: false,
          message: "Não foi possivel buscar o pokemon informado.");
    }
  }

  Future<PokemonResponse> getPokemons(int pageIndex) async {
    var url = "https://pokeapi.co/api/v2/pokemon";

    try {
      Response response = await dio.get(url, queryParameters: {
        "limit": "20",
        "offset": (pageIndex * 20).toString()
      });

      List<PokemonModel> _pokemons = response.data["results"]
          .map<PokemonModel>((pokemon) => PokemonModel.fromJson(pokemon))
          .toList();

      return PokemonResponse(
          success: true,
          message: "Pokemons buscados com sucesso!",
          data: _pokemons);
    } catch (e) {
      return PokemonResponse(
          success: false, message: "Não foi possivel buscar os pokemons.");
    }
  }
}
