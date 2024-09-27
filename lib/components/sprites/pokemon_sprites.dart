import 'package:flutter/material.dart';
import 'package:trainingcourt/components/sprites/sprite.dart';

class PokemonSprites extends StatelessWidget {
  String? pokemonNameString;

  PokemonSprites(this.pokemonNameString, {super.key});

  @override
  Widget build(BuildContext context) {
    if (pokemonNameString == null) {
      return SizedBox.shrink();
    }

    if (pokemonNameString!.isEmpty) {
      return SizedBox.shrink();
    }

    if (!pokemonNameString!.contains(',')) {
      return Row(children: [
        Sprite(pokemonNameString),
      ]);
    }

    return Row(children: [
      Sprite(pokemonNameString!.split(',')[0]),
      Sprite(pokemonNameString!.split(',')[1]),
    ]);
  }
}
