import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rock_paper_scissors/main.dart';
import 'package:rock_paper_scissors/screens/Agree_play_screen.dart';
import 'package:rock_paper_scissors/screens/Ads_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstPlayerFinish extends StatefulWidget {
  const FirstPlayerFinish({super.key});

  @override
  State<FirstPlayerFinish> createState() => _FirstPlayerFinishState();
}

String setScore = "";
bool win = false;
bool lose = false;
bool draw = false;
bool finishAll = false;
bool adsLose = false;
bool menu = false;

String? collectionRoom;
String? docRoom;

Stream<QuerySnapshot>? gameNow;

CollectionReference? gameNow1;

class _FirstPlayerFinishState extends State<FirstPlayerFinish> {
  @override
  void initState() {
    super.initState();
    getWeatherForecast();
    getRoomOption();
  }

  getRoomOption() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() async {
      setScore = "";

      collectionRoom = prefs.getString("NameCreate")!;
      docRoom = prefs.getString("PasswordCreate")!;

      gameNow =
          FirebaseFirestore.instance.collection(collectionRoom!).snapshots();

      gameNow1 = FirebaseFirestore.instance.collection(collectionRoom!);
    });
  }

  Future<void> getWeatherForecast() {
    return Future.delayed(
        const Duration(milliseconds: 350), () => setHelpStart());
  }

  setHelpStart() {
    setState(() {});
  }

  Widget outlinedButtonAgainFinish() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 53,
        child: OutlinedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ))),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();

            prefs.setString("WhatPlayer", "none");
            prefs.setString("NameCreate", "none");
            prefs.setString("PasswordCreate", "none");

            Future<void> deleteRoom() {
              return gameNow1!.doc(docRoom).delete();
            }

            setMenuFalse() async {
              final prefs = await SharedPreferences.getInstance();

              await prefs.setBool("ToMenu", false);
            }

            await deleteRoom();
            setMenuFalse();

            win = false;
            draw = false;
            lose = false;
            setScore = "";
            if (adsLose == true) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => AdsScreen()),
                  (Route<dynamic> route) => false);
            } else {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      duration: Duration(seconds: 1),
                      child: AmberBackGroundRoomCreate()));
            }
          },
          child: const Text(
            "Again",
            style: TextStyle(
              color: Color.fromARGB(255, 162, 0, 255),
              fontSize: 19,
            ),
          ),
        ),
      ),
    );
  }

  Widget outlinedButtonAgain() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 53,
        child: OutlinedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ))),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();

            prefs.setString("WhatPlayer", "none");
            prefs.setString("NameCreate", "none");
            prefs.setString("PasswordCreate", "none");

            Future<void> setFinishLobby() {
              return FirebaseFirestore.instance
                  .collection(collectionRoom!)
                  .doc(docRoom!)
                  .set(
                {
                  "player1_Lobby": true,
                },
                SetOptions(merge: true),
              );
            }

            setMenuFalse() async {
              final prefs = await SharedPreferences.getInstance();

              await prefs.setBool("ToMenu", false);
            }

            setFinishLobby();
            setMenuFalse();

            win = false;
            draw = false;
            lose = false;
            setScore = "";
            if (adsLose == true) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => AdsScreen()),
                  (Route<dynamic> route) => false);
            } else {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      duration: Duration(seconds: 1),
                      child: AmberBackGroundRoomCreate()));
            }
          },
          child: const Text(
            "Again",
            style: TextStyle(
              color: Color.fromARGB(255, 162, 0, 255),
              fontSize: 19,
            ),
          ),
        ),
      ),
    );
  }

  Widget outlinedButtonMenuFinish() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 53,
        child: OutlinedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ))),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();

            prefs.setString("WhatPlayer", "none");
            prefs.setString("NameCreate", "none");
            prefs.setString("PasswordCreate", "none");

            Future<void> deleteRoom() {
              return gameNow1!.doc(docRoom).delete();
            }

            setMenuTrue() async {
              final prefs = await SharedPreferences.getInstance();

              await prefs.setBool("ToMenu", true);
            }

            await deleteRoom();
            setMenuTrue();

            win = false;
            draw = false;
            lose = false;
            setScore = "";
            if (adsLose == true) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => AdsScreen()),
                  (Route<dynamic> route) => false);
            } else {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      duration: Duration(seconds: 1),
                      child: AmberBackGroundHome()));
            }
          },
          child: const Text(
            "Menu",
            style: TextStyle(
              color: Color.fromARGB(255, 162, 0, 255),
              fontSize: 19,
            ),
          ),
        ),
      ),
    );
  }

  Widget outlinedButtonMenu() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 53,
        child: OutlinedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ))),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();

            prefs.setString("WhatPlayer", "none");
            prefs.setString("NameCreate", "none");
            prefs.setString("PasswordCreate", "none");

            Future<void> setFinishLobby() {
              return FirebaseFirestore.instance
                  .collection(collectionRoom!)
                  .doc(docRoom!)
                  .set(
                {
                  "player1_Lobby": true,
                },
                SetOptions(merge: true),
              );
            }

            setMenuTrue() async {
              final prefs = await SharedPreferences.getInstance();

              await prefs.setBool("ToMenu", true);
            }

            setFinishLobby();
            setMenuTrue();

            win = false;
            draw = false;
            lose = false;
            setScore = "";
            if (adsLose == true) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => AdsScreen()),
                  (Route<dynamic> route) => false);
            } else {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      duration: Duration(seconds: 1),
                      child: AmberBackGroundHome()));
            }
          },
          child: const Text(
            "Menu",
            style: TextStyle(
              color: Color.fromARGB(255, 162, 0, 255),
              fontSize: 19,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
          centerTitle: true,
          title: (lose
              ? Text(
                  setScore,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 17, 0),
                      fontFamily: "Marker",
                      fontSize: 25),
                )
              : (win
                  ? Text(
                      setScore,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 32, 206, 38),
                          fontFamily: "Marker",
                          fontSize: 25),
                    )
                  : (draw
                      ? Text(
                          setScore,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontFamily: "Marker",
                              fontSize: 25),
                        )
                      : null)))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: gameNow,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong...",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 17, 0),
                          fontSize: 30,
                        ));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text(
                      "Loading...",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 30,
                        fontFamily: "Abril",
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.none) {
                    return const Text(
                      "No internet connection",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 30,
                      ),
                    );
                  }

                  final data = snapshot.requireData;

                  final p1_r = data.docs[0]["player1_Rock"];
                  final p1_s = data.docs[0]["player1_Scissors"];
                  final p1_p = data.docs[0]["player1_Paper"];

                  final p2_r = data.docs[0]["player2_Rock"];
                  final p2_s = data.docs[0]["player2_Scissors"];
                  final p2_p = data.docs[0]["player2_Paper"];

                  // checks
                  if ((p1_p && p2_p) || (p1_r && p2_r) || (p1_s && p2_s)) {
                    adsLose = false;
                    draw = true;
                    setScore = "~~~~~~ Draw ~~~~~~";
                    getWeatherForecast();
                    return const Text(
                      "🎲Draw🎲",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else if ((p1_r && p2_s) ||
                      (p1_s && p2_p) ||
                      (p1_p && p2_r)) {
                    adsLose = false;
                    win = true;
                    setScore = "~~~~~~ You win ~~~~~~";
                    getWeatherForecast();
                    return const Text(
                      "💸You win💸",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else if ((p1_r && p2_p) ||
                      (p1_s && p2_r) ||
                      (p1_p && p2_s)) {
                    adsLose = true;
                    lose = true;
                    setScore = "~~~~~~ You lose ~~~~~~";
                    getWeatherForecast();
                    return const Text(
                      "⛔You lose⛔",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }

                  //return wait time
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: (data.docs[0]["player2_Finish"]
                        ? const Text("")
                        : const Text(
                            "Wait your opponent",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                  );
                }),

            // buttons finish
            StreamBuilder<QuerySnapshot>(
                stream: gameNow,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong...",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 17, 0),
                          fontSize: 30,
                        ));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text(
                      "Loading...",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 30,
                        fontFamily: "Abril",
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.none) {
                    return const Text(
                      "No internet connection",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 30,
                      ),
                    );
                  }

                  final data = snapshot.requireData;

                  finishAll = data.docs[0]["player2_Lobby"];

                  //return wait time
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          (finishAll)
                              ? outlinedButtonAgainFinish()
                              : outlinedButtonAgain(),
                          (finishAll)
                              ? outlinedButtonMenuFinish()
                              : outlinedButtonMenu(),
                        ],
                      ));
                }),
          ],
        ),
      ),
    );
  }
}
