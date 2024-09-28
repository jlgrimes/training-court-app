import 'package:flutter/material.dart';
import 'package:trainingcourt/components/sprites/sprite_from_url.dart';

class Sprite extends StatelessWidget {
  String? pokemonName;

  Sprite(this.pokemonName, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: default icon case
    if (pokemonName == null || pokemonName!.isEmpty) return SizedBox.shrink();

    return SpriteFromUrl('https://limitlesstcg.s3.us-east-2.amazonaws.com/pokemon/gen9/$pokemonName.png');
  }
}
