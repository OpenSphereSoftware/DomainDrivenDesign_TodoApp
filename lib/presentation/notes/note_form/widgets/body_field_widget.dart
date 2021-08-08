import 'dart:developer';

import 'package:dddcourse/application/notes/note_form/note_form_bloc.dart';
import 'package:dddcourse/domain/notes/value_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BodyField extends HookWidget {
  const BodyField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();
    return BlocListener<NoteFormBloc, NoteFormState>(
      listenWhen: (p,c)=> p.isEditing != c.isEditing,
      listener: (context, state) {
        textEditingController.text = state.note.body.getOrCrash();
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          decoration: const InputDecoration(labelText: "Note", counterText: ""),
          maxLength: NoteBody.maxLength,
          maxLines: null,
          minLines: 5,
          controller: textEditingController,
          onChanged: (value) => BlocProvider.of<NoteFormBloc>(context)
              .add(NoteFormEvent.bodyChanged(value)),
          validator: (_) => context
              .read<NoteFormBloc>()
              .state
              .note
              .body
              .value
              .fold(
                  (f) => f.maybeMap(
                      empty: (f) => "Cannot be empty",
                      exceedingLength: (f) =>
                          "Exceeding length, max : ${f.max}",
                      orElse: () => null),
                  (_) => null),
        ),
      ),
    );
  }
}
