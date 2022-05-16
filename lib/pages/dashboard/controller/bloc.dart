part of '../../pages.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({
    required this.accountBloc,
    required this.connectivityCubit,
  }) : super(DashboardState(account: accountBloc)) {
    apiInitialization();
    monitorChanges();
    on(mapEvent);
  }
  final AccountBloc accountBloc;
  APIArticle apiArticle = APIArticle();
  ConnectivityCubit connectivityCubit;
  late StreamSubscription onListenConnectivity;

  void apiInitialization() {
    AccountAttached currentState = accountBloc.state as AccountAttached;
    Account data = currentState.account;
    apiArticle = APIArticle.setAccountAttached(account: data);
  }

  void monitorChanges() {
    onListenConnectivity = connectivityCubit.stream.listen((connectivity) {
      if (connectivity is InternetConnected) {
        emit(state.copyWith(connectivity: InternetConnected()));
      } else {
        emit(state.copyWith(connectivity: NoInternetConnections()));
      }
    });
  }

  Future<void> mapEvent(
      DashboardEvent event, Emitter<DashboardState> emit) async {
    if (event is DashboardContentReload) {
      emit(state.copyWith(contentStatus: const ContentReloading()));
      ResponseParser result = await apiArticle.fetchArticles();
      switch (result.getStatusCode) {
        case 200:
          List<Article> newContents = [];
          for (int i = 0; i < result.getData!['articles'].length; i++) {
            newContents.add(
                Article.fromJson(jsonData: result.getData!['articles'][i]));
          }
          emit(state.copyWith(
              contentStatus: const ContentSuccesfullyLoaded(),
              articles: newContents));
          break;
        default:
          emit(state.copyWith(
              contentStatus:
                  ContentFailedToLoad(failMessage: result.getMessage!)));
          break;
      }
    }
  }

  @override
  Future<void> close() {
    onListenConnectivity.cancel();
    return super.close();
  }
}
