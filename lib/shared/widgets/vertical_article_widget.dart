part of '../shared.dart';

// ignore: must_be_immutable
class VerticalArticleWidget extends StatelessWidget {
  VerticalArticleWidget({Key? key, this.article}) : super(key: key);
  Article? article;
  final double _defaultWidth = DeviceScreen._width - 48;
  final double _defaultHeight = 160;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: _defaultHeight,
      width: _defaultWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: (_defaultHeight / 2) - 15,
                width: (_defaultHeight / 2) - 15,
                decoration: BoxDecoration(
                  color: greyColor.withOpacity(0.7),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: article == null
                    ? const SizedBox()
                    : ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: CachedNetworkImage(
                          imageUrl: article!.image,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: article == null ? greyColor.withOpacity(0.7) : null,
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                constraints: BoxConstraints(
                  maxWidth: _defaultWidth - ((_defaultHeight / 2) + 15),
                  minWidth: _defaultWidth / 2,
                  maxHeight: (_defaultHeight / 2) - 15,
                  minHeight: 20,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: article == null
                    ? const SizedBox()
                    : Text(
                        article!.title,
                        style: blackFontStyle2,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
              )
            ]),
            width: _defaultWidth,
            height: _defaultHeight / 2,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: article == null
                ? const SizedBox()
                : Text(
                    article!.content,
                    style: blackFontStyle2,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
            decoration: BoxDecoration(
                color: article == null ? greyColor.withOpacity(0.7) : null,
                borderRadius: const BorderRadius.all(Radius.circular(15))),
            constraints: BoxConstraints(
                minWidth: _defaultWidth,
                maxHeight: (_defaultHeight / 2) - 20,
                minHeight: ((_defaultHeight / 2) - 20) - 10),
          ),
          Container(
            width: _defaultWidth,
            height: 20,
            alignment: Alignment.centerRight,
            child: article == null
                ? Container(
                    height: 20,
                    width: _defaultWidth / 2,
                    decoration: BoxDecoration(
                        color: greyColor.withOpacity(0.7),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))))
                : Container(
                    margin: const EdgeInsets.only(right: 10),
                    alignment: Alignment.centerRight,
                    child: Text(dateFormat(
                        DateTime.parse(article!.timeInformation['date']))),
                  ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: article == null
              ? greyColor.withOpacity(0.3)
              : '#a0d6db'.toColor(),
          gradient: article == null
              ? LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [greyColor, Colors.white, greyColor])
              : null,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
    );
  }
}
