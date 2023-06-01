import 'dart:convert';

import 'package:chessgame1/services/denemeModelBase.dart';
import 'package:dio/dio.dart';

import 'denemeModel.dart';

String baseUrl = "";

class denemeGetTahta {
  denemeModelBase? denemeBase;
  List<denemeModel>? denemelist;
  Future getTahta({required userId}) async {
    var body = json.encode({"userId": "$userId"});
    final response =
        await Dio().post("http://192.168.202.43:8085/jobs/getJobs", data: body);
    denemeBase = denemeModelBase?.FromJson(response.data);
    denemelist = denemeBase?.board;
  }
}

class denemeSaveTahta {
  Future saveTahta({required data}) async {
    var body = json.encode({"data": "$data"});
    final response =
        await Dio().post("http://192.168.202.43:8085/jobs/editJob", data: body);
    print("dönen veri:");
    print(response.data);
    return response.data;
  }
}

// class getBoard {
//   chessModelBase? base;
//   List<ChessPieceModel>? board;

//   Future getBoardList({required userId}) async {
//     var body = json.encode({"userId": "$userId"});
//     final response =
//         await Dio().post("http://192.168.202.43:8085/jobs/getJobs", data: body);

//     base = chessModelBase.fromJson(response.data);
//     board = base?.board;
//   }
// }

// class saveBoard {
//   Future sendBoard(
//       {required location,
//       required name,
//       required fileName,
//       required pieceColor,
//       required x,
//       required y,
//       required moves,
//       required captures,
//       required canMoveto,
//       required canCapture}) async {
//     var body = json.encode({
//       "name": "$name",
//       "location": "$location",
//       "fileName": "$fileName",
//       "pieceColor": "$pieceColor",
//       "x": "$x",
//       "y": "$y",
//       "moves": "$moves",
//       "captures": "$captures",
//       "canMoveto": "$canMoveto",
//       "canCapture": "$canCapture"
//     });
//     final response =
//         await Dio().post("http://192.168.202.43:8085/jobs/editJob", data: body);
//   }
//}
