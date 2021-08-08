import 'package:dddcourse/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:dddcourse/injection.dart';
import 'package:dddcourse/presentation/sign_in/widgets/sign_in_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: BlocProvider(
          create: (context) => getIt<SignInFormBloc>(), child: const SignInForm()),
    );
  }
}
