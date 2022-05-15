part of '../pages.dart';

// ignore: must_be_immutable
class Dashboard extends StatelessWidget {
  Dashboard({Key? key, required this.account}) : super(key: key);
  final double welcomeHeight = 50;
  final double horizontalCompHeight = 175;
  final double verticalCompHeight = DeviceScreen.devHeight - 20;
  Account account;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: greyBackground,
        body: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultMargin, vertical: 10),
          height: DeviceScreen.devHeight,
          width: DeviceScreen.devWidth,
          child: BlocProvider(
            create: (context) =>
                DashboardBloc(account: account)..add(DashboardContentReload()),
            child: BlocListener<DashboardBloc, DashboardState>(
              listener: (context, state) {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  welcomeWidget(),
                  horizontalWidget(),
                  verticalWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<int> fetchArticles() async {
    // await _articleController.fetchArticles();
    return 0;
  }

  Widget verticalWidget() {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Container(
          height: verticalCompHeight -
              (welcomeHeight * 2 + horizontalCompHeight + 15 + 10),
          width: DeviceScreen.devWidth,
          margin: const EdgeInsets.only(top: 15),
          child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return false;
              },
              child: ListView(
                children: state.articleContentStatus is ContentReloading
                    ? List.generate(4, (index) => null).map((e) {
                        return VerticalArticleWidget();
                      }).toList()
                    : state.articles.map((e) {
                        return VerticalArticleWidget(article: e);
                      }).toList(),
              )),
        );
      },
    );
  }

  Widget horizontalWidget() {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          height: horizontalCompHeight,
          width: DeviceScreen.devWidth,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return false;
            },
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: state.articleContentStatus is ContentReloading
                  ? List.generate(4, (index) => null).map((e) {
                      return HorizontalArticleWidget();
                    }).toList()
                  : state.articles.reversed.map((e) {
                      return HorizontalArticleWidget(article: e);
                    }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget welcomeWidget() {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: welcomeHeight - 10,
              width: DeviceScreen.devWidth,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.wifi_off_sharp, color: Colors.white),
                  ),
                  Text('No internet connection available',
                      style: blackFontStyle2.copyWith(color: Colors.white))
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black87,
              ),
            ),
            Container(
              height: welcomeHeight - 10,
              margin: const EdgeInsets.symmetric(vertical: 5),
              width: state.articleContentStatus is ContentReloading
                  ? DeviceScreen.devWidth / 2
                  : DeviceScreen.devWidth,
              alignment: Alignment.centerLeft,
              decoration: state.articleContentStatus is ContentReloading
                  ? BoxDecoration(
                      color: greyColor.withOpacity(0.3),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [greyColor, Colors.white, greyColor]),
                      borderRadius: const BorderRadius.all(Radius.circular(10)))
                  : null,
              child: Builder(builder: (context) {
                if (state.articleContentStatus is ContentReloading) {
                  return const SizedBox();
                } else {
                  return RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: 'Welcome,', style: blackFontStyle),
                        TextSpan(
                            text: account.name,
                            style: blackFontStyle.copyWith(
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  );
                }
              }),
            ),
          ],
        );
      },
    );
  }
}
