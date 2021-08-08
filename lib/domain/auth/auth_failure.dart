import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
abstract class AuthFailure<T> with _$AuthFailure<T> {
  const factory AuthFailure.cancelledByUser() = CancelledByUser<T>; 
  const factory AuthFailure.serverError() = ServerError<T>; 
  const factory AuthFailure.emailAlreadyInUse() = EmailAlreadyInUse<T>; 
  const factory AuthFailure.invalidEmailAndPasswordCombination() = InvalidEmailAndPasswordCombination<T>; 

}

