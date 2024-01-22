import 'package:flutter/material.dart';
import 'package:my_project/app/auth/login.dart';
import 'package:my_project/app/auth/singup.dart';
import 'package:my_project/app/auth/success.dart';
import 'package:my_project/app/home.dart';
import 'package:my_project/notes/add.dart';
import 'package:my_project/notes/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedpref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpref = await SharedPreferences.getInstance();
  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Notes",
      debugShowCheckedModeBanner: false,
      initialRoute: sharedpref.getString("id") == null ? "/" : "home",
      routes: {
        "/": (context) => const LogIn(),
        "singup": (context) => const SingUp(),
        "home": (context) => const Home(),
        "success": (context) => const Success(),
        "add": (context) => const AddNotes(),
        "edit": (context) => const EditNotes(
              note: null,
            ),
      },
    );
  }
}
