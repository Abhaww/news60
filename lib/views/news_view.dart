import 'dart:ui';
import 'package:news60/custom_widgets/news_card_components/video_player.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news360_api/api_calls.dart';
import 'package:news360_api/models/news_data_model/news_tags-model.dart';
import 'package:news60/bloc/bookmark/bookmark_blog.dart';
import 'package:news60/bloc/bookmark/bookmark_event.dart';
import 'package:news60/bloc/bookmark/bookmark_state.dart';
import 'package:news60/components/colors.dart';
import 'package:news60/components/global.dart';
import 'package:news60/components/text_styles.dart';
import 'package:news60/configs/local_bookmark_config.dart';
import 'package:news60/custom_widgets/news_card_components/news_card_bottom_action_bar.dart';
import 'package:news60/custom_widgets/news_card_components/news_card_bottom_bar.dart';
import 'package:news60/custom_widgets/collapsable_container.dart';
import 'package:news60/models/app_model.dart';
import 'package:news60/custom_widgets/menu_screen_components/tags_texts.dart';
import 'package:news60/screens/Tags_news_screen.dart';
import 'package:news60/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:news60/screens/Menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

class NewsView extends StatefulWidget {
  NewsView({
    Key? key,
    required this.image,
    required this.newsHeadline,
    required this.newsSource,
    required this.newsSummary,
    // required this.showHideBars,
    required this.tags,
    required this.newsId,
    required this.isBookmark,
    required this.datePublished,
    required this.newsType,
    required this.videoUrl,
  }) : super(key: key);
  final String image;
  final String newsHeadline;
  final String newsSource;
  final String newsSummary;
  final String newsId;
  final String isBookmark;
  final String datePublished;
  final String newsType;
  final String videoUrl;

  /// Till next version
  // final showHideBars;
  final List<NewsTags>? tags;

  @override
  NewsViewState createState() => NewsViewState();
}

class NewsViewState extends State<NewsView> {
  late var newsImage;

