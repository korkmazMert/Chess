import 'package:chessgame1/pieces/chess_piece.dart';

class Bishop extends ChessPiece {
  Bishop(super.pieceColor, super.location);

  @override
  List<Location> legalMoves(List<ChessPiece> others) {
    return <Location>{
      ..._generateMoveOnDiagonal(true, true, others),
      ..._generateMoveOnDiagonal(false, true, others),
      ..._generateMoveOnDiagonal(true, false, others),
      ..._generateMoveOnDiagonal(false, false, others),

      // ...List.generate(8, (i) {
      //   return Location(location.x - 1, location.y + 1);
      // }),
      // ...List.generate(8, (i) {
      //   return Location(location.x + 1, location.y + 1);
      // }),
      // ...List.generate(8, (i) {
      //   return Location(location.x - 1, location.y - 1);
      // }),
      // ...List.generate(8, (i) {
      //   return Location(location.x + 1, location.y - 1);
      // })
    }.toList();
  }

  @override
  String get name => "bishop";

  List<Location> _generateMoveOnDiagonal(
      bool isUp, bool isRight, List<ChessPiece> others) {
    bool obstructed = false;
    return List<Location?>.generate(8, (i) {
      int dx = isRight ? 1 : -1;
      int dy = isUp ? 1 : -1;

      final pos = Location(x + dx, y + dy);

      final pieceOnLocation = others.any((piece) => piece.location == pos);
      if (pieceOnLocation) {
        obstructed = true;
      }
      return obstructed ? null : pos;
    }).whereType<Location>().where((Location) => location.isValid).toList();
  }
}
