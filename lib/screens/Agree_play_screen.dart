import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rock_paper_scissors/main.dart';
import 'package:rock_paper_scissors/screens/Home_screen.dart';
import 'package:rock_paper_scissors/screens/RoomCreate_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class AgreePlayScreen extends StatefulWidget {
  const AgreePlayScreen({Key? key}) : super(key: key);

  @override
  State<AgreePlayScreen> createState() => _AgreePlayScreenState();
}

class _AgreePlayScreenState extends State<AgreePlayScreen> {
  final Stream<QuerySnapshot> _version =
      FirebaseFirestore.instance.collection('version_app').snapshots();

  String agreeText = "Are you sure you want to play?";

  setAgreeText() async {
    await Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(agreeText,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Row(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: _version,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  final data = snapshot.requireData;

                  if (snapshot.hasError) {
                    return const Text('Something went wrong...');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ListTile(
                      title: Text("Checking your app version"),
                      subtitle: Text("if the Internet is not on, turn it on"),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    Fluttertoast.showToast(
                        msg: "Connection done",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }

                  if (data.docs[0]["release_version"] == "1.00") {
                    agreeText = "Are you sure you want to play?";
                    setAgreeText();
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 110),
                          child: SizedBox(
                            width: 75,
                            height: 75,
                            child: FloatingActionButton(
                              onPressed: () async {
                                var connectivityResult =
                                    await (Connectivity().checkConnectivity());
                                if (connectivityResult ==
                                        ConnectivityResult.mobile ||
                                    connectivityResult ==
                                        ConnectivityResult.wifi) {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          duration: const Duration(seconds: 1),
                                          child:
                                              const AmberBackGroundRoomCreate()));
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
                              child: const Text("Yes",
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: SizedBox(
                            width: 75,
                            height: 75,
                            child: FloatingActionButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        duration:
                                            const Duration(milliseconds: 900),
                                        child: const MyApp()));
                              },
                              child: const Text(
                                "No",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    agreeText = "";
                    setAgreeText();
                    return Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 25, left: 15),
                          child: Text(
                            "Failder version app",
                            style: TextStyle(
                              fontSize: 35,
                              color: Color.fromARGB(255, 255, 17, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () async {
                                final url = "https://t.me/MyFlutterProjects";

                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              child: const Text(
                                  "Download the latest version of the app"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: SizedBox(
                            width: 150,
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => const MyApp()),
                                      (Route<dynamic> route) => false);
                                },
                                child: const Text(
                                  "Back",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AmberBackGroundHome extends StatefulWidget {
  const AmberBackGroundHome({super.key});

  @override
  State<AmberBackGroundHome> createState() => _AmberBackGroundHomeState();
}

class _AmberBackGroundHomeState extends State<AmberBackGroundHome> {
  @override
  void initState() {
    super.initState();
    getWeatherForecast();
  }

  Future getWeatherForecast() {
    return Future.delayed(
        const Duration(milliseconds: 1650),
        () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MyApp()),
            (Route<dynamic> route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Image(image: AssetImage("assets/load_game.png")),
      ),
    );
  }
}

class AmberBackGroundRoomCreate extends StatefulWidget {
  const AmberBackGroundRoomCreate({super.key});

  @override
  State<AmberBackGroundRoomCreate> createState() =>
      _AmberBackGroundRoomCreateState();
}

class _AmberBackGroundRoomCreateState extends State<AmberBackGroundRoomCreate> {
  @override
  void initState() {
    super.initState();
    getWeatherForecast();
  }

  Future getWeatherForecast() {
    return Future.delayed(
        const Duration(milliseconds: 1650),
        () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const RoomCreateOrJoinScreen()),
            (Route<dynamic> route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Image(image: AssetImage("assets/load_game.png")),
      ),
    );
  }
}
