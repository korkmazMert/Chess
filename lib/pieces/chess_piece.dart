enum PlayerColor { black, white }

class Location {
  final int x;
  final int y;
  Location(this.x, this.y);
  bool get isValid => x <= 7 && y <= 7;
  @override
  // TODO: implement hashCode
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
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
  List<Location> legalMoves(List<ChessPiece> others);
  bool canMoveto(int x, int y, List<ChessPiece> others) =>
      legalMoves(others).contains(Location(x, y));

  @override
  String toString() => "$name($x,$y)";
}
