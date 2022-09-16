import 'package:objectbox/objectbox.dart';

@Entity()
class Favorite {
  int id = 0;
  int? pokemonId;

  Favorite({this.pokemonId});
}
