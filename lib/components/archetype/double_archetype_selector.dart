import 'package:flutter/material.dart';
import 'package:trainingcourt/components/archetype/archetype_autocomplete.dart';

class DoubleArchetypeSelector extends StatelessWidget {
  Function(String message, int idx) handlePokemonSelect;

  DoubleArchetypeSelector(this.handlePokemonSelect, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
                    ArchetypeAutocomplete(handlePokemonSelect: (p0) => handlePokemonSelect(p0, 0)),
                              const SizedBox(height: 16),
              ArchetypeAutocomplete(handlePokemonSelect: (p0) => handlePokemonSelect(p0, 1)),
    ],);
  }
}
