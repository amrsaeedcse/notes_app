import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/controllers/add_note_cubit/add_note_cubit.dart';
import 'package:note_app/controllers/delete_note/delete_note_cubit.dart';
import 'package:note_app/controllers/get_notes_cubit/get_notes_cubit.dart';
import 'package:note_app/views/screens/create_note_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddNoteCubit()),
        BlocProvider(create: (context) => GetNotesCubit()),
        BlocProvider(create: (context) => DeleteNoteCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CreateNoteScreen(),
      ),
    );
  }
}
