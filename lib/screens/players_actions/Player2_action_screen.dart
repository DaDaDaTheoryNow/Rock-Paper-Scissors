import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rock_paper_scissors/screens/players_actions/Player2_finish_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondPlayerTurn extends StatefulWidget {
  const SecondPlayerTurn({super.key});

  @override
  State<SecondPlayerTurn> createState() => _SecondPlayerTurnState();
}

bool setButton = false;
String selectNow = "none";

String? collectionRoom;
String? docRoom;

class _SecondPlayerTurnState extends State<SecondPlayerTurn> {
  @override
  void initState() {
    super.initState();
    getRoomOption();
  }

  getRoomOption() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      collectionRoom = prefs.getString("NameJoin")!;
      docRoom = prefs.getString("PasswordJoin")!;
    });
  }

  Future<void> setAction(String setWhat, bool forWhat, String setWhatClear1,
      bool forWhatClear1, String setWhatClear2, bool forWhatClear2) {
    return FirebaseFirestore.instance
        .collection(collectionRoom!)
        .doc(docRoom!)
        .set({
      setWhat: forWhat,
      setWhatClear1: forWhatClear1,
      setWhatClear2: forWhatClear2,
    }, SetOptions(merge: true));
  }

  Future<void> setFinsih() {
    return FirebaseFirestore.instance
        .collection(collectionRoom!)
        .doc(docRoom!)
        .set({
      "player2_Finish": true,
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
            text: TextSpan(children: [
          const TextSpan(
              text: "You choosed: ",
              style: TextStyle(
                fontSize: 25,
              )),
          TextSpan(
              text: "'$selectNow' ",
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 17, 0),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              )),
          const TextSpan(
              text: "- player 2",
              style: TextStyle(
                fontSize: 25,
              )),
        ])),
      ),
      backgroundColor: Colors.amberAccent,
      body: Center(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50, bottom: 80),
              child: GestureDetector(
                child: Image.asset("assets/kamen.jpg"),
                onTap: () async {
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.mobile ||
                      connectivityResult == ConnectivityResult.wifi) {
                    Fluttertoast.showToast(
                        msg: "You choosed 'Scissors'",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    setState(() {
                      selectNow = "Rock";
                      setButton = true;
                    });
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please, turn on the internet",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 180),
                  child: (setButton
                      ? SizedBox(
                          width: 120,
                          child: ElevatedButton(
                            onPressed: () async {
                              var connectivityResult =
                                  await (Connectivity().checkConnectivity());

                              if (connectivityResult ==
                                      ConnectivityResult.mobile ||
                                  connectivityResult ==
                                      ConnectivityResult.wifi) {
                                if (selectNow == "Scissors") {
                                  setAction(
                                      "player2_Scissors",
                                      true,
                                      "player2_Paper",
                                      false,
                                      "player2_Rock",
                                      false);
                                }

                                if (selectNow == "Paper") {
                                  setAction(
                                      "player2_Paper",
                                      true,
                                      "player2_Rock",
                                      false,
                                      "player2_Scissors",
                                      false);
                                }

                                if (selectNow == "Rock") {
                                  setAction(
                                      "player2_Rock",
                                      true,
                                      "player2_Paper",
                                      false,
                                      "player2_Scissors",
                                      false);
                                }

                                setFinsih();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SecondPlayerFinish()),
                                    (Route<dynamic> route) => false);
                                selectNow = "none";
                                setButton = false;
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please, turn on the internet",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                            ),
                            child: const Text("✓Go next✓"),
                          ),
                        )
                      : SizedBox(
                          width: 120,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.grey)),
                              onPressed: () {
                                Fluttertoast.showToast(
                                    msg: "You need to choose something",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                              child: const Text("Go next")),
                        )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 50),
                  child: GestureDetector(
                    child: Image.asset("assets/nochn.jpg"),
                    onTap: () async {
                      var connectivityResult =
                          await (Connectivity().checkConnectivity());
                      if (connectivityResult == ConnectivityResult.mobile ||
                          connectivityResult == ConnectivityResult.wifi) {
                        Fluttertoast.showToast(
                            msg: "You choosed 'Scissors'",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        setState(() {
                          selectNow = "Scissors";
                          setButton = true;
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please, turn on the internet",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 80),
              child: GestureDetector(
                child: Image.asset("assets/bumaga.jpg"),
                onTap: () async {
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.mobile ||
                      connectivityResult == ConnectivityResult.wifi) {
                    Fluttertoast.showToast(
                        msg: "You choosed 'Paper'",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    setState(() {
                      selectNow = "Paper";
                      setButton = true;
                    });
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please, turn on the internet",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
