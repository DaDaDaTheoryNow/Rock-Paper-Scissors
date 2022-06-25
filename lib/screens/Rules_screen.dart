import 'package:flutter/material.dart';

class RulesScreen extends StatefulWidget {
  const RulesScreen({super.key});

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

final TextEditingController _keyController = TextEditingController();

class _RulesScreenState extends State<RulesScreen> {
  Text setFalseAll() {
    return const Text("Здесь что-то должно быть");
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
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width / 2,
              bottom: MediaQuery.of(context).size.width / 2,
              left: 6,
              right: 6),
          child: Card(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}
