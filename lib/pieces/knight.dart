import 'package:chessgame1/pieces/chess_piece.dart';

class Knight extends ChessPiece {
  Knight(super.pieceColor, super.location);

  @override
  String get name => "knight";

  @override
  List<Location> moves(List<ChessPiece> others, currentTurn) {
    return <Location>{
      ..._generateMoveOnL(true, true, false, others, currentTurn),
      ..._generateMoveOnL(true, true, true, others, currentTurn),
      ..._generateMoveOnL(true, false, true, others, currentTurn),
      ..._generateMoveOnL(true, false, false, others, currentTurn),
      ..._generateMoveOnL(false, false, false, others, currentTurn),
      ..._generateMoveOnL(false, false, true, others, currentTurn),
      ..._generateMoveOnL(false, true, true, others, currentTurn),
      ..._generateMoveOnL(false, true, false, others, currentTurn),
    }.toList();
  }

  @override
  List<Location> captures(List<ChessPiece> others, currentTurn) {
    return <Location>{
      ..._generateCapturesOnL(true, true, false, others, currentTurn),
      ..._generateCapturesOnL(true, true, true, others, currentTurn),
      ..._generateCapturesOnL(true, false, true, others, currentTurn),
      ..._generateCapturesOnL(true, false, false, others, currentTurn),
      ..._generateCapturesOnL(false, false, false, others, currentTurn),
      ..._generateCapturesOnL(false, false, true, others, currentTurn),
      ..._generateCapturesOnL(false, true, true, others, currentTurn),
      ..._generateCapturesOnL(false, true, false, others, currentTurn),
    }.toList();
  }

  List<Location> _generateMoveOnL(bool isUp, bool isRight, bool isDiagonal,
      List<ChessPiece> pieces, PlayerColor currentTurn) {
    bool obstructed = false;
    return List<Location?>.generate(
      8,
      (i) {
        int dx = 0;
        int dy = 0;
        if (obstructed) return null;
        if (pieceColor == currentTurn) {
          if (isUp && isRight && isDiagonal != true) {
            //at sağa yatay L hareketi yapar
            dy = -1;
            dx = -2;
          }
          if (isUp && isRight && isDiagonal) {
            // at sağa dikey L hareketi yapar
            dx = -1;
            dy = -2;
          }
          if (isUp && isRight != true && isDiagonal) {
            //at sola dikey L hareketi yapar
            dy = -2;
            dx = 1;
          }
          if (isUp && isRight != true && isDiagonal != true) {
            //at sola yatay L hareketi yapar
            dy = -1;
            dx = 2;
          }

          // eksenenin alt kısmı

          if (isUp != true && isRight != true && isDiagonal != true) {
            //at sola yatay L hareketi yapar
            dy = 1;
            dx = 2;
          }
          if (isUp != true && isRight != true && isDiagonal) {
            //at sola dikey L hareketi yapar
            dy = 2;
            dx = 1;
          }
          if (isUp != true && isRight && isDiagonal) {
            //at sağa dikey L hareketi yapar
            dy = 2;
            dx = -1;
          }
          if (isUp != true && isRight && isDiagonal != true) {
            //at sağa yatay L hareketi yapar
            dy = 1;
            dx = -2;
          }
        }

        final destination = Location(x + dx, y + dy, pieceColor);

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

  List<Location> _generateCapturesOnL(bool isUp, bool isRight, bool isDiagonal,
      List<ChessPiece> pieces, PlayerColor currentTurn) {
    bool hasFoundCapture = false;

    return List<Location?>.generate(8, (i) {
      int dx = 0;
      int dy = 0;
      if (hasFoundCapture) return null;
      if (currentTurn == pieceColor) {
        if (isUp && isRight && isDiagonal != true) {
          //at sağa yatay L hareketi yapar
          dy = -1;
          dx = -2;
        }
        if (isUp && isRight && isDiagonal) {
          // at sağa dikey L hareketi yapar
          dx = -1;
          dy = -2;
        }
        if (isUp && isRight != true && isDiagonal) {
          //at sola dikey L hareketi yapar
          dy = -2;
          dx = 1;
        }
        if (isUp && isRight != true && isDiagonal != true) {
          //at sola yatay L hareketi yapar
          dy = -1;
          dx = 2;
        }

        // eksenenin alt kısmı

        if (isUp != true && isRight != true && isDiagonal != true) {
          //at sola yatay L hareketi yapar
          dy = 1;
          dx = 2;
        }
        if (isUp != true && isRight != true && isDiagonal) {
          //at sola dikey L hareketi yapar
          dy = 2;
          dx = 1;
        }
        if (isUp != true && isRight && isDiagonal) {
          //at sağa dikey L hareketi yapar
          dy = 2;
          dx = -1;
        }
        if (isUp != true && isRight && isDiagonal != true) {
          //at sağa yatay L hareketi yapar
          dy = 1;
          dx = -2;
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
