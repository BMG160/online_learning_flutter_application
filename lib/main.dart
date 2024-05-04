import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myanmar_educational/pages/login_page.dart';
import 'package:myanmar_educational/pages/teacher_home_page.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) => const LoginPage(),
        '/teacher_home' : (BuildContext context) => const TeacherHomePage(teacher: null),
      },
      home: const LoginPage(),
    );
  }
}

