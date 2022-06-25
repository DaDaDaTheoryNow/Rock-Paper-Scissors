import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rock_paper_scissors/screens/Agree_play_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rock_paper_scissors/screens/Rules_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    super.initState();

    internetConnectCheck();
  }

  internetConnectCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      Fluttertoast.showToast(
          msg: "You are connected to Mobile internet",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (connectivityResult == ConnectivityResult.wifi) {
      Fluttertoast.showToast(
          msg: "You are connected to Wifi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg:
              "For the normal functioning of the game, you need the presence of the Internet! Please, on it",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 10,
                    right: MediaQuery.of(context).size.width / 100,
                    top: MediaQuery.of(context).size.width / 1.1,
                  ),
                  child: SizedBox(
                    height: 75,
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ))),
                      onPressed: () async {
                        var connectivityResult =
                            await (Connectivity().checkConnectivity());

                        if (connectivityResult == ConnectivityResult.mobile ||
                            connectivityResult == ConnectivityResult.wifi) {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.leftToRightWithFade,
                                  duration: const Duration(milliseconds: 500),
                                  child: const AgreePlayScreen()));
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
                      child: const Text("Play"),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 20,
                    right: MediaQuery.of(context).size.width / 20,
                    top: MediaQuery.of(context).size.width / 3,
                  ),
                  child: SizedBox(
                    height: 75,
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ))),
                      onPressed: () async {
                        var connectivityResult =
                            await (Connectivity().checkConnectivity());

                        if (connectivityResult == ConnectivityResult.mobile ||
                            connectivityResult == ConnectivityResult.wifi) {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeftWithFade,
                                  duration: const Duration(milliseconds: 500),
                                  child: const RulesScreen()));
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
                      child: const Text("Rules"),
                    ),
                  )),
            ],
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.width / 1.7),
            child: const Text(
              "by Смирнов Владислав - @dadada.dart",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
