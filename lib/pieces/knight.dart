import 'package:chessgame1/pieces/chess_piece.dart';

class Knight extends ChessPiece {
  Knight(super.pieceColor, super.location);

  @override
  String get name => "knight";

  @override
  List<Location> moves(List<ChessPiece> others) {
    return <Location>{
      ..._generateMoveOnL(true, true, others),
      ..._generateMoveOnL(false, true, others),
      ..._generateMoveOnL(true, false, others),
      ..._generateMoveOnL(false, false, others),
    }.toList();
  }

  @override
  List<Location> captures(List<ChessPiece> others) {
    return <Location>{
      ..._generateCapturesOnL(true, true, others),
      ..._generateCapturesOnL(false, true, others),
      ..._generateCapturesOnL(true, false, others),
      ..._generateCapturesOnL(false, false, others),
    }.toList();
  }

  List<Location> _generateMoveOnL(
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

  List<Location> _generateCapturesOnL(
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
