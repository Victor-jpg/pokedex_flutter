import 'package:compart/controller/home/home_controllerg.dart';
import 'package:compart/models/pokemon_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PokemonDetailsPage extends StatefulWidget {
  final int? pokemonId;
  const PokemonDetailsPage({Key? key, this.pokemonId}) : super(key: key);

  @override
  _PokemonDetailsPageState createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  final HomeControllerG homeController = Get.find();
  late PokemonDetailsModel pokemonDetails;
  bool _isLoading = false;

  String handleLabel(String label) {
    switch (label) {
      case "ATTACK":
        return "ATQ";
      case "DEFENSE":
        return "DEF";
      case "SPEED":
        return "VEL";
      case "SPECIAL-ATTACK":
        return "EA";
      case "SPECIAL-DEFENSE":
        return "ED";

      default:
        return label;
    }
  }

  Widget statBar(double value) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          width: 300,
          height: 25,
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: Text(
                "${value.toInt()}/300",
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.red,
          ),
          width: value,
          height: 25,
        ),
      ],
    );
  }

  double gramsToKilo(int hectograms) {
    return (hectograms / 10);
  }

  double decimetersToMeter(int decimeters) {
    return (decimeters / 10);
  }

  _initialized() async {
    setState(() {
      _isLoading = true;
    });

    pokemonDetails = await homeController.getPokemonDetails(widget.pokemonId!);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _initialized();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container(
            color: Theme.of(context).backgroundColor,
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.grey,
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              // title: Text(pokemonDetails.name!.capitalize!),
              toolbarHeight: 100,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60))),
              bottom: PreferredSize(
                preferredSize: const Size(0, 150),
                child: Image.network(
                  pokemonDetails.homeFrontDefault!,
                  fit: BoxFit.cover,
                  height: 200,
                  width: 200,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 20, bottom: 40),
                child: Column(children: [
                  Center(
                    child: Text(pokemonDetails.name!.capitalize!,
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: Colors.white)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                      spacing: 20,
                      children: pokemonDetails.types!.map((type) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).primaryColor),
                          child: Text(
                            type.name!.capitalize!,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(color: Colors.white),
                          ),
                        );
                      }).toList()),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              gramsToKilo(pokemonDetails.weight!).toString() +
                                  " KG",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Peso",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              decimetersToMeter(pokemonDetails.height!)
                                      .toString() +
                                  " KG",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Altura",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    children: [
                      Text(
                        "Estatísticas Básicas",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: ListView(
                            shrinkWrap: true,
                            children: pokemonDetails.stats!.map((stat) {
                              return Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      handleLabel(stat.name!.toUpperCase()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                    ),
                                    statBar(stat.baseStat!.toDouble())
                                  ],
                                ),
                              );
                            }).toList()),
                      )
                    ],
                  )
                ]),
              ),
            ),
          );
  }
}
