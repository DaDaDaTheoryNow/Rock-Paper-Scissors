import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rock_paper_scissors/screens/Home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.amber,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          centerTitle: true,
          title: const Text("Rock Paper Scissors"),
        ),
        body: const HomeScreen(),
      ),
    );
  }
}
