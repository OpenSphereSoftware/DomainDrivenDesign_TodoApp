import 'package:dddcourse/domain/core/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class CustomUser with _$CustomUser {
  const factory CustomUser({
    required UniqueId id, 
  }) = _User;
}