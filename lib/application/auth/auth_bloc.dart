import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:dddcourse/domain/auth/i_auth_facade.dart';
import 'package:injectable/injectable.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@injectable  // now we can inject this bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final IAuthFacade _authFacade;
  AuthBloc(
    this._authFacade,
  ) : super(const AuthState.initial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield* event.map(
    authCheckRequested: (e)async* {
      final userOption = _authFacade.getSignedInUser();
      yield userOption.fold(() => const AuthState.unauthenticated(), (_) => const AuthState.authenticated());
    }, 
    signedOut: (e)async* {
        await _authFacade.signOut();
        yield const AuthState.unauthenticated();
    });
  }
}
