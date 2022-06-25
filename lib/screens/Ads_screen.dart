import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rock_paper_scissors/screens/Agree_play_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdsScreen extends StatefulWidget {
  const AdsScreen({super.key});

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

Timer? _timer;
int _counter = 3;
bool menu = false;

class _AdsScreenState extends State<AdsScreen> {
  @override
  void initState() {
    super.initState();
    _startTimer();
    getRoomOption();
  }

  getRoomOption() async {
    final prefs = await SharedPreferences.getInstance();

    menu = prefs.getBool("ToMenu")!;
  }

  void _startTimer() {
    _counter = 3;
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  Widget _buildChild() {
    if (_counter > 0) {
      return Text(
        "$_counter",
        style: const TextStyle(
          color: Colors.red,
          fontSize: 45,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (_counter == 0) {
      return IconButton(
        onPressed: () {
          if (menu == false) {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(seconds: 1),
                    child: const AmberBackGroundRoomCreate()));
          } else if (menu == true) {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(seconds: 1),
                    child: const AmberBackGroundHome()));
          }
        },
        icon: const Icon(
          Icons.disabled_by_default_rounded,
          size: 55,
        ),
        color: Colors.red,
      );
    }
    return const Text("Failed load...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 350, top: 50),
              child: _buildChild(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 310),
              child: Column(
                children: const [
                  Text(
                    "Here can be your advertising: tg @dadada17",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
