part of '../services.dart';

class APIArticle {
  dio_package.Dio dio = dio_package.Dio();
  Future<int> fetchArticles() async {
    final AccountController accountController = Get.find();
    final ArticleController articleController = Get.find();
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
      if (parser.getStatus == ResponseStatus.success) {
        List<Article> newContent = [];
        for (int i = 0; i < parser.getData!['articles'].length; i++) {
          newContent
              .add(Article.fromJson(jsonData: parser.getData!['articles'][i]));
        }
        articleController.setContents(newContent: newContent);
        return parser.getStatusCode!;
      } else {
        return parser.getStatusCode!;
      }
    } on Exception {
      return 400;
    }
  }
}
