// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:logger/logger.dart';

// extension DioErrosException on DioError {
//   void getMessages() {
//     switch (response!.statusCode) {
//       case 400:
//         Logger()
//             .d(ErrorMessage.fromJson(response!.data).error?.details?.toJson());
//         throw BadRequestException(
//           ErrorMessage.fromJson(response!.data).error?.message.toString(),
//         );
//       case 401:
//         Logger().d(json.decode(response!.data.toString()));
//         throw json.decode(response!.data.toString());
//       case 403:
//         throw UnauthorisedException(json.decode(response!.data.toString()));
//       case 500:
//       default:
//         throw FetchDataException(
//             message:
//                 'Error occured while Communication with Server with StatusCode : ${response!.statusCode}');
//     }
//   }
// }
