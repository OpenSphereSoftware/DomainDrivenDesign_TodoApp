import 'package:dartz/dartz.dart';
import 'package:dddcourse/domain/core/failures.dart';
import 'package:dddcourse/domain/core/value_objects.dart';
import 'package:dddcourse/domain/notes/todo_item.dart';
import 'package:dddcourse/domain/notes/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';

part 'note.freezed.dart';

@freezed
abstract class Note implements _$Note {
  const Note._();

  const factory Note({
    required UniqueId id,
    required NoteBody body,
    required NoteColor color,
    required List3<TodoItem> todos,
  }) = _Note;

  factory Note.empty() => Note(
      id: UniqueId(),
      body: NoteBody(""),
      color: NoteColor(NoteColor.predefinedColors[0]),
      todos: List3(emptyList()));

  Option<ValueFailure<dynamic>> get failureOption {
    return body.failureOrUnit
        .andThen(todos.failureOrUnit)
        .andThen(todos
            .getOrCrash() // get all todos -> shoulb be valid because of pervious step
            .map((todoItem) => todoItem.failureOption) // map todos -> get from all items the failure option (could be none or some)
            .filter((o) => o.isSome()) // get only all failed Options
            .getOrElse(0, (_) => none()) // check if list is full or empty   get lsit[0] or return none 
            .fold(() => right(unit), (f) => left(f))) // if none -> all goood in my hood     if some (f) -> retrun left failure
        .fold((f) => some(f), (_) => none()); // if failurer -> some(f)    if right -> none
  }
}
