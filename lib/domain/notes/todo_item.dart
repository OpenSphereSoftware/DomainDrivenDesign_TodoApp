import 'package:dartz/dartz.dart';
import 'package:dddcourse/domain/core/failures.dart';
import 'package:dddcourse/domain/core/value_objects.dart';
import 'package:dddcourse/domain/notes/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_item.freezed.dart';

@freezed
abstract class TodoItem implements _$TodoItem {
  // changed with to implements to add getters

  const TodoItem._();
  
  const factory TodoItem({
    required UniqueId id,
    required TodoName name,
    required bool done,
  }) = _TodoItem;

  factory TodoItem.empty() =>
      TodoItem(id: UniqueId(), name: TodoName(""), done: false);

  Option<ValueFailure<dynamic>> get failureOption {
    return name.value.fold((f) => some(f), (_) => none());
  }
}
