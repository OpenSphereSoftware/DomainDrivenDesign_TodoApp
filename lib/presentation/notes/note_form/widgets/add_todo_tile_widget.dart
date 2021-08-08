import 'package:dddcourse/application/notes/note_form/note_form_bloc.dart';
import 'package:dddcourse/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/collection.dart';
import 'package:provider/provider.dart';

import 'package:dddcourse/presentation/notes/note_form/misc/build_context_x.dart';

class AddTodoTile extends StatelessWidget {
  const AddTodoTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteFormBloc, NoteFormState>(
        listenWhen: (p, c) => p.isEditing != c.isEditing,
        listener: (context, state) {
          context.formTodos =
              state.note.todos.value.fold(
                  (f) => listOf<TodoItemPremitive>(),
                  (todoItemList) => todoItemList.map(
                      (todoItem) => TodoItemPremitive.fromDomain(todoItem)));
        },
        buildWhen: (p, c) => p.note.todos.isFull != c.note.todos.isFull,
        builder: (context, state) {
          return ListTile(
            enabled: !state.note.todos.isFull,
            title: const Text("Add a todo"),
            leading: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.add),
            ),
            onTap: () {
              context.formTodos =
                  Provider.of<FormTodos>(context, listen: false)
                      .value
                      .plusElement(TodoItemPremitive.empty());

              context.read<NoteFormBloc>().add(NoteFormEvent.todosChanged(
                  context.formTodos));
            },
          );
        });
  }
}
