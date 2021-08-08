import 'package:dartz/dartz.dart';
import 'package:dddcourse/domain/auth/auth_failure.dart';
import 'package:dddcourse/domain/auth/user.dart';
import 'package:dddcourse/domain/auth/value_objects.dart';

abstract class IAuthFacade {

  Option<CustomUser> getSignedInUser();

  Future<Either<AuthFailure, Unit >> registerWithEmailAndPassword(  // * Unit (void) einfach dass man da was lehres zurück gibt -> ()
      {required EmailAddress emailAddress, required Password password});

  Future<Either<AuthFailure, Unit >> signInWithEmailAndPassword(
      {required EmailAddress emailAddress, required Password password});

  Future<Either<AuthFailure, Unit >> signInWithGoogle();

  Future<void> signOut();
}
