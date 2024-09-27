import 'package:flutter/material.dart';

class Sprite extends StatelessWidget {
  String? pokemonName;

  Sprite(this.pokemonName, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: default icon case
    // if (pokemonName == null) return null;

    return Image.network(
      'https://limitlesstcg.s3.us-east-2.amazonaws.com/pokemon/gen9/$pokemonName.png',
      filterQuality: FilterQuality.none,
    );
  }
}
