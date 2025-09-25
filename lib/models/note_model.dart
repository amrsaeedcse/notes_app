import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String noteTitle;
  String noteDisc;
  final Timestamp time;

  NoteModel({
    required this.time,
    required this.noteTitle,
    required this.noteDisc,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      time: json["time"],
      noteTitle: json["title"],
      noteDisc: json["disc"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"title": noteTitle, "disc": noteDisc, "time": time};
  }
}
