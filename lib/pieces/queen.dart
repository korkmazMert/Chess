import 'package:chessgame1/pieces/chess_piece.dart';

class Queen extends ChessPiece {
  Queen(super.pieceColor, super.location);

  @override
  String get name => "queen";

  @override
  List<Location> moves(List<ChessPiece> others, currentTurn) {
    return <Location>{
      ..._generateMoveOnDiagonal(true, true, others, currentTurn),
      ..._generateMoveOnDiagonal(false, true, others, currentTurn),
      ..._generateMoveOnDiagonal(true, false, others, currentTurn),
      ..._generateMoveOnDiagonal(false, false, others, currentTurn),
      ..._generateMoveOnStraight(true, true, others, currentTurn),
      ..._generateMoveOnStraight(false, true, others, currentTurn),
      ..._generateMoveOnStraight(true, false, others, currentTurn),
      ..._generateMoveOnStraight(false, false, others, currentTurn),
    }.toList();
  }

  @override
  List<Location> captures(List<ChessPiece> others, currentTurn) {
    return <Location>{
      ..._generateCapturesOnDiagonal(true, true, others, currentTurn),
      ..._generateCapturesOnDiagonal(false, true, others, currentTurn),
      ..._generateCapturesOnDiagonal(true, false, others, currentTurn),
      ..._generateCapturesOnDiagonal(false, false, others, currentTurn),
      ..._generateCapturesOnStraight(true, true, others, currentTurn),
      ..._generateCapturesOnStraight(false, true, others, currentTurn),
      ..._generateCapturesOnStraight(true, false, others, currentTurn),
      ..._generateCapturesOnStraight(false, false, others, currentTurn),
    }.toList();
  }

  List<Location> _generateMoveOnDiagonal(bool isUp, bool isRight,
      List<ChessPiece> pieces, PlayerColor currentTurn) {
    bool obstructed = false;
    return List<Location?>.generate(
      8,
      (i) {
        int dx = 0;
        int dy = 0;
        if (obstructed) return null;
        if (currentTurn == pieceColor) {
          dx = (isRight ? 1 : -1) * i;
          dy = (isUp ? 1 : -1) * i;
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

  List<Location> _generateMoveOnStraight(bool isUp, bool isRight,
      List<ChessPiece> pieces, PlayerColor currentTurn) {
    bool obstructed = false;
    return List<Location?>.generate(
      8,
      (i) {
        int dx = 0;
        int dy = 0;
        if (obstructed) return null;
        if (currentTurn == pieceColor) {
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

  List<Location> _generateCapturesOnDiagonal(bool isUp, bool isRight,
      List<ChessPiece> pieces, PlayerColor currentTurn) {
    bool hasFoundCapture = false;

    return List<Location?>.generate(8, (i) {
      int dx = 0;
      int dy = 0;
      if (hasFoundCapture) return null;
      if (currentTurn == pieceColor) {
        dx = (isRight ? 1 : -1) * i;
        dy = (isUp ? 1 : -1) * i;
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

  List<Location> _generateCapturesOnStraight(bool isUp, bool isRight,
      List<ChessPiece> pieces, PlayerColor currentTurn) {
    bool hasFoundCapture = false;

    return List<Location?>.generate(8, (i) {
      int dx = 0;
      int dy = 0;
      if (hasFoundCapture) return null;
      if (currentTurn == pieceColor) {
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
