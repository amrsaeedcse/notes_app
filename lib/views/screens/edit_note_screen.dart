import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/controllers/edit_note_cubit/edit_note_cubit.dart';
import 'package:note_app/controllers/get_notes_cubit/get_notes_cubit.dart';
import 'package:note_app/helpers/widgets/custom_button.dart';
import 'package:note_app/helpers/widgets/custom_text_field.dart';
import '../../helpers/theme/app_colors.dart';
import '../../helpers/widgets/custom_app_bar.dart';
import '../../helpers/widgets/custom_text.dart';
import '../../models/note_model.dart';

class EditNoteScreen extends StatefulWidget {
  final NoteModel noteModel;
  const EditNoteScreen({super.key, required this.noteModel});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController titleController;
  late TextEditingController descController;
  final GlobalKey<FormState> _formKey = GlobalKey();

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
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    textEditingController: titleController,
                    hint: "Enter Note title",
                    height: 56,
                  ),
                  SizedBox(height: 24),
                  CustomText(
                    data: "Content",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 8),
                  CustomTextField(
                    textEditingController: descController,
                    hint: "Enter Note Disc",
                    height: 144,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.noteModel.noteTitle = titleController.text;
                  widget.noteModel.noteDisc = descController.text;
                  context.read<EditNoteCubit>().editModel(widget.noteModel);
                  context.read<GetNotesCubit>().getNotes();
                  Navigator.pop(context);
                }
              },
              centerWidget: CustomText(
                data: "Save",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              backGroundColor: AppColors.buttonBackGround,
            ),
          ],
        ),
      ),
    );
  }
}
