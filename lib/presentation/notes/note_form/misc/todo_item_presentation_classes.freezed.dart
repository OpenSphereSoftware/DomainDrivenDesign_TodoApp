// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'todo_item_presentation_classes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TodoItemPremitiveTearOff {
  const _$TodoItemPremitiveTearOff();

  _TodoItemPremitive call(
      {required UniqueId id, required String name, required bool done}) {
    return _TodoItemPremitive(
      id: id,
      name: name,
      done: done,
    );
  }
}

/// @nodoc
const $TodoItemPremitive = _$TodoItemPremitiveTearOff();

/// @nodoc
mixin _$TodoItemPremitive {
  UniqueId get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get done => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TodoItemPremitiveCopyWith<TodoItemPremitive> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoItemPremitiveCopyWith<$Res> {
  factory $TodoItemPremitiveCopyWith(
          TodoItemPremitive value, $Res Function(TodoItemPremitive) then) =
      _$TodoItemPremitiveCopyWithImpl<$Res>;
  $Res call({UniqueId id, String name, bool done});
}

/// @nodoc
class _$TodoItemPremitiveCopyWithImpl<$Res>
    implements $TodoItemPremitiveCopyWith<$Res> {
  _$TodoItemPremitiveCopyWithImpl(this._value, this._then);

  final TodoItemPremitive _value;
  // ignore: unused_field
  final $Res Function(TodoItemPremitive) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? done = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as UniqueId,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      done: done == freezed
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$TodoItemPremitiveCopyWith<$Res>
    implements $TodoItemPremitiveCopyWith<$Res> {
  factory _$TodoItemPremitiveCopyWith(
          _TodoItemPremitive value, $Res Function(_TodoItemPremitive) then) =
      __$TodoItemPremitiveCopyWithImpl<$Res>;
  @override
  $Res call({UniqueId id, String name, bool done});
}

/// @nodoc
class __$TodoItemPremitiveCopyWithImpl<$Res>
    extends _$TodoItemPremitiveCopyWithImpl<$Res>
    implements _$TodoItemPremitiveCopyWith<$Res> {
  __$TodoItemPremitiveCopyWithImpl(
      _TodoItemPremitive _value, $Res Function(_TodoItemPremitive) _then)
      : super(_value, (v) => _then(v as _TodoItemPremitive));

  @override
  _TodoItemPremitive get _value => super._value as _TodoItemPremitive;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? done = freezed,
  }) {
    return _then(_TodoItemPremitive(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as UniqueId,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      done: done == freezed
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_TodoItemPremitive extends _TodoItemPremitive {
  const _$_TodoItemPremitive(
      {required this.id, required this.name, required this.done})
      : super._();

  @override
  final UniqueId id;
  @override
  final String name;
  @override
  final bool done;

  @override
  String toString() {
    return 'TodoItemPremitive(id: $id, name: $name, done: $done)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TodoItemPremitive &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.done, done) ||
                const DeepCollectionEquality().equals(other.done, done)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(done);

  @JsonKey(ignore: true)
  @override
  _$TodoItemPremitiveCopyWith<_TodoItemPremitive> get copyWith =>
      __$TodoItemPremitiveCopyWithImpl<_TodoItemPremitive>(this, _$identity);
}

abstract class _TodoItemPremitive extends TodoItemPremitive {
  const factory _TodoItemPremitive(
      {required UniqueId id,
      required String name,
      required bool done}) = _$_TodoItemPremitive;
  const _TodoItemPremitive._() : super._();

  @override
  UniqueId get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  bool get done => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TodoItemPremitiveCopyWith<_TodoItemPremitive> get copyWith =>
      throw _privateConstructorUsedError;
}
