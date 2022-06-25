import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rock_paper_scissors/screens/Agree_play_screen.dart';
import 'package:rock_paper_scissors/screens/players_actions/Players_start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomCreateOrJoinScreen extends StatefulWidget {
  const RoomCreateOrJoinScreen({super.key});

  @override
  State<RoomCreateOrJoinScreen> createState() => _RoomCreateOrJoinScreenState();
}

TextEditingController _nameJoinController = TextEditingController();
TextEditingController _passwordJoinController = TextEditingController();
String? _nameJoin;
String? _passwordJoin;

TextEditingController _nameCreateController = TextEditingController();
TextEditingController _passwordCreateController = TextEditingController();
String? _nameCreate;
String? _passwordCreate;

bool showJoin = true;
String createOrJoin = "🚪Join🚪";
bool trueJoin = true;
bool agreeStart = false;

class _RoomCreateOrJoinScreenState extends State<RoomCreateOrJoinScreen> {
  Future getWeatherForecast() {
    return Future.delayed(
        const Duration(milliseconds: 350), () => setStateHelp());
  }

  setStateHelp() {
    setState(() {});
  }

  saveCreateRoom() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString("NameCreate", _nameCreate!);
    prefs.setString("PasswordCreate", _passwordCreate!);
    prefs.setString("WhatPlayer", "create");
  }

  saveJoinRoom() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString("NameJoin", _nameJoin!);
    prefs.setString("PasswordJoin", _passwordJoin!);
    prefs.setString("WhatPlayer", "join");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          createOrJoin,
          style: const TextStyle(
            fontSize: 31,
          ),
        ),
        actions: [
          SizedBox(
            width: 100,
            child: OutlinedButton(
              onLongPress: () {
                Fluttertoast.showToast(
                    msg: "TikTok: @dadada.dart",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              onPressed: () {
                _nameCreateController.clear();
                _passwordCreateController.clear();

                _nameJoinController.clear();
                _passwordJoinController.clear();

                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(seconds: 1),
                        child: const AmberBackGroundHome()));
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Go to menu",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (showJoin
              ? Column(
                  children: [
                    const Text(
                      "~~~ Name ~~~",
                      style: TextStyle(
                        fontSize: 31,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Marker",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: TextField(
                        obscureText: false,
                        controller: _nameJoinController,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "Write your name from room, please!",
                          border: InputBorder.none,
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 3)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white54, width: 2)),
                          prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: IconTheme(
                                data: const IconThemeData(color: Colors.white),
                                child: Icon(
                                  Icons.near_me,
                                  size: 25,
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 2),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(
                        "~~~ Password ~~~",
                        style: TextStyle(
                          fontSize: 31,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Marker",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 35),
                      child: TextField(
                        obscureText: false,
                        controller: _passwordJoinController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        toolbarOptions: const ToolbarOptions(
                            paste: false, selectAll: true, cut: false),
                        decoration: InputDecoration(
                          hintText: "Write your password from room, please!",
                          border: InputBorder.none,
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 3)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white54, width: 2)),
                          prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: IconTheme(
                                data: const IconThemeData(color: Colors.white),
                                child: Icon(
                                  Icons.key_outlined,
                                  size: 25,
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 2),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 55,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: ElevatedButton(
                          onPressed: () async {
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());

                            _nameJoin = _nameJoinController.text;
                            _passwordJoin = _passwordJoinController.text;

                            if (connectivityResult == ConnectivityResult.wifi ||
                                connectivityResult ==
                                    ConnectivityResult.mobile) {
                              if (agreeStart == false) {
                                setState(() {
                                  agreeStart = true;
                                });
                              } else {
                                _nameCreateController.clear();
                                _passwordCreateController.clear();

                                _nameJoinController.clear();
                                _passwordJoinController.clear();

                                saveJoinRoom();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PlayersStart()),
                                    (Route<dynamic> route) => false);
                              }
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
                                      borderRadius:
                                          BorderRadius.circular(18.0)))),
                          child: (agreeStart
                              ? const Text("Are you sure the data is correct?")
                              : const Text("Join to room")),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    const Text(
                      "~~~ Name ~~~",
                      style: TextStyle(
                        fontSize: 31,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Marker",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: TextField(
                        obscureText: false,
                        controller: _nameCreateController,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "Write your name from room, please!",
                          border: InputBorder.none,
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 3)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white54, width: 2)),
                          prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: IconTheme(
                                data: const IconThemeData(color: Colors.white),
                                child: Icon(
                                  Icons.near_me,
                                  size: 25,
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 2),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(
                        "~~~ Password ~~~",
                        style: TextStyle(
                          fontSize: 31,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Marker",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 35),
                      child: TextField(
                        obscureText: true,
                        controller: _passwordCreateController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        toolbarOptions: const ToolbarOptions(
                            paste: false, selectAll: true, cut: false),
                        decoration: InputDecoration(
                          hintText: "Write your password from room, please!",
                          border: InputBorder.none,
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 3)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white54, width: 2)),
                          prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: IconTheme(
                                data: const IconThemeData(color: Colors.white),
                                child: Icon(
                                  Icons.key_outlined,
                                  size: 25,
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 2),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 55,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: ElevatedButton(
                          onPressed: () async {
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());

                            _nameCreate = _nameCreateController.text;
                            _passwordCreate = _passwordCreateController.text;

                            CollectionReference users = FirebaseFirestore
                                .instance
                                .collection(_nameCreate!);

                            Future<void> createRoomFire() {
                              return users.doc(_passwordCreate).set({
                                "player1_Finish": false,
                                "player1_Rock": false,
                                "player1_Paper": false,
                                "player1_Scissors": false,
                                "player2_Finish": false,
                                "player2_Rock": false,
                                "player2_Paper": false,
                                "player2_Scissors": false,
                                "player1_Start": false,
                                "player2_Start": false,
                                "player1_Lobby": false,
                                "player2_Lobby": false,
                                "nameRoom": _nameCreate
                              }).catchError((error) {
                                Fluttertoast.showToast(
                                    msg: "$error",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                trueJoin = false;

                                Future.delayed(const Duration(milliseconds: 50),
                                    () => trueJoin = true);
                              });
                            }

                            if (connectivityResult == ConnectivityResult.wifi ||
                                connectivityResult ==
                                    ConnectivityResult.mobile) {
                              if (trueJoin == true) {
                                saveCreateRoom();
                                createRoomFire();

                                _nameCreateController.clear();
                                _passwordCreateController.clear();

                                _nameJoinController.clear();
                                _passwordJoinController.clear();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PlayersStart()),
                                    (Route<dynamic> route) => false);
                              }
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
                                      borderRadius:
                                          BorderRadius.circular(18.0)))),
                          child: const Text("Create room"),
                        ),
                      ),
                    ),
                  ],
                )),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: (showJoin
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        onPressed: () {
                          setState(() {
                            showJoin = false;
                            createOrJoin = "🚪Create🚪";
                          });
                        },
                        child: const Text(
                          "I want create my room",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        onPressed: () {
                          setState(() {
                            showJoin = true;
                            agreeStart = false;
                            createOrJoin = "🚪Join🚪";
                          });
                        },
                        child: const Text(
                          "I want join to the room",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  )),
          ),
        ],
      ),
    );
  }
}
