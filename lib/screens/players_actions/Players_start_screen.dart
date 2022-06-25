import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rock_paper_scissors/screens/Agree_play_screen.dart';
import 'package:rock_paper_scissors/screens/players_actions/Player1_action_screen.dart';
import 'package:rock_paper_scissors/screens/players_actions/Player2_action_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayersStart extends StatefulWidget {
  const PlayersStart({super.key});

  @override
  State<PlayersStart> createState() => _PlayersStartState();
}

String? collectionRoom;
String? docRoom;
String? whatPlayer;

class _PlayersStartState extends State<PlayersStart> {
  @override
  void initState() {
    super.initState();
    getRoomOption();
  }

  getRoomOption() async {
    final prefs = await SharedPreferences.getInstance();
    whatPlayer = prefs.getString("WhatPlayer")!;

    setState(() {
      if (whatPlayer == "create") {
        collectionRoom = prefs.getString("NameCreate")!;
        docRoom = prefs.getString("PasswordCreate")!;
      } else {
        collectionRoom = prefs.getString("NameJoin")!;
        docRoom = prefs.getString("PasswordJoin")!;
      }
    });
  }

  Widget notStartButtonPlayer1() {
    return SizedBox(
      height: 55,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: ElevatedButton(
          onPressed: () {
            CollectionReference users =
                FirebaseFirestore.instance.collection(collectionRoom!);

            Future<void> addStart() {
              return users
                  .doc(docRoom)
                  .set({'player1_Start': true}, SetOptions(merge: true));
            }

            addStart();
          },
          child: const Text("Ready"),
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)))),
        ),
      ),
    );
  }

  Widget startButtonPlayer1() {
    return SizedBox(
      height: 55,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: ElevatedButton(
          onPressed: () {
            CollectionReference users =
                FirebaseFirestore.instance.collection(collectionRoom!);

            Future<void> addStart() {
              return users
                  .doc(docRoom)
                  .set({'player1_Start': false}, SetOptions(merge: true));
            }

            addStart();
          },
          child: const Text("✓Ready✓"),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)))),
        ),
      ),
    );
  }

  Widget notStartButtonPlayer2() {
    return SizedBox(
      height: 55,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: ElevatedButton(
          onPressed: () {
            CollectionReference users =
                FirebaseFirestore.instance.collection(collectionRoom!);

            Future<void> addStart() {
              return users
                  .doc(docRoom)
                  .set({'player2_Start': true}, SetOptions(merge: true));
            }

            addStart();
          },
          child: const Text("Ready"),
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)))),
        ),
      ),
    );
  }

  Widget startButtonPlayer2() {
    return SizedBox(
      height: 55,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: ElevatedButton(
          onPressed: () {
            CollectionReference users =
                FirebaseFirestore.instance.collection(collectionRoom!);

            Future<void> addStart() {
              return users
                  .doc(docRoom)
                  .set({'player2_Start': false}, SetOptions(merge: true));
            }

            addStart();
          },
          child: const Text("✓Ready✓"),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)))),
        ),
      ),
    );
  }

  firstPlayerTurn() async {
    return Fluttertoast.showToast(
            msg: "Ready Steady Go!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0)
        .then((value) => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const FirstPlayerTurn()),
            (Route<dynamic> route) => false));
  }

  secondPlayerTurn() async {
    return Fluttertoast.showToast(
            msg: "Ready Steady Go!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0)
        .then((value) => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const SecondPlayerTurn()),
            (Route<dynamic> route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        centerTitle: true,
        title: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection(collectionRoom!)
                .doc(docRoom)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                Fluttertoast.showToast(
                    msg: "Your data is not correct",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);

                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(seconds: 650),
                        child: AmberBackGroundRoomCreate()));
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                Fluttertoast.showToast(
                    msg: "Your data is not correct",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);

                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(seconds: 650),
                        child: AmberBackGroundRoomCreate()));
              }

              if (snapshot.connectionState == ConnectionState.done) {
                final data = snapshot.requireData;

                return RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "Room name: ",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(
                      text: data["nameRoom"],
                      style: const TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 255, 17, 0),
                        fontFamily: "Abril",
                        fontWeight: FontWeight.bold,
                      )),
                ]));
              }

              return const Text("Loading...",
                  style: TextStyle(
                    fontSize: 29,
                    color: Color.fromARGB(255, 255, 17, 0),
                    fontFamily: "Abril",
                    fontWeight: FontWeight.bold,
                  ));
            }),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Click to get ready",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 31,
            ),
          ),

          // ready stady go button
          if (whatPlayer == "join") ...[
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(collectionRoom!)
                    .snapshots(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong...",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 17, 0),
                          fontSize: 30,
                          fontFamily: "Marker",
                        ));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text(
                      "Loading...",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 17, 0),
                        fontSize: 30,
                        fontFamily: "Marker",
                      ),
                    );
                  }

                  final data = snapshot.requireData;

                  return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: (data.docs[0]["player2_Start"]
                          ? startButtonPlayer2()
                          : notStartButtonPlayer2()));
                }),
          ] else if (whatPlayer == "create") ...[
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(collectionRoom!)
                    .snapshots(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong...",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 17, 0),
                          fontSize: 30,
                          fontFamily: "Marker",
                        ));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text(
                      "Loading...",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 17, 0),
                        fontSize: 30,
                        fontFamily: "Marker",
                      ),
                    );
                  }

                  final data = snapshot.requireData;

                  return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: (data.docs[0]["player1_Start"]
                          ? startButtonPlayer1()
                          : notStartButtonPlayer1()));
                }),
          ],

          // wait opponent
          if (whatPlayer == "create") ...[
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(collectionRoom!)
                    .snapshots(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong...",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 17, 0),
                          fontSize: 30,
                          fontFamily: "Marker",
                        ));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Text(
                        "Loading...",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 17, 0),
                          fontSize: 30,
                          fontFamily: "Marker",
                        ),
                      ),
                    );
                  }

                  final data = snapshot.requireData;
                  var youReady = "";
                  var opponentReady = "";

                  if (data.docs[0]["player1_Start"] == true) {
                    youReady = "ready";
                  } else {
                    youReady = "not ready";
                  }

                  if (data.docs[0]["player2_Start"] == true) {
                    opponentReady = "ready";
                  } else {
                    opponentReady = "not ready";
                  }

                  return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Card(
                            child: Text("You: $youReady"),
                          ),
                          Card(
                            child: Text("Opponent: $opponentReady"),
                          ),
                          if (data.docs[0]["player1_Start"] &&
                              data.docs[0]["player2_Start"]) ...[
                            firstPlayerTurn()
                          ]
                        ],
                      ));
                }),
          ] else if (whatPlayer == "join") ...[
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(collectionRoom!)
                    .snapshots(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong...",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 17, 0),
                          fontSize: 30,
                          fontFamily: "Marker",
                        ));
                  }
                  

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Text(
                        "Loading...",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 17, 0),
                          fontSize: 30,
                          fontFamily: "Marker",
                        ),
                      ),
                    );
                  }

                  final data = snapshot.requireData;
                  var youReady = "";
                  var opponentReady = "";

                  if (data.docs[0]["player2_Start"] == true) {
                    youReady = "ready";
                  } else {
                    youReady = "not ready";
                  }

                  if (data.docs[0]["player1_Start"] == true) {
                    opponentReady = "ready";
                  } else {
                    opponentReady = "not ready";
                  }

                  return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Card(
                            child: Text("You: $youReady"),
                          ),
                          Card(
                            child: Text("Opponent: $opponentReady"),
                          ),
                          if (data.docs[0]["player1_Start"] &&
                              data.docs[0]["player2_Start"] &&
                              whatPlayer == "create") ...[
                            firstPlayerTurn()
                          ] else if (data.docs[0]["player1_Start"] == true &&
                              data.docs[0]["player2_Start"] == true &&
                              whatPlayer == "join") ...[
                            secondPlayerTurn()
                          ]
                        ],
                      ));
                }),
          ]
        ],
      ),
    );
  }
}
