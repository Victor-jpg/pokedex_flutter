import 'package:compart/controller/home/home_controllerg.dart';
import 'package:compart/database/objectbox_database.dart';
import 'package:compart/repositories/pokemon_api.dart';
import 'package:get/get.dart';

class HomeBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeControllerG>(() {
      final PokemonAPI api = PokemonAPI();
      final ObjectBoxDatabase objectBoxDatabase = ObjectBoxDatabase();

      return HomeControllerG(api, objectBoxDatabase);
    });
  }
}
