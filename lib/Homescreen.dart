import 'package:chessgame1/LevelUpPage.dart';
import 'package:chessgame1/game_coordinator.dart';
import 'package:chessgame1/pieces/bishop.dart';
import 'package:chessgame1/pieces/chess_piece.dart';
import 'package:chessgame1/pieces/knight.dart';
import 'package:chessgame1/pieces/queen.dart';
import 'package:chessgame1/pieces/rook.dart';
import 'package:chessgame1/services/denemeModel.dart';
import 'package:chessgame1/services/serviceOperators.dart';
import 'package:flutter/material.dart';

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
  late List<ChessPiece> pieces = coordinator.pieces;
  late denemeModel liste;

  PlayerColor currentTurn = PlayerColor.white;
  String levelUpPieceName = "Rook";

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
      onAccept: (piece) async {
        liste.data = pieces;

        denemeSaveTahta().saveTahta(playerID: 22, data: liste.data);
        dynamic gelenveri = await denemeGetTahta().getTahta(userId: 21);
        print("gelenveri:");
        print(gelenveri.toString());
        //pieces = gelenveri;

        //print(pieces);
        // print(loc.locationColor);
        // print(loc.x);
        // print(loc.y);
        final capturedPiece = coordinator.pieceOfTile(x, y);
        piece.location = Location(x, y, piece.pieceColor);
        if (capturedPiece != null) {
          if (piece.name == "pawn" &&
              capturedPiece.location.y == 0 &&
              piece.pieceColor == PlayerColor.white) {
            pieces.remove(capturedPiece);
            pieces.remove(piece);
            // pieces.add(Queen(piece.pieceColor, piece.location));
            await popUpSelection(piece);
          }
          if (piece.name == "pawn" &&
              capturedPiece.location.y == 7 &&
              piece.pieceColor == PlayerColor.black) {
            pieces.remove(
                capturedPiece); // piyon oraya ilerlemeden capture işlemi yapılacak
            pieces.remove(
                piece); // piyonun farklı bir taş olabilmesi için önce silip aynı konuma yeni taş eklenecek
            // pieces.add(Queen(piece.pieceColor, piece.location)); // oyuna yeni taş ekleme kodu

            await popUpSelection(
                piece); // yeni sayfaya gidip seçim yapıp veriyi geri gönderen method
          } else {
            //print("$capturedPiece captured!!");
            pieces.remove(capturedPiece);
          }
        }

        setState(
          () {
            if (capturedPiece?.name == "king") {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Homescreen(),
                  ));
            }
            currentTurnChanger();
          },
        );
      },
      onWillAccept: (piece) {
        if (piece == null) {
          return false;
        }
        final canMoveTo = piece.canMoveto(x, y, pieces, currentTurn);
        final canCapture = piece.canCapture(x, y, pieces, currentTurn);
        // print(piece.moves(pieces, currentTurn));
        // print(piece.captures(pieces, currentTurn));

        return canMoveTo || canCapture;
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

  Future<void> popUpSelection(ChessPiece piece) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LevelUpPage(),
        ));
    if (result == "Queen") {
      pieces.add(Queen(piece.pieceColor, piece.location));
    } else if (result == "Rook") {
      pieces.add(Rook(piece.pieceColor, piece.location));
    } else if (result == "Bishop") {
      pieces.add(Bishop(piece.pieceColor, piece.location));
    } else if (result == "Knight") {
      pieces.add(Knight(piece.pieceColor, piece.location));
    }
  }

  void currentTurnChanger() {
    if (currentTurn == PlayerColor.white) {
      currentTurn = PlayerColor.black;
    } else {
      currentTurn = PlayerColor.white;
    }
    // print(coordinator.currentTurn);
    // print(pieces);
    //hamle yapılıp sıra karşıya geçtikten sonra veriler gönderilip tekrar çekilebilir.
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
        childWhenDragging: const SizedBox.shrink(),
        child: child,
      );
    }
    return null;
  }
}
