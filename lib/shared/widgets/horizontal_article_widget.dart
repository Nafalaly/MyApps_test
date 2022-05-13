part of '../shared.dart';

// ignore: must_be_immutable
class HorizontalArticleWidget extends StatelessWidget {
  HorizontalArticleWidget({Key? key, this.article}) : super(key: key);
  Article? article;
  final double _defaultWidth = 200;
  final double _defaultHeight = 160;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: _defaultHeight,
      width: _defaultWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: _defaultWidth * 3 / 4,
            height: 30,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: article == null ? greyColor : greyBackground,
                borderRadius: article == null
                    ? const BorderRadius.all(Radius.circular(10))
                    : null),
            child: article != null
                ? Text(
                    article!.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: blackFontStyle2.copyWith(
                        fontWeight: FontWeight.bold, color: mainColor),
                  )
                : const SizedBox(),
          ),
          article != null
              ? Container(
                  height: _defaultHeight - 40,
                  width: _defaultWidth,
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  child: Text(
                    article!.content,
                    style: blackFontStyle2,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 6,
                  ),
                )
              : const SizedBox()
        ],
      ),
      decoration: BoxDecoration(
          color: article == null ? greyColor.withOpacity(0.3) : greyBackground,
          gradient: article == null
              ? LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [greyColor, Colors.white, greyColor])
              : null,
          border: Border.all(
            color: article == null ? Colors.transparent : mainColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
    );
  }
}
