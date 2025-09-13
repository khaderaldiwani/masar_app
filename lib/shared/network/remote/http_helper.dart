import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:masar/shared/function/check_internet.dart';
import 'package:masar/shared/network/remote/status_requst.dart';
import 'package:path/path.dart';

class Api {
  Future<Either<StatusRequest, Map>> postData(String url, Map data) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(Uri.parse(url), body: data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);

          return Right(responseBody);
        } else {
          // print("StatusRequest.serverfailure");

          return const Left(StatusRequest.serverfailure);
        }
      } else {
        // print("StatusRequest.offLinefailure");

        return const Left(StatusRequest.offLinefailure);
      }
    } catch (_) {
//      print("catch StatusRequest.serverException");

      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> postDataWithToken(
      String url, Map data, String token) async {
    try {
      if (await checkInternet()) {
        //    print("before");
        //  await Future.delayed(const Duration(seconds: 10));
        var response = await http.post(Uri.parse(url),
            body: data, headers: {'Authorization': 'Bearer $token'});
        //  print(response.statusCode);
        //  print(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);

          //    print(responseBody);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        //   print("StatusRequest.offLinefailure");

        return const Left(StatusRequest.offLinefailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> putDataWithToken(
      String url, Map data, String token) async {
    try {
      if (await checkInternet()) {
        var response = await http.put(
          Uri.parse(url),
          body: data,
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        );

        //  print(response.statusCode);

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          //  print(responseBody);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offLinefailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> deleteDataWithToken(
      String url, String token) async {
    try {
      if (await checkInternet()) {
        var response = await http.delete(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        );
//    print(response.statusCode);

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          //print(responseBody);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offLinefailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> getDataWithToken(
      String url, String token) async {
    try {
      if (await checkInternet()) {
        // await Future.delayed(const Duration(seconds: 2));

        var response = await http.get(
          Uri.parse(url),
          headers: {'Authorization': 'Bearer $token'},
        );
        // print(response.statusCode);
        //  print(response);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);

          //  print(responseBody);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offLinefailure);
      }
    } catch (_) {
//      print("catch StatusRequest.serverException");

      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> postDataLogin(String url, Map data) async {
    try {
      if (await checkInternet()) {
        // await Future.delayed(const Duration(seconds: 2));
        var response = await http.post(Uri.parse(url), body: data);
        // print(response.statusCode);
        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 401 ||
            response.statusCode == 422) {
          Map responseBody = jsonDecode(response.body);
          //  print(responseBody);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offLinefailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> postRequsteWithFileWithToken(
      String url, Map body, File file, String token) async {
    try {
      if (await checkInternet()) {
        var requste = http.MultipartRequest("POST", Uri.parse(url));
        requste.headers['Authorization'] = "Bearer $token";
        var stream = http.ByteStream(file.openRead());
        var length = await file.length();

        var multipartfile = http.MultipartFile(
          "image",
          stream,
          length,
          filename: basename(file.path),
        );

        requste.files.add(multipartfile);

        body.forEach((key, value) {
          requste.fields[key] = value.toString();
        });

        var myrequst = await requste.send();
        var response = await http.Response.fromStream(myrequst);

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          // print(responseBody);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offLinefailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }
}
