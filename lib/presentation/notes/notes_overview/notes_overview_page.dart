import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dddcourse/application/auth/auth_bloc.dart';
import 'package:dddcourse/application/notes/note_actor/note_actor_bloc.dart';
import 'package:dddcourse/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:dddcourse/presentation/notes/note_form/note_form_page.dart';
import 'package:dddcourse/presentation/notes/notes_overview/widgets/notes_overview_body_widget.dart';
import 'package:dddcourse/presentation/notes/notes_overview/widgets/uncompleted_switch.dart';
import 'package:dddcourse/presentation/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection.dart';

class NotesOverviewPage extends StatelessWidget {
  const NotesOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteWatcherBloc>(
          create: (context) => getIt<NoteWatcherBloc>()
            ..add(const NoteWatcherEvent.watchAllStarted()),
        ),
        BlocProvider<NoteActorBloc>(
          create: (context) => getIt<NoteActorBloc>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(listener: (context, state) {
            state.maybeMap(
                unauthenticated: (_) =>
                    AutoRouter.of(context).push(const SignInPageRoute()),
                orElse: () {});
          }),
          BlocListener<NoteActorBloc, NoteActorState>(
              listener: (context, state) {
            state.maybeMap(
                orElse: () {},
                deleteFailure: (state) {
                  Flushbar(
                    message: state.noteFailure.map(
                      unexpected: (_)=> "unexpected", 
                      insufficientPermissions: (_)=>"insufficientPermissions", 
                      unableToUpdate: (_)=> "unableToUpdate"),
                    backgroundColor: Colors.redAccent,
                    duration: const Duration(seconds: 3),
                  ).show(context);
                });
          })
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
            leading: IconButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context)
                      .add(const AuthEvent.signedOut());
                },
                icon: const Icon(Icons.exit_to_app)),
            actions: [
              UncompletedSwitch(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AutoRouter.of(context).push( NoteFormPageRoute(editedNote: null));
            },
             
            child: const Icon(Icons.add),
          ),

          body: NotesOverviewBody(),
        ),
      ),
    );
  }
}
