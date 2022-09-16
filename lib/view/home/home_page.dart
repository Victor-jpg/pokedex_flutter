import 'package:compart/app/entities/favorite.dart';
import 'package:compart/app/entities/like.dart';
import 'package:compart/models/pokemon.dart';
import 'package:compart/controller/home/home_controllerg.dart';
import 'package:compart/view/home/pokemon_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeControllerG homeController = Get.find();
  final PagingController<int, PokemonModel> _pagingController =
      PagingController(firstPageKey: 0);

  Widget _pokemonWidget(BuildContext context, PokemonModel pokemon,
      List<Favorite> favorites, List<Like> likes) {
    return Stack(
      children: [
        InkWell(
          onTap: () => Get.to(() => PokemonDetailsPage(
                pokemonId: pokemon.id,
              )),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.network(
                    pokemon.imageUrl,
                    fit: BoxFit.cover,
                    height: 130,
                    width: 130,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 25,
                  decoration: const BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Center(
                    child: Text(
                      pokemon.name!.capitalize!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () => homeController.likePokemon(pokemon.id!),
                      child: const Icon(Icons.thumb_up_alt,
                          color: Colors.blue, size: 30)),
                  const SizedBox(
                    width: 5,
                  ),
                  likes.map((like) => like.pokemonId).contains(pokemon.id)
                      ? Text(
                          '${likes.where((element) => element.pokemonId == pokemon.id).length}',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                        )
                      : Text(
                          '0',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                        )
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => homeController.favoritePokemon(pokemon.id!),
              child: Icon(Icons.favorite,
                  color: favorites
                          .map((favorite) => favorite.pokemonId)
                          .contains(pokemon.id)
                      ? Colors.red
                      : Colors.grey,
                  size: 30),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      homeController.fetchPage(_pagingController, pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Pokedex",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        body: Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.all(10),
          child: Obx(() {
            List<PokemonModel> _pokemons = homeController.pokemons.value;

            List<Favorite> _favoritePokemos =
                homeController.favoritePokemons.value;

            List<Like> _likePokemons = homeController.likesPokemons.value;

            if (_pokemons.isEmpty) {
              return const Center(child: Text('Não há pokemons'));
            }

            return PagedGridView(
                pagingController: _pagingController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                builderDelegate: PagedChildBuilderDelegate<PokemonModel>(
                    firstPageProgressIndicatorBuilder: (_) => Center(
                          child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor),
                        ),
                    newPageProgressIndicatorBuilder: (_) => Center(
                          child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor),
                        ),
                    itemBuilder: (context, item, index) => _pokemonWidget(
                        context, item, _favoritePokemos, _likePokemons)));
          }),
        ));
  }
}
