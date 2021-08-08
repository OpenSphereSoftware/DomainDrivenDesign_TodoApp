import 'package:another_flushbar/flushbar.dart';
import 'package:dddcourse/application/notes/note_form/note_form_bloc.dart';
import 'package:dddcourse/injection.dart';
import 'package:dddcourse/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:dddcourse/presentation/notes/note_form/widgets/add_todo_tile_widget.dart';
import 'package:dddcourse/presentation/notes/note_form/widgets/body_field_widget.dart';
import 'package:dddcourse/presentation/notes/note_form/widgets/color_field_widget.dart';
import 'package:dddcourse/presentation/notes/note_form/widgets/todo_list_widget.dart';
import 'package:dddcourse/presentation/routes/router.gr.dart';
import 'package:flutter/material.dart';

import 'package:dddcourse/domain/notes/note.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class NoteFormPage extends StatelessWidget {
  final Note? editedNote;
  const NoteFormPage({
    Key? key,
    required this.editedNote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<NoteFormBloc>()..add(NoteFormEvent.initialized(editedNote)),
      child: BlocConsumer<NoteFormBloc, NoteFormState>(
        listenWhen: (p, c) =>
            p.saveFailureOrSuccessOption != c.saveFailureOrSuccessOption,
        listener: (context, state) {
          state.saveFailureOrSuccessOption.fold(() => {}, //! if none
              (either) {
            either.fold((failure) {
              //! if some
              Flushbar(
                message: failure.map(
                    unexpected: (_) => "unexpected",
                    insufficientPermissions: (_) => "insufficientPermissions",
                    unableToUpdate: (_) => "unableToUpdate"),
                backgroundColor: Colors.redAccent,
                duration: const Duration(seconds: 3),
              ).show(context);
            }, (r) {
              Navigator.of(context).popUntil((route) =>
                  route.settings.name ==
                  NotesOverviewPageRoute.name); //Todo test if works
              // AutoRouter.of(context).push(const NotesOverviewPageRoute());
              //BlocProvider.of<AuthBloc>(context).add(const AuthEvent.authCheckRequested());
            });
          });
        },
        buildWhen: (p, c) => p.isSaving != c.isSaving,
        builder: (context, state) {
          return Stack(
            children: [
              const NoteFormPageScaffold(),
              SavingInProgressOverlay(
                isSaving: state.isSaving,
              )
            ],
          );
        },
      ),
    );
  }
}

class SavingInProgressOverlay extends StatelessWidget {
  final bool isSaving;
  const SavingInProgressOverlay({
    Key? key,
    required this.isSaving,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isSaving,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: isSaving ? Colors.black.withOpacity(0.8) : Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Visibility(
          visible: isSaving,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                height: 10,
              ),
              Text(
                "is saving",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white, fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NoteFormPageScaffold extends StatelessWidget {
  const NoteFormPageScaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NoteFormBloc, NoteFormState>(
          builder: (context, state) {
            return Text(state.isEditing ? "Edit a Note" : "Create a Note");
          },
          buildWhen: (p, c) => p.isEditing != c.isEditing,
        ), // !! very coool stuff man    only build if is edeting changes
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<NoteFormBloc>(context)
                    .add(const NoteFormEvent.saved());
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: BlocBuilder<NoteFormBloc, NoteFormState>(
        buildWhen: (p, c) => p.showErrorMessages != c.showErrorMessages,
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (_) => FormTodos(),
            child: Form(
              autovalidate: state.showErrorMessages,
              child: SingleChildScrollView(
                child:  Column(
                  children: [
                    const BodyField(),
                    const ColorField(),
                    const TodoList(),
                    const AddTodoTile(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
