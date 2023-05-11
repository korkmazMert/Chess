import 'package:chessgame1/pieces/bishop.dart';
import 'package:chessgame1/pieces/chess_piece.dart';
import 'package:chessgame1/pieces/knight.dart';
import 'package:chessgame1/pieces/queen.dart';
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
        Bishop(PlayerColor.white, Location(2, 7, PlayerColor.white)),
        Bishop(PlayerColor.white, Location(5, 7, PlayerColor.white)),
        Bishop(PlayerColor.black, Location(2, 0, PlayerColor.black)),
        Bishop(PlayerColor.black, Location(5, 0, PlayerColor.black)),
        Rook(PlayerColor.white, Location(7, 7, PlayerColor.white)),
        Rook(PlayerColor.white, Location(0, 7, PlayerColor.white)),
        Rook(PlayerColor.black, Location(0, 0, PlayerColor.black)),
        Rook(PlayerColor.black, Location(7, 0, PlayerColor.black)),
        Queen(PlayerColor.black, Location(4, 0, PlayerColor.black)),
        Queen(PlayerColor.white, Location(4, 7, PlayerColor.white)),
        Knight(PlayerColor.white, Location(1, 7, PlayerColor.white)),
        Knight(PlayerColor.white, Location(6, 7, PlayerColor.white)),
        Knight(PlayerColor.black, Location(1, 0, PlayerColor.white)),
        Knight(PlayerColor.black, Location(6, 0, PlayerColor.white)),
      ],
    );
  }
}
