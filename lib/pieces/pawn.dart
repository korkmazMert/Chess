import 'package:chessgame1/pieces/chess_piece.dart';

class Pawn extends ChessPiece {
  Pawn(super.pieceColor, super.location);

  @override
  String get name => "pawn";

  @override
  List<Location> moves(List<ChessPiece> others) {
    return <Location>{
      ..._generateMoveOnStraight(true, true, others),
      ..._generateMoveOnStraight(true, false, others),
    }.toList();
  }

  @override
  List<Location> captures(List<ChessPiece> others) {
    return <Location>{
      ..._generateCapturesOnDiagonal(true, true, others),
      ..._generateCapturesOnDiagonal(true, false, others),
    }.toList();
  }

  List<Location> _generateMoveOnStraight(
      bool isUp, bool isFirstMove, List<ChessPiece> pieces) {
    bool obstructed = false;
    int whitePawnInitialLoc = 6;
    int blackPawnInitialLoc = 1;
    return List<Location?>.generate(
      8,
      (i) {
        if (obstructed) return null;

        int dy = 0;
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

        final destination = Location(x, y + dy, pieceColor);

        final pieceOnLocation =
            pieces.any((piece) => piece.location == destination);
        if (pieceOnLocation && location != destination) {
          obstructed = true;
          return null;
        }
        return destination;
      },
    ).whereType<Location>().where((Location) => location.isValid).toList();
  }

  List<Location> _generateCapturesOnDiagonal(
      bool isUp, bool isRight, List<ChessPiece> pieces) {
    bool hasFoundCapture = false;

    return List<Location?>.generate(8, (i) {
      if (hasFoundCapture) return null;
      int dx = 0;
      int dy = 0;
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

      final destination = Location(x + dx, y + dy, pieceColor);

      final pieceOnLocation = pieces.any((piece) =>
          piece.location == destination &&
          destination.locationColor != piece.pieceColor);
      if (pieceOnLocation && location != destination) {
        hasFoundCapture = true;
        return destination;
      }
    }).whereType<Location>().where((Location) => location.isValid).toList();
  }
}
