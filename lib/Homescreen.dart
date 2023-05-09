import 'package:chessgame1/game_coordinator.dart';
import 'package:chessgame1/pieces/chess_piece.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late final double tileWidth = MediaQuery.of(context).size.width / 8.0;
  final Color green = const Color.fromRGBO(119, 149, 86, 100);
  final Color lightGreen = const Color.fromRGBO(235, 236, 208, 100);
  final GameCoordinator coordinator = GameCoordinator.newGame();
  List<ChessPiece> get pieces => coordinator.pieces;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chess"),
      ),
      body: Column(
        children: [
          const Spacer(),
          buildBoard(),
          const Spacer(),
        ],
      ),
    );
  }

  Color buildTileColor(int x, int y) {
    int value = x;
    if (y.isOdd) {
      value++;
    }
    return value.isEven ? green : lightGreen;
  }

  Column buildBoard() {
    return Column(
      children: [
        ...List.generate(
          8,
          (y) => Row(
            children: [
              ...List.generate(
                8,
                (x) => buildDragTarget(x, y),
              ).reversed,
            ],
          ),
        )
      ],
    );
  }

  DragTarget<ChessPiece> buildDragTarget(int x, int y) {
    return DragTarget<ChessPiece>(
      onAccept: (piece) {
        setState(() {
          piece.location = Location(x, y);
        });
      },
      onWillAccept: (piece) {
        print(piece);
        if (piece == null) {
          return false;
        }
        final accept = piece.canMoveto(x, y, pieces);
        print("$piece ${accept ? "can" : "cannot"} move to ($x, $y");
        return accept;
      },
      builder: (context, candidateData, rejectedData) => Container(
        decoration: BoxDecoration(
          color: buildTileColor(x, y),
        ),
        width: tileWidth,
        height: tileWidth,
        child: _buildChessPieces(x, y),
      ),
    );
  }

  Widget? _buildChessPieces(int x, int y) {
    final piece = coordinator.pieceOfTile(x, y);
    if (piece != null) {
      final child = Container(
        alignment: Alignment.center,
        child: Image.asset(
          piece.fileName,
          height: tileWidth * 1,
          width: tileWidth * 1,
        ),
      );
      return Draggable<ChessPiece>(
        data: piece,
        feedback: child,
        child: child,
        childWhenDragging: const SizedBox.shrink(),
      );
    }
  }
}