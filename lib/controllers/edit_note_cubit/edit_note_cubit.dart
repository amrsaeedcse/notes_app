import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:note_app/fire_base/fire_store/fire_base_fire_store.dart';
import 'package:note_app/models/note_model.dart';

part 'edit_note_state.dart';

class EditNoteCubit extends Cubit<EditNoteState> {
  EditNoteCubit() : super(EditNoteInitial());
  FireBaseFireStore fireStore = FireBaseFireStore();

  Future<void> editModel(NoteModel note) async {
    try {
      emit(EditNoteLoading());
      fireStore.addEditNote(note);
      emit(EditNoteSuccess());
    } catch (e) {
      emit(EditNoteFailure(error: "error"));
    }
  }
}
