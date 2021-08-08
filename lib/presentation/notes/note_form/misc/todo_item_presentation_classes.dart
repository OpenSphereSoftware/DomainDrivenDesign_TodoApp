import 'package:dddcourse/domain/core/value_objects.dart';
import 'package:dddcourse/domain/notes/todo_item.dart';
import 'package:dddcourse/domain/notes/value_objects.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';

part 'todo_item_presentation_classes.freezed.dart';

class FormTodos extends ValueNotifier<KtList<TodoItemPremitive>>{
  FormTodos() : super(emptyList<TodoItemPremitive>());
}


@freezed
abstract class TodoItemPremitive implements _$TodoItemPremitive {
  const TodoItemPremitive._();

  const factory TodoItemPremitive({
    required UniqueId id,
    required String name,
    required bool done,
  }) = _TodoItemPremitive;

  factory TodoItemPremitive.empty() =>
      TodoItemPremitive(id: UniqueId(), name: '', done: false);

  factory TodoItemPremitive.fromDomain(TodoItem todoItem) {
    return TodoItemPremitive(
        id: todoItem.id, name: todoItem.name.getOrCrash(), done: todoItem.done);
  }

  TodoItem toDomain() {
    return TodoItem(name: TodoName(name), id: id, done: done);
  }
}
