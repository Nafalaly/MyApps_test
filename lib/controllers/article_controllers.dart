part of 'controllers.dart';

class ArticleController extends GetxController {
  // ignore: prefer_final_fields
  List<Article> _articles = [];

  List<Article> getArticles() => _articles;

  Future<void> fetchArticles() async {
    APIArticle api = APIArticle();
    ResponseParser result = await api.fetchArticles();
    if (result.getStatus == ResponseStatus.success) {
      List<Article> newContent = [];
      for (int i = 0; i < result.getData!['articles'].length; i++) {
        newContent
            .add(Article.fromJson(jsonData: result.getData!['articles'][i]));
      }
      setContents(newContent: newContent);
    } else {
      switch (result.getStatusCode) {
        case 501:
          showDefaultConnectionProblem();
          break;
        default:
          showInternalErrorPopUp(message: result.getMessage!);
          break;
      }
    }
  }

  void setContents({required List<Article> newContent}) {
    _articles = newContent;
  }
}
