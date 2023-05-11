import 'package:chessgame1/pieces/bishop.dart';
import 'package:chessgame1/pieces/chess_piece.dart';
import 'package:chessgame1/pieces/rook.dart';
import 'package:collection/collection.dart';

class GameCoordinator {
  final List<ChessPiece> pieces;
  PlayerColor currentTurn = PlayerColor.white;
  GameCoordinator(this.pieces);
  ChessPiece? pieceOfTile(int x, int y) =>
      pieces.firstWhereOrNull((p) => p.x == x && p.y == y);

  factory GameCoordinator.newGame() {
    return GameCoordinator(
      [
        Bishop(PlayerColor.white, Location(2, 7)),
        Bishop(PlayerColor.white, Location(5, 7)),
        Bishop(PlayerColor.black, Location(2, 0)),
        Bishop(PlayerColor.black, Location(5, 0)),
        Rook(PlayerColor.white, Location(7, 7)),
        Rook(PlayerColor.white, Location(0, 7)),
        Rook(PlayerColor.black, Location(0, 0)),
        Rook(PlayerColor.black, Location(7, 0)),
      ],
    );
  }
}
