part of 'pages.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<Dashboard> {
  final double welcomeHeight = 50;
  final double horizontalCompHeight = 175;
  final double verticalCompHeight = DeviceScreen.devHeight - 20;
  final AccountController _accountController = Get.put(AccountController());
  final ArticleController _articleController = Get.put(ArticleController());

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
          child: FutureBuilder(
            future: fetchArticles(),
            builder: (
              BuildContext context,
              AsyncSnapshot snapshot,
            ) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  welcomeWidget(snapshot: snapshot),
                  horizontalWidget(snapshot: snapshot),
                  verticalWidget(snapshot: snapshot),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<int> fetchArticles() async {
    await _articleController.fetchArticles();
    return 0;
  }

  Widget verticalWidget({required AsyncSnapshot snapshot}) {
    return Container(
      height: verticalCompHeight - (welcomeHeight + horizontalCompHeight + 15),
      width: DeviceScreen.devWidth,
      margin: const EdgeInsets.only(top: 15),
      child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: ListView(
            children: snapshot.connectionState == ConnectionState.waiting
                ? List.generate(4, (index) => null).map((e) {
                    return VerticalArticleWidget();
                  }).toList()
                : _articleController.getArticles().map((e) {
                    return VerticalArticleWidget(article: e);
                  }).toList(),
          )),
    );
  }

  Widget horizontalWidget({required AsyncSnapshot snapshot}) {
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
          children: snapshot.connectionState == ConnectionState.waiting
              ? List.generate(4, (index) => null).map((e) {
                  return HorizontalArticleWidget();
                }).toList()
              : _articleController.getArticles().reversed.map((e) {
                  return HorizontalArticleWidget(article: e);
                }).toList(),
        ),
      ),
    );
  }

  Widget welcomeWidget({required AsyncSnapshot snapshot}) {
    return Container(
      height: welcomeHeight - 10,
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: snapshot.connectionState == ConnectionState.waiting
          ? DeviceScreen.devWidth / 2
          : DeviceScreen.devWidth,
      alignment: Alignment.centerLeft,
      decoration: snapshot.connectionState == ConnectionState.waiting
          ? BoxDecoration(
              color: greyColor.withOpacity(0.3),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [greyColor, Colors.white, greyColor]),
              borderRadius: const BorderRadius.all(Radius.circular(10)))
          : null,
      child: Builder(builder: (context) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const SizedBox();
          default:
            return RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: 'Welcome,', style: blackFontStyle),
                  TextSpan(
                      text: _accountController.getCurrentAccount().name,
                      style:
                          blackFontStyle.copyWith(fontWeight: FontWeight.w700)),
                ],
              ),
            );
        }
      }),
    );
  }
}
