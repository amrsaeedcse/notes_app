import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/helpers/theme/app_colors.dart';
import 'package:note_app/helpers/widgets/custom_app_bar.dart';
import 'package:note_app/helpers/widgets/custom_text.dart';
import 'package:note_app/models/note_model.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key, required this.noteModel});
  final NoteModel noteModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        suf: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditNoteScreen(noteModel: noteModel),
              ),
            );
          },
          child: Icon(Icons.edit, color: AppColors.textPrimary),
        ),
        pre: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: AppColors.textPrimary),
        ),
        center: CustomText(
          data: "Note details",
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: AppColors.backGroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            CustomText(
              data: noteModel.noteTitle,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 12),
            CustomText(
              data: noteModel.noteDisc,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(height: 12),
            CustomText(
              data:
                  "Created At ${DateFormat('dd/MM/yyyy HH:mm').format(noteModel.time.toDate())}",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textSec,
            ),
          ],
        ),
      ),
    );
  }
}

class EditNoteScreen extends StatefulWidget {
  final NoteModel noteModel;
  const EditNoteScreen({super.key, required this.noteModel});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController titleController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.noteModel.noteTitle);
    descController = TextEditingController(text: widget.noteModel.noteDisc);
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        pre: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: AppColors.textPrimary),
        ),
        center: CustomText(
          data: "Edit Note",
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: AppColors.backGroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: "Description"),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 🔹 هنا هتحط كود الـ update Firestore أو Cubit
                // widget.noteModel.noteTitle = titleController.text;
                // widget.noteModel.noteDisc = descController.text;
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
