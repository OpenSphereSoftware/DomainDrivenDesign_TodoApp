import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dddcourse/domain/notes/i_note_repository.dart';
import 'package:dddcourse/domain/notes/note.dart';
import 'package:dddcourse/domain/notes/note_failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'note_actor_event.dart';
part 'note_actor_state.dart';
part 'note_actor_bloc.freezed.dart';

@injectable
class NoteActorBloc extends Bloc<NoteActorEvent, NoteActorState> {
  final INoteRepository _noteRepository;

  NoteActorBloc(this._noteRepository) : super(const _Initial());

  @override
  Stream<NoteActorState> mapEventToState(
    NoteActorEvent event,
  ) async* {
    //yield* event.map(deleted: (e)async*{   // only one event  we can miss this mapping
    yield const NoteActorState.actionInProgress();
    final possibleFailure = await _noteRepository.delete(event.note);
    yield possibleFailure.fold((f) => NoteActorState.deleteFailure(f),
        (_) => const NoteActorState.deleteSuccess());
    //});
  }
}
