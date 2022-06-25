import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RulesScreen extends StatefulWidget {
  const RulesScreen({super.key});

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

final TextEditingController _keyController = TextEditingController();

String key = "";

CollectionReference GameNow1 =
    FirebaseFirestore.instance.collection('GameNow1');

class _RulesScreenState extends State<RulesScreen> {
  Text setFalseAll() {
    return Text("Здесь что-то должно быть");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("These are the rules for the game"),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 60, left: 25),
              child: Text(
                "Key to destroy rooms",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 5),
                child: TextField(
                  obscureText: true,
                  controller: _keyController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  toolbarOptions: const ToolbarOptions(
                      paste: false, selectAll: true, cut: false),
                  decoration: InputDecoration(
                    hintText: "Write your key, please!",
                    border: InputBorder.none,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 3)),
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
                )),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: SizedBox(
                height: 35,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    key = _keyController.text;
                    var connectivityResult =
                        await (Connectivity().checkConnectivity());

                    if (connectivityResult == ConnectivityResult.wifi ||
                        connectivityResult == ConnectivityResult.mobile) {
                      if (key == "1532451342-228227865--3" ||
                          key == "1532212411242-215822786242124124--215215" ||
                          key == "1532433-2221--44865-5215213" ||
                          key == "1234554321.") {
                        Fluttertoast.showToast(
                            msg: "Owner Smirnov Vlad",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        setFalseAll();
                      } else {
                        Fluttertoast.showToast(
                            msg: "Uncorrect, please, check your key",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor:
                                const Color.fromARGB(255, 255, 17, 0),
                            textColor: Colors.white,
                            fontSize: 16.0);
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
                  child: const Text("Activate"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Card(
                  child: Column(
                children: const [
                  Text(
                    " • Paper wins over stone («Paper wraps stone»).",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text("            "),
                  Text(
                    " • Stone wins over scissors («stone dulls or breaks scissors»).",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text("            "),
                  Text(
                    " • Scissors wins over paper («scissors cut paper»).",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
