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

  toJson() {}
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

  static PlayerColor get currentTurn => currentTurn;

  static List<ChessPiece> get others => others;
  List<Location> moves(List<ChessPiece> others, PlayerColor currentTurn);
  List<Location> captures(List<ChessPiece> others, PlayerColor currentTurn);
  late List<Location> hamleler = moves(others, currentTurn);
  bool canMoveto(
          int x, int y, List<ChessPiece> others, PlayerColor currentTurn) =>
      moves(others, currentTurn).contains(Location(x, y, pieceColor));
  late List<Location> capturelar = captures(others, currentTurn);
  bool canCapture(
          int x, int y, List<ChessPiece> others, PlayerColor currentTurn) =>
      captures(others, currentTurn).contains(Location(x, y, pieceColor));

  @override
  String toString() => "$name($x,$y)";
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "location": location
          .toJson(), // Location objesini JSON'a dönüştürmek için "toJson" yöntemini kullanıyoruz
      "pieceColor": pieceColor.toString(),
      "x": x,
      "y": y,
      "moves": hamleler,
      "captures": capturelar
      // Diğer özellikleri de JSON'a dönüştürebilirsiniz
      // Örnek olarak: "pieceColor": pieceColor.toString(),
    };
  }
}
