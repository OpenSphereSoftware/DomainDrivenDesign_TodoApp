import 'package:another_flushbar/flushbar.dart';
import 'package:dartz/dartz.dart';
import 'package:dddcourse/domain/notes/value_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:kt_dart/collection.dart';
import 'package:provider/provider.dart';

import 'package:dddcourse/application/notes/note_form/note_form_bloc.dart';
import 'package:dddcourse/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';

import 'package:dddcourse/presentation/notes/note_form/misc/build_context_x.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteFormBloc, NoteFormState>(
      listenWhen: (p, c) => p.note.todos.isFull != c.note.todos.isFull,
      listener: (context, state) {
        if (state.note.todos.isFull) {
          Flushbar(
            message: "Want longer lists? Activate premium 💊",
            mainButton: TextButton(
                onPressed: () {
                  // ignore: avoid_print
                  print("kaufen kaufen kaufen");
                },
                child: const Text(
                  "buy not",
                  style: TextStyle(color: Colors.yellow),
                )),
            backgroundColor: Colors.grey[850]!,
            duration: const Duration(seconds: 5),
          ).show(context);
        }
      },
      child: Consumer<FormTodos>(
        builder: (context, formTodos, child) {
          return ImplicitlyAnimatedReorderableList<TodoItemPremitive>(
            removeDuration: const Duration(milliseconds: 0),
            shrinkWrap: true,
            items: formTodos.value.asList(),
            itemBuilder: (context, animation, item, i) {
              return Reorderable(
                key: ValueKey(item.id),
                builder: (context, animation, inDrag) {
                  return ScaleTransition(
                      //0 => 1
                      // ! 1 to lower value 0.85
                      scale:
                          Tween<double>(begin: 1, end: 0.95).animate(animation),
                      child: TodoTile(animation.value * 4, index: i));
                },
              );
            },
            areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
            onReorderFinished: (item, from, to, newItems) {
              context.formTodos = newItems.toImmutableList();

              context
                  .read<NoteFormBloc>()
                  .add(NoteFormEvent.todosChanged(context.formTodos));
            },
          );
        },
      ),
    );
  }
}

class TodoTile extends HookWidget {
  final double elevation;
  final int index;

  const TodoTile(double? elevation, {required this.index, Key? key})
      : elevation = elevation ?? 0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo =
        context.formTodos.getOrElse(index, (_) => TodoItemPremitive.empty());
    final textEditingController = useTextEditingController(text: todo.name);

    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.15,
      secondaryActions: [
        IconSlideAction(
          caption: "delete",
          icon: Icons.delete,
          color: Colors.red,
          onTap: () {
            context.formTodos = context.formTodos.minusElement(todo);
            context
                .read<NoteFormBloc>()
                .add(NoteFormEvent.todosChanged(context.formTodos));
          },
        )
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Material(
          borderRadius: BorderRadius.circular(8),
          elevation: elevation,
          animationDuration: const Duration(milliseconds: 50),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              trailing: const Handle(child: Icon(Icons.list)),
              title: TextFormField(
                decoration: const InputDecoration(
                    hintText: "Todo",
                    border: InputBorder.none,
                    counterText: ""),
                controller: textEditingController,
                maxLength: TodoName.maxLength,
                onChanged: (value) {
                  context.formTodos = context.formTodos.map((listTodo) =>
                      listTodo == todo
                          ? todo.copyWith(name: value)
                          : listTodo); // ! updated todos ui wise

                  context.read<NoteFormBloc>().add(NoteFormEvent.todosChanged(
                      context.formTodos)); // ! bring the change to the backend
                },
                validator: (_) {
                  context.read<NoteFormBloc>().state.note.todos.value.fold(
                      (f) => null,
                      (todoList) => todoList[index].name.value.fold(
                          (f) => f.maybeMap(
                              multyLine: (_) => "mimimimi", orElse: () => null),
                          (_) => null));
                },
              ),
              leading: Checkbox(
                  value: todo.done,
                  onChanged: (value) {
                    context.formTodos = context.formTodos.map((listTodo) =>
                        listTodo == todo
                            ? todo.copyWith(done: value!)
                            : listTodo); // ! updated todos ui wise

                    context.read<NoteFormBloc>().add(NoteFormEvent.todosChanged(
                        context
                            .formTodos)); // ! bring the change to the backend
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
