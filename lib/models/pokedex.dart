import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokedex.freezed.dart';
part 'pokedex.g.dart';

/// The response of the `GET /api/activity` endpoint.
///
/// It is defined using `freezed` and `json_serializable`.
@freezed
class Pokedex with _$Pokedex {
  factory Pokedex({
    required List<String> pokedex,
  }) = _Pokedex;

  /// Convert a JSON object into an [Activity] instance.
  /// This enables type-safe reading of the API response.
  factory Pokedex.fromJson(Map<String, dynamic> json) => _$PokedexFromJson(json);
}