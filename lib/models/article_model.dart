part of 'models.dart';

class Article {
  Article();
  late String uuid;
  late String title;
  late String content;
  late String image;
  late double
      views; //i choose double instead of int just in case the viewers above 32K
  Map timeInformation = {
    'date': 'No time specifed',
    'timezone_type': 'No timezone type specifed',
    'timezone': 'UTC',
  };
  late Account editor;
  factory Article.fromJson({required Map jsonData, String? password}) {
    Article newArticle = Article();
    newArticle.uuid = jsonData['uuid'];
    newArticle.title = jsonData['title'];
    newArticle.content = jsonData['content'];
    newArticle.views = double.parse(jsonData['views'].toString());
    newArticle.image = jsonData['image'];
    newArticle.timeInformation = jsonData['created'];
    newArticle.editor = Account.fromJson(jsonData: jsonData);
    return newArticle;
  }
}
