import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:note_app/fire_base/fire_base_fire_store.dart';
import 'package:note_app/models/note_model.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteInitial());

  FireBaseFireStore fireStore = FireBaseFireStore();
  Future<void> addNote(NoteModel note) async {
    try {
      emit(AddNoteLoading());
      await fireStore.addEditNote(note, false);
      emit(AddNoteSuccess());
    } catch (e) {
      emit(AddNoteFailure(error: "error heppened"));
    }
  }
}
