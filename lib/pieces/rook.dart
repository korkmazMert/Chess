import 'package:chessgame1/pieces/chess_piece.dart';

class Rook extends ChessPiece {
  Rook(super.pieceColor, super.location);

  @override
  String get name => "rook";

  @override
  List<Location> moves(List<ChessPiece> others) {
    return <Location>{
      ..._generateMoveOnStraight(true, true, others),
      ..._generateMoveOnStraight(false, true, others),
      ..._generateMoveOnStraight(true, false, others),
      ..._generateMoveOnStraight(false, false, others),
    }.toList();
  }

  @override
  List<Location> captures(List<ChessPiece> others) {
    return <Location>{
      ..._generateCapturesOnStraight(true, true, others),
      ..._generateCapturesOnStraight(false, true, others),
      ..._generateCapturesOnStraight(true, false, others),
      ..._generateCapturesOnStraight(false, false, others),
    }.toList();
  }

  List<Location> _generateMoveOnStraight(
      bool isUp, bool isRight, List<ChessPiece> pieces) {
    bool obstructed = false;
    return List<Location?>.generate(
      8,
      (i) {
        if (obstructed) return null;
        int dx = 0;
        int dy = 0;
        if (isUp && isRight) {
          dy = 1 * i;
        }
        if (isUp && isRight == false) {
          dx = -1 * i;
        }
        if (isUp == false && isRight == false) {
          dy = -1 * i;
        }
        if (isUp == false && isRight) {
          dx = 1 * i;
        }

        final destination = Location(x + dx, y + dy);

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

  List<Location> _generateCapturesOnStraight(
      bool isUp, bool isRight, List<ChessPiece> pieces) {
    bool hasFoundCapture = false;

    return List<Location?>.generate(8, (i) {
      if (hasFoundCapture) return null;
      int dx = 0;
      int dy = 0;
      if (isUp && isRight) {
        dy = 1 * i;
      }
      if (isUp && isRight == false) {
        dx = -1 * i;
      }
      if (isUp == false && isRight == false) {
        dy = -1 * i;
      }
      if (isUp == false && isRight) {
        dx = 1 * i;
      }

      final destination = Location(x + dx, y + dy);

      final pieceOnLocation =
          pieces.any((piece) => piece.location == destination);
      if (pieceOnLocation && location != destination) {
        hasFoundCapture = true;
        return destination;
      }
    }).whereType<Location>().where((Location) => location.isValid).toList();
  }
}
