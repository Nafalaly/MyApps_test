part of '../services.dart';

class APIArticle {
  APIArticle();
  APIArticle.setAccountAttached({required this.account});
  late Account account;
  dio_package.Dio dio = dio_package.Dio();
  Future<ResponseParser> fetchArticles() async {
    ResponseParser parser = ResponseParser();
    try {
      if (!await hasNetwork()) {
        throw const SocketException('No Connection Available on your devices');
      }
      Map<String, dynamic> header = {
        'Accept': 'application/json',
        'Authorization': 'Bearer lsGPLl4k6Vc4J0VhnFaMBqetNtn1ofsB',
      };
      Map<String, dynamic> formdata = {
        "userName": account.email,
        "password": account.password,
        "usernameOrEmail": account.email,
      };
      final responseku = await dio.get(BaseUrl.fetchArticles,
          queryParameters: formdata,
          options: dio_package.Options(headers: header));
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
      Map response = {
        'code': 501,
        'message': 'Please make sure you have an active internet connection',
      };
      parser = ResponseParser.error(mapData: response);
      return parser;
    }
  }
}
