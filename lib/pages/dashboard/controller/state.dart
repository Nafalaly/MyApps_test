part of '../../pages.dart';

class DashboardState {
  List<Article> articles;
  late AccountBloc account;
  late ConnectivityState isHaveConnection;
  ContentStatus articleContentStatus;

  bool isConnectedToServer() => isHaveConnection is InternetConnected;

  bool articleIsEmpty() => articles.isEmpty;

  DashboardState(
      {this.articles = const [],
      AccountBloc? account,
      ConnectivityState? connection,
      this.articleContentStatus = const InitialStatus()}) {
    if (account != null) {
      this.account = account;
    }
    isHaveConnection = connection ?? InternetInitial();
  }

  DashboardState copyWith(
      {List<Article>? articles,
      ConnectivityState? connectivity,
      ContentStatus? contentStatus}) {
    return DashboardState(
        articles: articles ?? this.articles,
        connection: connectivity ?? isHaveConnection,
        articleContentStatus: contentStatus ?? articleContentStatus);
  }
}
