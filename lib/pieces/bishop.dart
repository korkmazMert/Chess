import 'package:chessgame1/pieces/chess_piece.dart';

class Bishop extends ChessPiece {
  Bishop(super.pieceColor, super.location);
  @override
  String get name => "bishop";
  @override
  List<Location> moves(List<ChessPiece> others) {
    return <Location>{
      ..._generateMoveOnDiagonal(true, true, others),
      ..._generateMoveOnDiagonal(false, true, others),
      ..._generateMoveOnDiagonal(true, false, others),
      ..._generateMoveOnDiagonal(false, false, others),
    }.toList();
  }

  @override
  List<Location> captures(List<ChessPiece> others) {
    return <Location>{
      ..._generateCapturesOnDiagonal(true, true, others),
      ..._generateCapturesOnDiagonal(false, true, others),
      ..._generateCapturesOnDiagonal(true, false, others),
      ..._generateCapturesOnDiagonal(false, false, others),
    }.toList();
  }

  List<Location> _generateMoveOnDiagonal(
      bool isUp, bool isRight, List<ChessPiece> pieces) {
    bool obstructed = false;
    return List<Location?>.generate(
      8,
      (i) {
        if (obstructed) return null;
        int dx = (isRight ? 1 : -1) * i;
        int dy = (isUp ? 1 : -1) * i;

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

  List<Location> _generateCapturesOnDiagonal(
      bool isUp, bool isRight, List<ChessPiece> pieces) {
    bool hasFoundCapture = false;

    return List<Location?>.generate(8, (i) {
      if (hasFoundCapture) return null;
      int dx = (isRight ? 1 : -1) * i;
      int dy = (isUp ? 1 : -1) * i;

      final destination = Location(x + dx, y + dy, pieceColor);

      final pieceOnLocation =
          pieces.any((piece) => piece.location == destination);
      if (pieceOnLocation && location != destination) {
        hasFoundCapture = true;
        return destination;
      }
    }).whereType<Location>().where((Location) => location.isValid).toList();
  }
}
