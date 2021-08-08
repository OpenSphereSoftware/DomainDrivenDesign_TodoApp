import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dddcourse/domain/core/value_objects.dart';
import 'package:dddcourse/domain/notes/note.dart';
import 'package:dddcourse/domain/notes/todo_item.dart';
import 'package:dddcourse/domain/notes/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';

part 'note_dtos.freezed.dart';
part 'note_dtos.g.dart';

@freezed
abstract class TodoItemDto implements _$TodoItemDto {
  const TodoItemDto._();
  const factory TodoItemDto({
    required String id,
    required String name,
    required bool done,
  }) = _TodoItemDto;

  factory TodoItemDto.fromDomain(TodoItem todoItem) {
    return TodoItemDto(
        id: todoItem.id.getOrCrash(),
        name: todoItem.name.getOrCrash(),
        done: todoItem.done);
  }

  TodoItem toDomain() {
    return TodoItem(
        name: TodoName(name), id: UniqueId.fromUniqueString(id), done: done);
  }

  factory TodoItemDto.fromJson(Map<String, dynamic> json) =>
      _$TodoItemDtoFromJson(json);
}

@freezed
abstract class NoteDto implements _$NoteDto {
  const NoteDto._();

  const factory NoteDto({
    @JsonKey(ignore: true) String? id,
    required String body,
    required int color,
    required List<TodoItemDto> todos,
    // placeholder -> time on server when the note has been updated
    required dynamic serverTimeStamp,
  }) = _NoteDto;

  factory NoteDto.fromDomain(Note note) {
    return NoteDto(
        id: note.id.getOrCrash(),
        body: note.body.getOrCrash(),
        color: note.color.getOrCrash().value,
        todos: note.todos
            .getOrCrash()
            .map((todoItem) => TodoItemDto.fromDomain(todoItem))
            .asList(),
        serverTimeStamp: FieldValue.serverTimestamp());
  }

  Note toDomain() {
    return Note(
        id: UniqueId.fromUniqueString(id.toString()),
        body: NoteBody(body),
        color: NoteColor(Color(color)),
        todos: List3(todos.map((dto) => dto.toDomain()).toImmutableList()));
  }

  factory NoteDto.fromJson(Map<String,dynamic> json) => _$NoteDtoFromJson(json);

   factory NoteDto.fromFirestore(DocumentSnapshot doc) {
    return NoteDto.fromJson(doc.data() as Map<String,dynamic>).copyWith(id: doc.id);
  }

  /*factory NoteDto.fromFirestore(DocumentSnapshot doc) {
    final data = Map<String, Object>.from(doc.data()! as Map ) ; // !!! important line to not get error -->>  '_InternalLinkedHashMap<String, dynamic>' is not a subtype of type 'Map<String, Object>' 
    return NoteDto.fromJson(data).copyWith(id: doc.id);*/

    //return NoteDto.fromJson( doc.data() as Map<String, Object>).copyWith(id: doc.id);
  


}


