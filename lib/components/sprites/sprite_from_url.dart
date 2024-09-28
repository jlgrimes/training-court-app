import 'package:flutter/material.dart';

class SpriteFromUrl extends StatelessWidget {
  String pokemonUrl;

  SpriteFromUrl(this.pokemonUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: default icon case
    // if (pokemonName == null) return null;

    return Image.network(
      pokemonUrl,
      filterQuality: FilterQuality.none,
      height: 40,
      width: 40,
    );
  }
}
