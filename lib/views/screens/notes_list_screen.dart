import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/controllers/get_notes_cubit/get_notes_cubit.dart';
import 'package:note_app/helpers/theme/app_colors.dart';
import 'package:note_app/helpers/widgets/custom_app_bar.dart';
import 'package:note_app/helpers/widgets/custom_text.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/views/widgets/note_widget.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<GetNotesCubit>().getNotes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        center: CustomText(
          data: "Notes list",
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: AppColors.backGroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<GetNotesCubit, GetNotesState>(
          listener: (context, state) {
            if (state is GetNotesFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Center(
                    child: CustomText(
                      data: state.error,
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
            if (state is GetNotesLoading || state is GetNotesFailure) {
              return Center(child: CupertinoActivityIndicator());
            }
            if (state is GetNotesInitial) {
              return Center(
                child: CustomText(
                  data: "No Notes",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              );
            }
            List<NoteModel> notes = (state as GetNotesSuccess).notes;
            return notes.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (context, index) {
                      return NoteWidget(noteModel: state.notes[index]);
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                    itemCount: state.notes.length,
                  )
                : Center(
                    child: CustomText(
                      data: "No Notes",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
