import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class LevelUpPage extends StatefulWidget {
  const LevelUpPage({super.key});

  @override
  State<LevelUpPage> createState() => _LevelUpPageState();
}

class _LevelUpPageState extends State<LevelUpPage> {
  late String levelUpPieceName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SimpleDialog(
        title: const Text("Select a piece"),
        children: [
          SimpleDialogOption(
            child: const Text("Queen"),
            onPressed: () async {
              levelUpPieceName = "Queen";
              Navigator.pop(context, levelUpPieceName);
            },
          ),
          SimpleDialogOption(
            child: const Text("Rook"),
            onPressed: () {
              levelUpPieceName = "Rook";
              Navigator.pop(context, levelUpPieceName);
            },
          ),
          SimpleDialogOption(
            child: const Text("Bishop"),
            onPressed: () {
              levelUpPieceName = "Bishop";
              Navigator.pop(context, levelUpPieceName);
            },
          ),
          SimpleDialogOption(
            child: const Text("Knight"),
            onPressed: () {
              levelUpPieceName = "Knight";
              Navigator.pop(context, levelUpPieceName);
            },
          ),
        ],
      ),
    );
  }
}
