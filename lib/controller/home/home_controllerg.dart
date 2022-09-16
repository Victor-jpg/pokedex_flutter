import 'package:compart/app/entities/favorite.dart';
import 'package:compart/app/entities/like.dart';
import 'package:compart/database/objectbox.g.dart';
import 'package:compart/database/objectbox_database.dart';
import 'package:compart/models/pokemon.dart';
import 'package:compart/models/pokemon_details.dart';
import 'package:compart/repositories/pokemon_api.dart';
import 'package:get/get.dart';

class HomeControllerG extends GetxController {
  final PokemonAPI api;

  final pokemons = <PokemonModel>[].obs;

  final pageIndex = 0.obs;

  final favoritePokemons = <Favorite>[].obs;

  final likesPokemons = <Like>[].obs;

  late final ObjectBoxDatabase _database;

  HomeControllerG(this.api, this._database);

  _initialized() async {
    getPokemons();

    final boxFavorite = await getBoxFavorite();

    favoritePokemons.value = boxFavorite.getAll() as List<Favorite>;

    final boxLike = await getBoxLike();

    likesPokemons.value = boxLike.getAll() as List<Like>;
  }

  @override
  void onInit() {
    _initialized();

    super.onInit();
  }

  Future<void> fetchPage(pagingController, int pageIndex) async {
    try {
      final response = await api.getPokemons(pageIndex);

      final isLastPage = response.data.length < 20;

      if (isLastPage) {
        pagingController.appendLastPage(response.data);
      } else {
        final nextPageKey = pageIndex + response.data.length;
        pagingController.appendPage(response.data, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<void> getPokemons() async {
    PokemonResponse response = await api.getPokemons(pageIndex.value);

    pokemons.value = response.data;
  }

  Future<PokemonDetailsModel> getPokemonDetails(int pokemonId) async {
    PokemonResponse response = await api.getPokemonDetails(pokemonId);

    return response.data;
  }

  Future<void> favoritePokemon(int pokemonId) async {
    final box = await getBoxFavorite();

    final query = box.query(Favorite_.pokemonId.equals(pokemonId)).build();

    Favorite? result = query.findFirst();

    if (result == null) {
      box.put(Favorite(pokemonId: pokemonId), mode: PutMode.insert);
    } else {
      box.remove(result.id);
    }

    await getFavorites();
  }

  Future<void> likePokemon(int pokemonId) async {
    final box = await getBoxLike();

    box.put(Like(pokemonId: pokemonId), mode: PutMode.insert);

    await getLikes();
  }

  Future<void> getFavorites() async {
    final box = await getBoxFavorite();

    favoritePokemons.value = box.getAll() as List<Favorite>;
  }

  Future<void> getLikes() async {
    final box = await getBoxLike();

    likesPokemons.value = box.getAll() as List<Like>;
  }

  Future<Box> getBoxFavorite() async {
    final store = await _database.getStore();

    return store.box<Favorite>();
  }

  Future<Box> getBoxLike() async {
    final store = await _database.getStore();

    return store.box<Like>();
  }
}
