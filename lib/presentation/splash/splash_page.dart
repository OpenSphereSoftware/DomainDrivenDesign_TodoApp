


import 'package:auto_route/auto_route.dart';
import 'package:dddcourse/application/auth/auth_bloc.dart';
import 'package:dddcourse/presentation/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(listener: (context, state){
      state.map(
        initial: (_)  {}, 
        authenticated: (_)  {
          context.router.replace(const NotesOverviewPageRoute());
        },
        unauthenticated: (_)  {
            context.router.replace(const SignInPageRoute());
        },);
        
    },
    child: const Scaffold(body: Center(child: CircularProgressIndicator()),)
    
    
    );
    
  }
}