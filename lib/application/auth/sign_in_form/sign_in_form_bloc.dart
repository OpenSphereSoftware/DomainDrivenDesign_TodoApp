import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:dddcourse/domain/auth/auth_failure.dart';
import 'package:dddcourse/domain/auth/i_auth_facade.dart';
import 'package:dddcourse/domain/auth/value_objects.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_form_bloc.freezed.dart';
part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(
    this._authFacade,
  ) : super(SignInFormState.initial());

  @override
  Stream<SignInFormState> mapEventToState(
    SignInFormEvent event,
  ) async* {
    yield* event.map(
        //
        //
        emailChanged: (e) async* {
      yield state.copyWith(
          emailAddress: EmailAddress(e.emailStr),
          authFailureOrSuccessOption: none());
    },
        //
        //
        passwordChanged: (e) async* {
      yield state.copyWith(
          password: Password(e.passwordStr),
          authFailureOrSuccessOption: none());
    },
        //
        //
        registerWithEmailAndPasswordPressed: (e) async* {
      final isEmailValid = state.emailAddress.isValid();
      final isPasswordValid = state.password.isValid();
      Either<AuthFailure, Unit>? failureOrSuccess;
      
      if (isEmailValid && isPasswordValid) {
        yield state.copyWith(
            isSubmitting: true, authFailureOrSuccessOption: none());

        failureOrSuccess = await _authFacade.registerWithEmailAndPassword(
            emailAddress: state.emailAddress, password: state.password);
      }

      yield state.copyWith(
        isSubmitting: false,
        showErrorMessages: true,
        authFailureOrSuccessOption: optionOf(
            failureOrSuccess), //* returns either none() ro some() depending of if failureOrSuccess is null or not
      );
    },
        //
        //
        signInWithEmailAndPasswordPressed: (e) async* {
      final isEmailValid = state.emailAddress.isValid();
      final isPasswordValid = state.password.isValid();
      Either<AuthFailure, Unit>? failureOrSuccess;
      if (isEmailValid && isPasswordValid) {
        yield state.copyWith(
            isSubmitting: true, authFailureOrSuccessOption: none());

        failureOrSuccess = await _authFacade.signInWithEmailAndPassword(
            emailAddress: state.emailAddress, password: state.password);
      }

      yield state.copyWith(
        isSubmitting: false,
        showErrorMessages: true,
        authFailureOrSuccessOption: optionOf(
            failureOrSuccess), //* returns either none() ro some() depending of if failureOrSuccess is null or not
      );
    },
        //
        //
        signInWithGooglePressed: (e) async* {
      yield state.copyWith(
          isSubmitting: true, authFailureOrSuccessOption: none());

      final failureOrSuccess = await _authFacade.signInWithGoogle();

      yield state.copyWith(
          isSubmitting: false,
          authFailureOrSuccessOption: some(failureOrSuccess));
    });
  }
}
