import 'package:bloc/bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:meta/meta.dart';
import 'package:note_app/fire_base/fire_base_fire_store.dart';
import 'package:note_app/models/note_model.dart';

part 'get_notes_state.dart';

class GetNotesCubit extends Cubit<GetNotesState> {
  GetNotesCubit() : super(GetNotesInitial());
  FireBaseFireStore fireStore = FireBaseFireStore();

  Future<void> getNotes() async {
    try {
      emit(GetNotesLoading());
      List<NoteModel> notes = await fireStore.getNotes();
      emit(GetNotesSuccess(notes: notes));
    } catch (e) {
      emit(GetNotesFailure(error: "error happened"));
    }
  }

  void deleteLocal(NoteModel note) {
    List<NoteModel> notes = List.from((state as GetNotesSuccess).notes)
      ..removeWhere((element) => element.id == note.id);
    emit(GetNotesSuccess(notes: notes));
  }
}
