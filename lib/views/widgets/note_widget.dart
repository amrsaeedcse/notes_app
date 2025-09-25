import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/controllers/delete_note/delete_note_cubit.dart';
import 'package:note_app/controllers/get_notes_cubit/get_notes_cubit.dart';
import 'package:note_app/helpers/widgets/custom_text.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/views/screens/note_screen.dart';

import '../../helpers/theme/app_colors.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key, required this.noteModel});

  final NoteModel noteModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteNoteCubit, DeleteNoteState>(
      listener: (context, state) {
        if (state is DeleteNoteSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: CustomText(
                  data: "Note deleted",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              backgroundColor: AppColors.buttonBackGround,
            ),
          );
          context.read<GetNotesCubit>().deleteLocal(noteModel);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => NoteScreen(noteModel: noteModel),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        data: noteModel.noteTitle,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        data: noteModel.noteDisc,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      context.read<DeleteNoteCubit>().deleteNote(noteModel);
                    },
                    child: Icon(Icons.delete, color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),

            // Overlay Blur + Indicator
            if (state is DeleteNoteLoading)
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.black.withOpacity(0.1),
                    child: const Center(child: CupertinoActivityIndicator()),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
