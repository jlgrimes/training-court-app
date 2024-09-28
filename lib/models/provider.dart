
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'pokedex.dart';

// Necessary for code-generation to work
part 'provider.g.dart';

/// This will create a provider named `pokedexProvider`
/// which will cache the result of this function.
@riverpod
Future<Pokedex> pokedex(PokedexRef ref) async {
  // Using package:http, we fetch a random activity from the Bored API.
  final response = await http.get(Uri.https('trainingcourt.app', '/api/pokedex'));
  // Using dart:convert, we then decode the JSON payload into a Map data structure.
  final json = jsonDecode(response.body) as Map<String, dynamic>;
  // Finally, we convert the Map into an Activity instance.
  return Pokedex.fromJson(json);
}