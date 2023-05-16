enum PlayerColor { black, white }

class Location {
  final int x;
  final int y;
  final PlayerColor locationColor;
  Location(this.x, this.y, this.locationColor);
  bool get isValid => x <= 7 && y <= 7;
  @override
  // TODO: implement hashCode
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  bool operator ==(Object other) {
    return other is Location && (x == other.x && y == other.y);
  }
}

abstract class ChessPiece {
  ChessPiece(this.pieceColor, this.location);
  Location location;
  final PlayerColor pieceColor;
  String get name;
  String get fileName =>
      "assets/${pieceColor.toString().split(".").last}_$name.png";

  int get x => location.x;
  int get y => location.y;
  List<Location> moves(List<ChessPiece> others, PlayerColor currentTurn);
  List<Location> captures(List<ChessPiece> others);

  bool canMoveto(
          int x, int y, List<ChessPiece> others, PlayerColor currentTurn) =>
      moves(others, currentTurn).contains(Location(x, y, pieceColor));

  bool canCapture(int x, int y, List<ChessPiece> others) =>
      captures(others).contains(Location(x, y, pieceColor));

  @override
  String toString() => "$name($x,$y)";
}
