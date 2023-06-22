// import 'dart:convert';
// import 'package:chessgame1/pieces/chess_piece.dart';
// import 'package:chessgame1/services/ChessPieceModel.dart';
// import 'package:json_annotation/json_annotation.dart';

// chessModelBase jobModelBaseFromJson(String str) =>
//     chessModelBase.fromJson(json.decode(str));

// String jobModelBaseToJson(chessModelBase data) => json.encode(data.toJson());

// @JsonSerializable()
// class chessModelBase extends Object {
//   chessModelBase({
//     required this.board,
//   });
//   List<denemeModel> board;

//   factory chessModelBase.fromJson(Map<String, dynamic> json) => chessModelBase(
//         board: List<denemeModel>.from(
//             json["board"].map((x) => denemeModel.FromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "board": List<dynamic>.from(board.map((x) => x.toJson())),
//       };
// }
