part of '../services.dart';

class APIUser {
  AccountController accountController = Get.find();
  dioPackage.Dio dio = dioPackage.Dio();
  Future<int> loginUser({
    required String email,
    required String pass,
  }) async {
    try {
      Map<String, dynamic> header = {
        'Accept': 'application/json',
        'Authorization': 'Bearer lsGPLl4k6Vc4J0VhnFaMBqetNtn1ofsB',
      };
      dioPackage.FormData formdata = dioPackage.FormData.fromMap({
        "email": email,
        "password": pass,
      });
      final responseku = await dio.post(BaseUrl.login,
          data: formdata, options: dioPackage.Options(headers: header));
      ResponseParser parser = ResponseParser.parse(mapData: responseku.data);
      if (parser.getStatus == ResponseStatus.success) {
        accountController.setCurrentAccount(
            newAccount:
                Account.fromJson(jsonData: parser.getData!, password: pass));
        return parser.getStatusCode!;
      } else {
        return parser.getStatusCode!;
      }
    } on Exception {
      return 400;
    }
  }
}
