import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:note_app/fire_base/fire_base_fire_store.dart';
import 'package:note_app/models/note_model.dart';

part 'delete_note_state.dart';

class DeleteNoteCubit extends Cubit<DeleteNoteState> {
  FireBaseFireStore fireStore = FireBaseFireStore();
  DeleteNoteCubit() : super(DeleteNoteInitial());
  Future<void> deleteNote(NoteModel note) async {
    try {
      emit(DeleteNoteLoading());
      await fireStore.deleteNote(note);
      emit(DeleteNoteSuccess());
    } catch (e) {
      emit(DeleteNoteFailure(error: "error"));
    }
  }
}
