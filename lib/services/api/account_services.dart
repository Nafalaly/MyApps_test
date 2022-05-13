part of '../services.dart';

class APIUser {
  AccountController accountController = Get.find();
  dio_package.Dio dio = dio_package.Dio();

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<ResponseParser> loginUser({
    required String email,
    required String pass,
  }) async {
    ResponseParser parser = ResponseParser();
    try {
      if (!await hasNetwork()) {
        throw const SocketException('No Connection Available on your devices');
      }
      Map<String, dynamic> header = {
        'Accept': 'application/json',
        'Authorization': 'Bearer lsGPLl4k6Vc4J0VhnFaMBqetNtn1ofsB',
      };
      dio_package.FormData formdata = dio_package.FormData.fromMap({
        "email": email,
        "password": pass,
      });
      final responseku = await dio.post(BaseUrl.login,
          data: formdata, options: dio_package.Options(headers: header));
      parser = ResponseParser.success(mapData: responseku.data);
      return parser;
    } on dio_package.DioError catch (e) {
      Map errorMessages = e.response!.data['errors'];
      String displayMessages = '';
      for (var element in errorMessages.values) {
        displayMessages = displayMessages + ' $element';
      }
      Map response = {
        'code': e.response!.statusCode,
        'message': displayMessages,
      };
      parser = ResponseParser.error(mapData: response);
      return parser;
    } on SocketException {
      showDefaultConnectionProblem();
      return parser;
    }
  }
}
