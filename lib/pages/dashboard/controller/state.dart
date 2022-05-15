part of '../../pages.dart';

class DashboardState {
  List<Article> articles;
  late Account account;
  ContentStatus articleContentStatus;

  bool articleIsEmpty() => articles.isEmpty;

  DashboardState(
      {this.articles = const [],
      Account? account,
      this.articleContentStatus = const InitialStatus()}) {
    this.account = account ?? Account.init();
  }

  DashboardState copyWith(
      {List<Article>? articles,
      Account? account,
      ContentStatus? contentStatus}) {
    return DashboardState(
        articles: articles ?? this.articles,
        account: account ?? this.account,
        articleContentStatus: contentStatus ?? articleContentStatus);
  }
}
