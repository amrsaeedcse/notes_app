import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app/models/note_model.dart';

class FireBaseFireStore {
  final fireStore = FirebaseFirestore.instance;

  Future<void> addEditNote(NoteModel note) async {
    await fireStore
        .collection("notes")
        .doc(note.noteTitle)
        .set(note.toJson(), SetOptions(merge: true));
  }

  Future<void> deleteNote(NoteModel note) async {
    await fireStore.collection("notes").doc(note.noteTitle).delete();
  }

  Future<List<NoteModel>> getNotes() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireStore
        .collection("notes")
        .get();
    List<NoteModel> notes = querySnapshot.docs.map((e) {
      return NoteModel.fromJson(e.data());
    }).toList();
    return notes;
  }
}
