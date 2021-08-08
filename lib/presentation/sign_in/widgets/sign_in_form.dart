import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dddcourse/application/auth/auth_bloc.dart';
import 'package:dddcourse/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:dddcourse/presentation/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
            () => {}, //! if none
            (either) => either.fold((failure) {
                  Flushbar(
                    message: failure.map(
                        cancelledByUser: (_) => "cancelledByUser",
                        serverError: (_) => "serverError",
                        emailAlreadyInUse: (_) => "emailAlreadyInUse",
                        invalidEmailAndPasswordCombination: (_) =>
                            "invalidEmailAndPasswordCombination"),
                    backgroundColor: Colors.redAccent,
                    duration: const Duration(seconds: 3),
                  ).show(context);
                },
                    (_) {
                          AutoRouter.of(context).push(const NotesOverviewPageRoute());    
                          BlocProvider.of<AuthBloc>(context).add(const AuthEvent.authCheckRequested());
                         

                          // context.router.replace(const NotesOverviewPageRoute());
                        })
                        
                        );
      },
      builder: (context, state) {
        return Form(
          // ignore: deprecated_member_use
          autovalidate: state.showErrorMessages,
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              const Text("😎",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 130)),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email), labelText: "Email"),
                autocorrect: false,
                onChanged: (value) => BlocProvider.of<SignInFormBloc>(context)
                    .add(SignInFormEvent.emailChanged(emailStr: value)),
                validator: (_) => BlocProvider.of<SignInFormBloc>(context)
                    .state
                    .emailAddress
                    .value
                    .fold(
                        //! getting state directly form bloc instead of builder
                        (f) => f.maybeMap(
                            invalidEmail: (_) => "Invalid Email",
                            orElse: () => null),
                        (_) => null),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email), labelText: "Password"),
                autocorrect: false,
                onChanged: (value) => BlocProvider.of<SignInFormBloc>(context)
                    .add(SignInFormEvent.passwordChanged(passwordStr: value)),
                validator: (_) => BlocProvider.of<SignInFormBloc>(context)
                    .state
                    .password
                    .value
                    .fold(
                        //! getting state directly form bloc instead of builder
                        (f) => f.maybeMap(
                            shortPassword: (_) => "Short Password",
                            orElse: () => null),
                        (_) => null),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          BlocProvider.of<SignInFormBloc>(context).add(
                              const SignInFormEvent
                                  .signInWithEmailAndPasswordPressed());
                        },
                        child: const Text("SIGN IN"))),
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          BlocProvider.of<SignInFormBloc>(context).add(
                              const SignInFormEvent
                                  .registerWithEmailAndPasswordPressed());
                        },
                        child: const Text("REGISTER")))
              ]),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<SignInFormBloc>(context)
                        .add(const SignInFormEvent.signInWithGooglePressed());
                  },
                  child: const Text("SIGN IN WITH GOOGLE")),
              if (state.isSubmitting) ...[
                const SizedBox(
                  height: 8,
                ),
                const LinearProgressIndicator(
                  value: null,
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}
