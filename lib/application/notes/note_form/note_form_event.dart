part of 'note_form_bloc.dart';

@freezed
class NoteFormEvent with _$NoteFormEvent {
  const factory NoteFormEvent.bodyChanged(String bodyStr) = _BodyChanged;
  const factory NoteFormEvent.colorChanged(Color color) = _ColorChanged;
  const factory NoteFormEvent.todosChanged(KtList<TodoItemPremitive> todos ) = _TodosChanged;
  const factory NoteFormEvent.saved() = _Saved;
  const factory NoteFormEvent.initialized(Note? initialNoteOption) = _Initialized;
}