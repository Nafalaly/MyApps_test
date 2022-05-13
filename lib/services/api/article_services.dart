part of '../services.dart';

class APIArticle {
  dio_package.Dio dio = dio_package.Dio();
  Future<ResponseParser> fetchArticles() async {
    final AccountController accountController = Get.find();
    ResponseParser parser = ResponseParser();
    try {
      Map<String, dynamic> header = {
        'Accept': 'application/json',
        'Authorization': 'Bearer lsGPLl4k6Vc4J0VhnFaMBqetNtn1ofsB',
      };
      Map<String, dynamic> formdata = {
        "userName": accountController
            .getCurrentAccount()
            .email, //no username defined inside example response so i choose email instead
        "password": accountController.getCurrentAccount().password,
        "usernameOrEmail":
            accountController.getCurrentAccount().email, //or email ?
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
