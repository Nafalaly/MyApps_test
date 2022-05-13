part of 'controllers.dart';

class ArticleController extends GetxController {
  // ignore: prefer_final_fields
  List<Article> _articles = [];

  List<Article> getArticles() => _articles;

  Future<int> fetchArticles() async {
    APIArticle api = APIArticle();
    return await api.fetchArticles();
  }

  void setContents({required List<Article> newContent}) {
    _articles = newContent;
  }
}
