import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart'; // neede for freezed code generation

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.invalidEmail({
    required T failedValue,
  }) = InvalidEmail<T>; // this = ... is just for frezzed constructor... -> Type
  const factory ValueFailure.shortPassword({
    required T failedValue,
  }) = ShortPassword<T>;
  const factory ValueFailure.exceedingLength({
    required T failedValue,
    required int max,
  }) = ExceedingLength<T>;
  const factory ValueFailure.empty({
    required T failedValue,
  }) = Empty<T>;
  const factory ValueFailure.multyLine({
    required T failedValue,
  }) = MultyLine<T>;
  const factory ValueFailure.listToLong({
    required T failedValue,
    required int max,
  }) = ListToLong<T>;
}