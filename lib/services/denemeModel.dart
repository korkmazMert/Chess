import 'package:chessgame1/pieces/chess_piece.dart';

class denemeModel {
  denemeModel({required this.data});
  List<ChessPiece> data;
  factory denemeModel.FromJson(Map<String, dynamic> json) =>
      denemeModel(data: json["data"]);

  Map<String, dynamic> toJson() {
    return {
      "data": List<dynamic>.from(data.map((chessPiece) => chessPiece
          .toJson())), // ChessPiece objelerini JSON'a dönüştürmek için "toJson" yöntemini kullanıyoruz
    };
  }
}
