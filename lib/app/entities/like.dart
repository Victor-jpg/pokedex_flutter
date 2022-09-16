import 'package:objectbox/objectbox.dart';

@Entity()
class Like {
  int id = 0;
  int? pokemonId;

  Like({this.pokemonId});
}
