import 'dart:convert';
import 'package:chessgame1/services/denemeModel.dart';
import 'package:json_annotation/json_annotation.dart';

denemeModelBase jobModelBaseFromJson(String str) =>
    denemeModelBase.FromJson(json.decode(str));

String jobModelBaseToJson(denemeModelBase data) => json.encode(data.toJson());

@JsonSerializable()
class denemeModelBase extends Object {
  denemeModelBase({
    required this.board,
  });
  List<denemeModel> board;

  factory denemeModelBase.FromJson(Map<String, dynamic> json) =>
      denemeModelBase(
        board: List<denemeModel>.from(
            json["board"].map((x) => denemeModel.FromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "board": List<dynamic>.from(board.map((x) => x.toJson())),
      };
}
