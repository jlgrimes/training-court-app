import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trainingcourt/components/archetype/archetype.utils.dart';
import 'package:trainingcourt/components/sprites/pokemon_sprites.dart';
import 'package:trainingcourt/components/sprites/sprite_from_url.dart';
import 'package:trainingcourt/models/pokedex.dart';
import 'package:trainingcourt/models/provider.dart';

/// The homepage of our application
class ArchetypeAutocomplete extends StatelessWidget {
  const ArchetypeAutocomplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        // Read the activityProvider. This will start the network request
        // if it wasn't already started.
        // By using ref.watch, this widget will rebuild whenever the
        // the activityProvider updates. This can happen when:
        // - The response goes from "loading" to "data/error"
        // - The request was refreshed
        // - The result was modified locally (such as when performing side-effects)
        // ...
        final AsyncValue<Pokedex> pokedex = ref.watch(pokedexProvider);

        return Autocomplete(
  optionsBuilder: (TextEditingValue textEditingValue) {
    if (textEditingValue.text.isEmpty) {
      return const Iterable<String>.empty();
    }

    return pokedex.maybeWhen(
      data: (pokemonList) => pokemonList.pokedex.where((String pokemon) {
        return imgSrcToPkmnName(pokemon.toLowerCase()).contains(
          textEditingValue.text.toLowerCase(),
        );
      }),
      orElse: () => const Iterable<String>.empty(),
    );
  },

  optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
    if (pokedex.isLoading) {
      return Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: 4.0,
          child: Container(
            height: 100.0,
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4.0,
        child: Container(
          height: 200.0,
          child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              final String option = options.elementAt(index);
              return ListTile(
                title: SpriteFromUrl(option),
                subtitle: Text(imgSrcToPkmnName(option)),
                onTap: () {
                  onSelected(imgSrcToPkmnName(option));
                },
              );
            },
          ),
        ),
      ),
    );
  },

  onSelected: (String selectedPokemon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You selected ${selectedPokemon}!'),
      ),
    );
  },

  fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
    return TextField(
      controller: textEditingController,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: 'Search Pokémon',
        border: OutlineInputBorder(),
      ),
      onSubmitted: (String value) {
        onFieldSubmitted();
      },
    );
  },
);}
    );
  }
}