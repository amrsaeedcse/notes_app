import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String id;
  String noteTitle;
  String noteDisc;
  final Timestamp time;

  NoteModel({
    required this.id,
    required this.time,
    required this.noteTitle,
    required this.noteDisc,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json["id"],
      time: json["time"],
      noteTitle: json["title"],
      noteDisc: json["disc"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"title": noteTitle, "disc": noteDisc, "time": time, "id": id};
  }

  /// copyWith method
  NoteModel copyWith({
    String? id,
    String? noteTitle,
    String? noteDisc,
    Timestamp? time,
  }) {
    return NoteModel(
      id: id ?? this.id,
      time: time ?? this.time,
      noteTitle: noteTitle ?? this.noteTitle,
      noteDisc: noteDisc ?? this.noteDisc,
    );
  }
}
