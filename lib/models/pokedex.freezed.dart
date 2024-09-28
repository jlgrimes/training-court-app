// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pokedex.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Pokedex _$PokedexFromJson(Map<String, dynamic> json) {
  return _Pokedex.fromJson(json);
}

/// @nodoc
mixin _$Pokedex {
  List<String> get pokedex => throw _privateConstructorUsedError;

  /// Serializes this Pokedex to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Pokedex
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PokedexCopyWith<Pokedex> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PokedexCopyWith<$Res> {
  factory $PokedexCopyWith(Pokedex value, $Res Function(Pokedex) then) =
      _$PokedexCopyWithImpl<$Res, Pokedex>;
  @useResult
  $Res call({List<String> pokedex});
}

/// @nodoc
class _$PokedexCopyWithImpl<$Res, $Val extends Pokedex>
    implements $PokedexCopyWith<$Res> {
  _$PokedexCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Pokedex
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pokedex = null,
  }) {
    return _then(_value.copyWith(
      pokedex: null == pokedex
          ? _value.pokedex
          : pokedex // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PokedexImplCopyWith<$Res> implements $PokedexCopyWith<$Res> {
  factory _$$PokedexImplCopyWith(
          _$PokedexImpl value, $Res Function(_$PokedexImpl) then) =
      __$$PokedexImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> pokedex});
}

/// @nodoc
class __$$PokedexImplCopyWithImpl<$Res>
    extends _$PokedexCopyWithImpl<$Res, _$PokedexImpl>
    implements _$$PokedexImplCopyWith<$Res> {
  __$$PokedexImplCopyWithImpl(
      _$PokedexImpl _value, $Res Function(_$PokedexImpl) _then)
      : super(_value, _then);

  /// Create a copy of Pokedex
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pokedex = null,
  }) {
    return _then(_$PokedexImpl(
      pokedex: null == pokedex
          ? _value._pokedex
          : pokedex // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PokedexImpl implements _Pokedex {
  _$PokedexImpl({required final List<String> pokedex}) : _pokedex = pokedex;

  factory _$PokedexImpl.fromJson(Map<String, dynamic> json) =>
      _$$PokedexImplFromJson(json);

  final List<String> _pokedex;
  @override
  List<String> get pokedex {
    if (_pokedex is EqualUnmodifiableListView) return _pokedex;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pokedex);
  }

  @override
  String toString() {
    return 'Pokedex(pokedex: $pokedex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PokedexImpl &&
            const DeepCollectionEquality().equals(other._pokedex, _pokedex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_pokedex));

  /// Create a copy of Pokedex
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PokedexImplCopyWith<_$PokedexImpl> get copyWith =>
      __$$PokedexImplCopyWithImpl<_$PokedexImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PokedexImplToJson(
      this,
    );
  }
}

abstract class _Pokedex implements Pokedex {
  factory _Pokedex({required final List<String> pokedex}) = _$PokedexImpl;

  factory _Pokedex.fromJson(Map<String, dynamic> json) = _$PokedexImpl.fromJson;

  @override
  List<String> get pokedex;

  /// Create a copy of Pokedex
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PokedexImplCopyWith<_$PokedexImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