  @override
  void initState() {
    // TODO: implement initState
    var theImage = CachedNetworkImageProvider(
      widget.image,
    );
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => precacheImage(theImage, context));
    newsImage = theImage;
    super.initState();
  }

  // String formattedDates (String date){
  //   final String formattedDate = date.replaceAll('/', '-');
  //   final List<String> splitedDates = formattedDate.split('A');
  //   final String splitDate = '20' + splitedDates[0];
  //   return splitDate.trimRight();
  // }
  @override
  Widget build(BuildContext context) {
    ScreenshotController _screenshotController = ScreenshotController();
    final datePublished = DateTime.parse(widget.datePublished);
    final String date = timeago.format(datePublished);
    List<Widget> tags = widget.tags != null
        ? List.generate(
            widget.tags!.length,
            (index) => HashTags(
                text: '#${widget.tags![index].tagName}',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TagProvider(
                        type: event.FromTag,
                        tagIdCatIdOrUserId: widget.tags![index].tagId,
                        tagNameCatNameOrDeviceId: widget.tags![index].tagName,
                      ),
                    ),
                  );
                }),
          )
        : [];
    GlobalKey key = GlobalKey();
    // BlocProvider(
    //     create: (context) => BookmarkBloc(
    //       ApiCalls(),
    //     ),
    buildScreenshot() {
      return RepaintBoundary(
        key: key,
        child: Container(
          color: AppColor.background,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              widget.newsType == '3'
                  ? FractionallySizedBox(
                      heightFactor: 1.0,
                      widthFactor: 1.0,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          FractionallySizedBox(
                            heightFactor: 1.0,
                            widthFactor: 1.0,
                            alignment: Alignment.topCenter,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              // alignment: Alignment.topCenter,
                              imageUrl: widget.image,
                              placeholder: (context, url) {
                                return SizedBox(
                                  child: Shimmer.fromColors(
                                    child: Container(
                                      color: Colors.red,
                                      alignment: Alignment.topCenter,
                                    ),
                                    baseColor: AppColor.grey400,
                                    highlightColor: AppColor.grey300,
                                  ),
                                );
                              },
                              errorWidget: (context, url, widget) {
                                return Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/news360_logo.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          FractionallySizedBox(
                            heightFactor: 0.13,
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              // height: 100.0,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black.withOpacity(0.5),
                              child: Column(
                                children: [
                                  Text(
                                    widget.newsHeadline,
                                    softWrap: true,
                                    style: AppTextStyle.newsTitle,
                                    textAlign: TextAlign.left,
                                  ),
                                  Row(
                                    children: tags,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : FractionallySizedBox(
                      heightFactor: 1.0,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          FractionallySizedBox(
                            alignment: Alignment.topCenter,
                            heightFactor: 0.4,
                            child: widget.newsType == '2'
                                ? VideoPlayerScreen(url: widget.videoUrl)
                                : Stack(
                                    fit: StackFit.expand,
                                    children: <Widget>[
                                      Container(
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: AppColor.surface,
                                          image: DecorationImage(
                                            image: newsImage,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        //  color: Colors.white,
                                        child: ClipRRect(
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 10,
                                                sigmaY: 10,
                                                tileMode: TileMode.decal),
                                            child: Container(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        // onTap: () => Router.navigator.pushNamed(
                                        //   Router.expandedImageView,
                                        //   arguments: ExpandedImageViewArguments(
                                        //     image: article.urlToImage,
                                        //   ),
                                        // ),
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Center(
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              alignment: Alignment.topCenter,
                                              imageUrl: widget.image,
                                              placeholder: (context, url) {
                                                return SizedBox(
                                                  child: Shimmer.fromColors(
                                                    child: Container(
                                                      color: Colors.red,
                                                      alignment:
                                                          Alignment.topCenter,
                                                    ),
                                                    baseColor: AppColor.grey400,
                                                    highlightColor:
                                                        AppColor.grey300,
                                                  ),
                                                );
                                              },
                                              errorWidget:
                                                  (context, url, widget) {
                                                return Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/images/news360_logo.png'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                          FractionallySizedBox(
                            alignment: Alignment.bottomCenter,
                            heightFactor: 0.6,
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                /// News Headline and News description
                                FractionallySizedBox(
                                  alignment: Alignment.topCenter,
                                  heightFactor: 0.85,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 25, 16, 16),
                                    child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: Text(
                                                widget.newsHeadline,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 4,
                                                style: AppTextStyle.newsTitle,
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              widget.newsSummary,
                                              style: AppTextStyle.newsSubtitle,
                                              overflow: TextOverflow.fade,
                                              textAlign: TextAlign.justify,
                                              maxLines: 9,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'scorri sinistra per ulteriori su ${widget.newsSource}/$date',
                                                textAlign: TextAlign.end,
                                                softWrap: true,
                                                style: AppTextStyle.newsFooter,
                                                overflow: TextOverflow.fade,
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          children: tags,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      );
    }

    return BlocProvider(
      create: (context) => BookmarkBloc(ApiCalls()),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AppModels(),
          ),
          ChangeNotifierProvider(
            create: (context) => Utils(),
          ),
        ],
        child: Material(
          child: GestureDetector(
            // onTap: widget.showHideBars,
            child: Container(
              constraints: BoxConstraints(
                minHeight: Global.height(context),
                minWidth: double.maxFinite,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 0.3),
              ),
              child: RepaintBoundary(
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      widget.newsType == '3'
                          ? FractionallySizedBox(
                              heightFactor: 1.0,
                              widthFactor: 1.0,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  FractionallySizedBox(
                                    heightFactor: 1.0,
                                    widthFactor: 1.0,
                                    alignment: Alignment.topCenter,
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      // alignment: Alignment.topCenter,
                                      imageUrl: widget.image,
                                      placeholder: (context, url) {
                                        return SizedBox(
                                          child: Shimmer.fromColors(
                                            child: Container(
                                              color: Colors.red,
                                              alignment: Alignment.topCenter,
                                            ),
                                            baseColor: AppColor.grey400,
                                            highlightColor: AppColor.grey300,
                                          ),
                                        );
                                      },
                                      errorWidget: (context, url, widget) {
                                        return Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/news360_logo.png'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    top: MediaQuery.of(context).size.height *
                                        0.7,
                                    // alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 100.0,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.black.withOpacity(0.5),
                                      child: Column(
                                        children: [
                                          Text(
                                            widget.newsHeadline,
                                            // overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            // maxLines: 4,
                                            style: AppTextStyle.newsTitle,
                                            textAlign: TextAlign.left,
                                          ),
                                          Row(
                                            children: tags,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : FractionallySizedBox(
                              heightFactor: 1.0,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  FractionallySizedBox(
                                    alignment: Alignment.topCenter,
                                    heightFactor: 0.4,
                                    child: widget.newsType == '2'
                                        ? VideoPlayerScreen(
                                            url: widget.videoUrl)
                                        : Stack(
                                            fit: StackFit.expand,
                                            children: <Widget>[
                                              Container(
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: AppColor.surface,
                                                  image: DecorationImage(
                                                    image: newsImage,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                //  color: Colors.white,
                                                child: ClipRRect(
                                                  child: BackdropFilter(
                                                    filter: ImageFilter.blur(
                                                        sigmaX: 10,
                                                        sigmaY: 10,
                                                        tileMode:
                                                            TileMode.decal),
                                                    child: Container(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                // onTap: () => Router.navigator.pushNamed(
                                                //   Router.expandedImageView,
                                                //   arguments: ExpandedImageViewArguments(
                                                //     image: article.urlToImage,
                                                //   ),
                                                // ),
                                                child: Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: Center(
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      alignment:
                                                          Alignment.topCenter,
                                                      imageUrl: widget.image,
                                                      placeholder:
                                                          (context, url) {
                                                        return SizedBox(
                                                          child: Shimmer
                                                              .fromColors(
                                                            child: Container(
                                                              color: Colors.red,
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                            ),
                                                            baseColor: AppColor
                                                                .grey400,
                                                            highlightColor:
                                                                AppColor
                                                                    .grey300,
                                                          ),
                                                        );
                                                      },
                                                      errorWidget: (context,
                                                          url, widget) {
                                                        return Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/images/news360_logo.png'),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                  FractionallySizedBox(
                                    alignment: Alignment.bottomCenter,
                                    heightFactor: 0.6,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: <Widget>[
                                        /// News Headline and News description
                                        FractionallySizedBox(
                                          alignment: Alignment.topCenter,
                                          heightFactor: 0.85,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                16, 25, 16, 16),
                                            child: Column(
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {},
                                                      child: Text(
                                                        widget.newsHeadline,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 4,
                                                        style: AppTextStyle
                                                            .newsTitle,
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      widget.newsSummary,
                                                      style: AppTextStyle
                                                          .newsSubtitle,
                                                      overflow:
                                                          TextOverflow.fade,
                                                      textAlign:
                                                          TextAlign.justify,
                                                      maxLines: 9,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        'scorri sinistra per ulteriori su ${widget.newsSource}/$date',
                                                        textAlign:
                                                            TextAlign.end,
                                                        softWrap: true,
                                                        style: AppTextStyle
                                                            .newsFooter,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                                Row(
                                                  children: tags,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      Consumer<Utils>(
                        builder: (context, utils, child) {
                          /// News Card Bottom Bar
                          return FractionallySizedBox(
                            alignment: Alignment.bottomCenter,
                            heightFactor: 0.11,
                            child: Center(
                              child: ValueListenableBuilder(
                                  valueListenable:
                                      Hive.box('bookmark').listenable(),
                                  builder: (context, Box box, childs) {
                                    List newsIds = box.values.toList();
                                    return BlocListener<BookmarkBloc,
                                        BookmarkState>(
                                      listener: (context, state) {
                                        if (state
                                            is BookmarkSavedRemovedState) {
                                          if (newsIds.contains(widget.newsId)) {
                                            removeBookmark(widget.newsId);
                                            Utils.showToast(
                                                state.bookmarked.msg);
                                          } else {
                                            saveBookmark(widget.newsId);
                                            Utils.showToast(
                                                state.bookmarked.msg);
                                          }
                                        }
                                      },
                                      child: BottomActionBar(
                                        newsType: widget.newsType,
                                        iconData: newsIds
                                                    .contains(widget.newsId) ==
                                                true
                                            ? Icons.bookmark
                                            : Icons.bookmark_border_outlined,
                                        shareScreenshot: () async {
                                          if (widget.newsType != '2') {
                                            final image =
                                                await _screenshotController
                                                    .captureFromWidget(
                                                        buildScreenshot(),
                                                        delay: Duration(
                                                            milliseconds: 20));
                                            Utils.shareImage(image);
                                          } else {
                                            Utils.showToast(
                                                'Can\'t do screenshot');
                                          }
                                        },
                                        saveScreenshot: () async {
                                          if (widget.newsType != '2') {
                                            final image =
                                                await _screenshotController
                                                    .captureFromWidget(
                                                        buildScreenshot(),
                                                        delay: Duration(
                                                            milliseconds: 20));
                                            Utils.saveImage(image);
                                          } else {
                                            Utils.showToast(
                                                'Can\'t do screenshot');
                                          }
                                        },
                                        bookmark: () {
                                          final String deviceid =
                                              Hive.box('deviceInfo')
                                                  .get('deviceId');
                                          final String userid =
                                              Hive.box('deviceInfo')
                                                  .get('userId');
                                          final bookmarkBloc =
                                              BlocProvider.of<BookmarkBloc>(
                                                  context);
                                          bookmarkBloc.add(
                                              newsIds.contains(widget.newsId) ==
                                                      true
                                                  ? RemoveBookmarkEvent(
                                                      deviceId: deviceid,
                                                      userId: userid,
                                                      newsId: widget.newsId)
                                                  : SaveBookmarkEvent(
                                                      deviceId: deviceid,
                                                      userId: userid,
                                                      newsId: widget.newsId));
                                        },
                                      ),
                                    );
                                  }),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
