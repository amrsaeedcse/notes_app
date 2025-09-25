import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/controllers/add_note_cubit/add_note_cubit.dart';
import 'package:note_app/helpers/theme/app_colors.dart';
import 'package:note_app/helpers/widgets/custom_app_bar.dart';
import 'package:note_app/helpers/widgets/custom_button.dart';
import 'package:note_app/helpers/widgets/custom_text.dart';
import 'package:note_app/helpers/widgets/custom_text_field.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/views/screens/notes_list_screen.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final TextEditingController noteTitle = TextEditingController();

  final TextEditingController noteDisc = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: CustomAppBar(
        center: CustomText(
          data: "Create Note",
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              CustomText(
                data: "Note Title",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 8),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextField(
                      textEditingController: noteTitle,
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
                      textEditingController: noteDisc,
                      hint: "Enter Note Disc",
                      height: 144,
                    ),
                  ],
                ),
              ),
              Spacer(),
              BlocConsumer<AddNoteCubit, AddNoteState>(
                listener: (context, state) {
                  if (state is AddNoteSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(
                          child: CustomText(
                            data: "Note Added",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        backgroundColor: AppColors.buttonBackGround,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AddNoteCubit>().addNote(
                          NoteModel(
                            time: Timestamp.now(),
                            noteTitle: noteDisc.text.trim(),
                            noteDisc: noteTitle.text.trim(),
                          ),
                        );
                      }
                    },
                    centerWidget: state is! AddNoteLoading
                        ? CustomText(
                            data: "Save",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          )
                        : CupertinoActivityIndicator(),
                    backGroundColor: AppColors.textSec,
                  );
                },
              ),
              SizedBox(height: 24),
              CustomButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => NotesListScreen()),
                  );
                },
                centerWidget: CustomText(
                  data: "View Notes",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                backGroundColor: AppColors.backGroundColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
