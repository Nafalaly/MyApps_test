part of '../../pages.dart';

class DashboardState {
  List<Article> articles;
  late Account account;
  late ConnectivityState isHaveConnection;
  ContentStatus articleContentStatus;

  bool articleIsEmpty() => articles.isEmpty;

  DashboardState(
      {this.articles = const [],
      Account? account,
      ConnectivityState? connection,
      this.articleContentStatus = const InitialStatus()}) {
    this.account = account ?? Account.init();
  }

  DashboardState copyWith(
      {List<Article>? articles,
      Account? account,
      ConnectivityState? connectivity,
      ContentStatus? contentStatus}) {
    return DashboardState(
        articles: articles ?? this.articles,
        connection: connectivity ?? isHaveConnection,
        account: account ?? this.account,
        articleContentStatus: contentStatus ?? articleContentStatus);
  }
}
