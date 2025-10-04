import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_app/models/note_model.dart';

class FireBaseFireStore {
  final fireStore = FirebaseFirestore.instance;

  Future<void> addEditNote(NoteModel note, bool edit) async {
    if (!edit) {
      DocumentReference<Map<String, dynamic>> documentReference = fireStore
          .collection("notes")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("userNotes")
          .doc();
      NoteModel noteModel = note.copyWith(id: documentReference.id);

      await documentReference.set(noteModel.toJson());
    } else {
      await fireStore
          .collection("notes")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("userNotes")
          .doc(note.id)
          .set(note.toJson(), SetOptions(merge: true));
    }
  }

  Future<void> deleteNote(NoteModel note) async {
    await fireStore
        .collection("notes")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userNotes")
        .doc(note.id)
        .delete();
  }

  Future<List<NoteModel>> getNotes() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireStore
        .collection("notes")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userNotes")
        .get();
    List<NoteModel> notes = querySnapshot.docs.map((e) {
      return NoteModel.fromJson(e.data());
    }).toList();
    return notes;
  }
}
