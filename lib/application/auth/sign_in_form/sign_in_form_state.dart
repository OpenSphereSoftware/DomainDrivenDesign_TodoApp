part of 'sign_in_form_bloc.dart';

@freezed
class SignInFormState with _$SignInFormState {
  const factory SignInFormState(
          {required EmailAddress emailAddress,
          required Password password,
          required bool isSubmitting,
          required bool showErrorMessages,
          required Option<Either<AuthFailure, Unit>>
              authFailureOrSuccessOption}) =
      _SignInFormState; //* not have multiple union cases    for states better do a dataclass like this    Option<None,Some> Either<Left,Right>

  factory SignInFormState.initial() => SignInFormState(
      emailAddress: EmailAddress(""),
      password: Password(""),
      isSubmitting: false,
      showErrorMessages: false,
      authFailureOrSuccessOption: none());
}
