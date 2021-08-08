
import 'package:dddcourse/application/auth/auth_bloc.dart';
import 'package:dddcourse/presentation/routes/router.gr.dart' as r;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection.dart';

class MyApp extends StatelessWidget {

  final _appRouter = r.AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()))
      ],

      child: MaterialApp.router(
        routeInformationParser: _appRouter.defaultRouteParser(), 
        routerDelegate: _appRouter.delegate(),        
        title: 'Notes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
            primaryColor: Colors.green[800],
            accentColor: Colors.blueAccent,
            floatingActionButtonTheme: const FloatingActionButtonThemeData( backgroundColor: Colors.blueAccent),
            inputDecorationTheme: InputDecorationTheme(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
      ),
    );
  }
}
