import 'package:chessgame1/pieces/chess_piece.dart';

class Pawn extends ChessPiece {
  Pawn(super.pieceColor, super.location);

  @override
  String get name => "pawn";

  @override
  List<Location> moves(List<ChessPiece> others, currentTurn) {
    return <Location>{
      ..._generateMoveOnStraight(true, true, others, currentTurn),
      ..._generateMoveOnStraight(true, false, others, currentTurn),
    }.toList();
  }

  @override
  List<Location> captures(List<ChessPiece> others, currentTurn) {
    return <Location>{
      ..._generateCapturesOnDiagonal(true, true, others, currentTurn),
      ..._generateCapturesOnDiagonal(true, false, others, currentTurn),
    }.toList();
  }

  List<Location> _generateMoveOnStraight(bool isUp, bool isFirstMove,
      List<ChessPiece> pieces, PlayerColor currentTurn) {
    bool obstructed = false;
    int whitePawnInitialLoc = 6;
    int blackPawnInitialLoc = 1;
    return List<Location?>.generate(
      8,
      (i) {
        if (obstructed) return null;
        int dy = 0;
        if (currentTurn == pieceColor) {
          // beyaz piyonun ilk hareketiyse 2 birim gidebilir
          if (isUp &&
              pieceColor == PlayerColor.white &&
              location.y == whitePawnInitialLoc &&
              isFirstMove) {
            dy = -2;
          }
          //siyah piyonun ilk hareketi ise 2 birim gidebilir
          if (isUp &&
              pieceColor == PlayerColor.black &&
              location.y == blackPawnInitialLoc &&
              isFirstMove) {
            dy = 2;
          }
          // beyaz için 1 birim ileri
          if (isUp && pieceColor == PlayerColor.white && isFirstMove != true) {
            dy = -1;
          }
          // siyah için 1 birim ileri
          if (isUp && pieceColor == PlayerColor.black && isFirstMove != true) {
            dy = 1;
          }
        }

        final destination = Location(x, y + dy, pieceColor);

        final pieceOnLocation =
            pieces.any((piece) => piece.location == destination);
        if (pieceOnLocation) {
          obstructed = true;
          return null;
        }
        return destination;
      },
    ).whereType<Location>().where((Location) => location.isValid).toList();
  }

  List<Location> _generateCapturesOnDiagonal(bool isUp, bool isRight,
      List<ChessPiece> pieces, PlayerColor currentTurn) {
    bool hasFoundCapture = false;

    return List<Location?>.generate(8, (i) {
      int dx = 0;
      int dy = 0;

      if (hasFoundCapture) return null;
      if (currentTurn == pieceColor) {
        if (isUp && isRight && pieceColor == PlayerColor.white) {
          dy = -1;
          dx = -1;
        }
        if (isUp && isRight != true && pieceColor == PlayerColor.white) {
          dy = -1;
          dx = 1;
        }
        if (isUp && isRight && pieceColor == PlayerColor.black) {
          dy = 1;
          dx = -1;
        }
        if (isUp && isRight != true && pieceColor == PlayerColor.black) {
          dy = 1;
          dx = 1;
        }
      }

      final destination = Location(x + dx, y + dy, pieceColor);

      final pieceOnLocation = pieces.any((piece) =>
          piece.location == destination &&
          destination.locationColor != piece.pieceColor);
      if (pieceOnLocation && location != destination) {
        hasFoundCapture = true;
        return destination;
      }
      return null;
    }).whereType<Location>().where((Location) => location.isValid).toList();
  }
}
