import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news360_api/api_calls.dart';
import 'package:news60/bloc/bookmark/bookmark_blog.dart';
import 'package:news60/bloc/feeds_bloc/bloc_observer.dart';
import 'package:news60/bloc/feeds_bloc/news_feed_bloc.dart';
import 'package:news60/bloc/feeds_bloc/news_feed_events.dart';
import 'package:news60/bloc/feeds_bloc/news_feed_state.dart';
import 'package:news60/components/colors.dart';
import 'package:news60/components/text_styles.dart';
import 'package:news60/configs/local_news_engines.dart';
import 'package:news60/configs/news_manager.dart';
import 'package:news60/configs/settings_config.dart';
import 'package:news60/custom_widgets/collapsable_container.dart';
import 'package:news60/custom_widgets/custom_appbar.dart';
import 'package:news60/custom_widgets/iconize_button.dart';
import 'package:news60/custom_widgets/transformer.dart';
import 'package:news60/models/app_model.dart';
import 'package:news60/screens/Menu.dart';
import 'package:news60/screens/web_view.dart';
import 'package:news60/views/news_view.dart';
import 'package:provider/provider.dart';
import 'package:news60/utils/utils.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

import 'settings_page.dart';

class Providers extends StatelessWidget {
  const Providers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => NewsFeedBloc(
          ApiCalls(),
        ),
      ),
      // BlocProvider(
      //   create: (context) => BookmarkBloc(
      //     ApiCalls(),
      //   ),
    ], child: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late PageController _pageController;
  IndexController _indexController = IndexController();
  // ScreenshotController screenshotController = ScreenshotController();
  // late var bookmarkBloc;
  bool onWillPop() {
    if (_pageController.page!.round() == 0) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 20),
        curve: Curves.linear,
      );
      return false;
    } else if (_pageController.page!.round() == 2) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 20),
        curve: Curves.linear,
      );
      return false;
    } else {
      return true;
    }
  }

  final snackBar = SnackBar(
    content: Text('Bookmarked!'),
  );
  Utils _utils = Utils();
  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: 1, keepPage: true);
    final String deviceid = Hive.box('deviceInfo').get('deviceId');
    final newsFeedBloc = BlocProvider.of<NewsFeedBloc>(context);
    newsFeedBloc.add(
      FetchNewsDataEvent(deviceId: deviceid),
    );
    print('device id: ${deviceid}');
    // bookmarkBloc = BlocProvider.of<BookmarkBloc>(context);
    super.initState();
  }

  int pageIndex = 1;
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    super.build(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Utils(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppModels(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => Configs(),
        // ),
      ],
      child: Consumer<AppModels>(
        builder: (context, appModels, childs) => Scaffold(
          // appBar: appModels.index == 0 || appModels.index == 1
          //     ? AppBar(
          //         titleTextStyle: AppTextStyle.customAppBarNextTitleStyle,
          //         leadingWidth: 100.0,
          //         centerTitle: true,
          //         leading: ValueListenableBuilder(
          //           valueListenable: Hive.box(Configs.darkModeBox).listenable(),
          //           builder: (context, Box box, childs) {
          //             bool darkMode = box.get('darkMode', defaultValue: true);
          //             if (appModels.index == 0) {
          //               return IconButton(
          //                 onPressed: () {
          //                   Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                       builder: (context) => SettingsScreen(),
          //                     ),
          //                   );
          //                 },
          //                 icon: Icon(
          //                   Icons.settings,
          //                   size: 25.0,
          //                   color: darkMode == true
          //                       ? AppColor.background
          //                       : AppColor.primary,
          //                 ),
          //               );
          //             } else {
          //               return Row(
          //                 children: [
          //                   IconButton(
          //                     onPressed: () {
          //                       _pageController.previousPage(
          //                           duration: Duration(milliseconds: 200),
          //                           curve: Curves.easeIn);
          //                     },
          //                     icon: Icon(
          //                       FontAwesomeIcons.chevronLeft,
          //                       color: darkMode == true
          //                           ? AppColor.background
          //                           : AppColor.primary,
          //                       size: 20.0,
          //                     ),
          //                   ),
          //                   Text(
          //                     'Menu',
          //                     style: TextStyle(
          //                       fontSize: 20.0,
          //                       fontFamily: 'Roboto',
          //                       color: darkMode == true
          //                           ? AppColor.background
          //                           : AppColor.primary,
          //                     ),
          //                   ),
          //                 ],
          //               );
          //             }
          //           },
          //         ),
          //         title: ValueListenableBuilder(
          //             valueListenable:
          //                 Hive.box(Configs.darkModeBox).listenable(),
          //             builder: (context, Box box, childs) {
          //               bool darkMode = box.get('darkMode', defaultValue: true);
          //               final textStyle = TextStyle(
          //                 fontSize: 20.0,
          //                 fontFamily: 'Roboto',
          //                 color: darkMode == true
          //                     ? AppColor.background
          //                     : AppColor.primary,
          //               );
          //               return Column(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   appModels.index == 0
          //                       ? Text(
          //                           'Menu',
          //                           style: textStyle,
          //                           textAlign: TextAlign.center,
          //                         )
          //                       : Padding(
          //                           padding: const EdgeInsets.only(top: 8.0),
          //                           child: Text(
          //                             'Ultime notizie',
          //                             style: textStyle,
          //                             textAlign: TextAlign.center,
          //                           ),
          //                         ),
          //                   SizedBox(
          //                     height: 10.0,
          //                   ),
          //                   Container(
          //                     width: 40.0,
          //                     height: 3.0,
          //                     decoration: BoxDecoration(
          //                       color: darkMode == true
          //                           ? AppColor.background
          //                           : AppColor.primary,
          //                       borderRadius: BorderRadius.circular(100.0),
          //                     ),
          //                   ),
          //                 ],
          //               );
          //             }),
          //         actions: [
          //           ValueListenableBuilder(
          //             valueListenable:
          //                 Hive.box(Configs.darkModeBox).listenable(),
          //             builder: (context, Box box, childs) {
          //               bool darkMode = box.get('darkMode', defaultValue: true);
          //               if (appModels.index == 0) {
          //                 return Row(
          //                   children: [
          //                     SizedBox(
          //                       height: 10.0,
          //                     ),
          //                     Padding(
          //                       padding:
          //                           const EdgeInsets.symmetric(vertical: 10.0),
          //                       child: Text(
          //                         'Ultime notizie',
          //                         style: TextStyle(
          //                           fontSize: 20.0,
          //                           fontFamily: 'Roboto',
          //                           color: darkMode == true
          //                               ? AppColor.background
          //                               : AppColor.primary,
          //                         ),
          //                       ),
          //                     ),
          //                     // SizedBox(
          //                     //   width: 10.0,
          //                     // ),
          //                     IconButton(
          //                       onPressed: () {
          //                         _pageController.nextPage(
          //                             duration: Duration(milliseconds: 200),
          //                             curve: Curves.easeIn);
          //                       },
          //                       icon: Icon(
          //                         FontAwesomeIcons.chevronRight,
          //                         color: darkMode == true
          //                             ? AppColor.background
          //                             : AppColor.primary,
          //                         size: 20.0,
          //                       ),
          //                     ),
          //                   ],
          //                 );
          //               } else {
          //                 return Row(
          //                   children: [
          //                     Consumer<Utils>(
          //                       builder: (context, utils, childs) => IconButton(
          //                         onPressed: () {
          //                           /// TODO: Refresh news
          //                           if (utils.currentIndex != 0) {
          //                             _indexController.move(0);
          //                           } else {
          //                             final String deviceid =
          //                                 Hive.box('deviceInfo')
          //                                     .get('deviceId');
          //                             final newsFeedBloc =
          //                                 BlocProvider.of<NewsFeedBloc>(
          //                                     context);
          //                             newsFeedBloc.add(
          //                               FetchNewsDataEvent(deviceId: deviceid),
          //                             );
          //                           }
          //                         },
          //                         icon: Icon(
          //                           utils.currentIndex != 0
          //                               ? Icons.arrow_upward_outlined
          //                               : Icons.refresh,
          //                           color: darkMode == true
          //                               ? AppColor.background
          //                               : AppColor.primary,
          //                           size: 25.0,
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 );
          //               }
          //             },
          //           ),
          //         ],
          //       )
          //     : null,
          body: BlocBuilder<NewsFeedBloc, NewsFeedState>(
            builder: (context, state) {
              if (state is LoadingNewsFeedState) {
                return Center(
                  child: Text(
                    'Fetching News....',
                    style: AppTextStyle.newsTitle,
                  ),
                );
              } else if (state is LoadedNewsFeedState) {
                // List<Key> _newsKey = List<Key>.generate(
                //     state.news.length, (index) => Key('newsKey$index'));
                // final List<String> newsImages = List.generate(
                //   state.news.length,
                //   (index) => state.news[index].imagePath,
                //   growable: false,
                // );
                // void loadImages() {
                //   newsImages
                //       .map((urlImage) => Utils.cacheImage(context, urlImage));
                // }
                //
                // loadImages();
                // List readNewsId = getNewsIdList();
                // List<NewsData> news = newsClassifier(state.news, readNewsId);
                // print(news.length);
                // deleteData();
                // Provider.of<Utils>(context, listen: false)
                //     .preCacheImages(state.news.length, context, newsImages);
                List<String> newsIdentity = List.generate(
                  state.news.length,
                  (index) => state.news[index].newsId,
                );
                int lastIndex = lastNewsIndex(newsIdentity);
                Provider.of<Utils>(context, listen: false)
                    .getCurrentIndex(lastIndex);
                Provider.of<Utils>(context, listen: false)
                    .assignData(state.news);
                return SafeArea(
                  child: Column(
                    children: [
                      ValueListenableBuilder(
                        valueListenable:
                            Hive.box(Configs.darkModeBox).listenable(),
                        builder: (context, Box box, childs) {
                          bool darkMode =
                              box.get('darkMode', defaultValue: true);
                          return Consumer<AppModels>(
                            builder: (context, appModel, childs) =>
                                CollapsableContainer(
                              color: darkMode
                                  ? AppColor.darkThemeColor
                                  : AppColor.background,
                              height: 60.0,
                              isVisible: appModel.topVisibleOnOff,
                              topAppBarPadding: true,
                              child: Consumer<Utils>(
                                builder: (context, utils, childs) =>
                                    CustomAppBar(
                                  color: darkMode
                                      ? AppColor.background
                                      : AppColor.primary,
                                  pageController: _pageController,
                                  index: appModel.index,
                                  iconButton: IconButton(
                                    onPressed: () {
                                      /// TODO: Refresh news
                                      if (utils.currentIndex != 0) {
                                        _indexController.move(0);
                                      } else {
                                        final String deviceid =
                                            Hive.box('deviceInfo')
                                                .get('deviceId');
                                        final newsFeedBloc =
                                            BlocProvider.of<NewsFeedBloc>(
                                                context);
                                        newsFeedBloc.add(
                                          FetchNewsDataEvent(
                                              deviceId: deviceid),
                                        );
                                      }
                                    },
                                    icon: Icon(
                                      utils.currentIndex != 0
                                          ? Icons.arrow_upward_outlined
                                          : Icons.refresh,
                                      color: darkMode == true
                                          ? AppColor.background

                                          : AppColor.primary,
                                      size: 25.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Expanded(
                        child: PageView.builder(
                            itemCount: 3,
                            controller: _pageController,
                            onPageChanged: (index) {
                              // setState(() {
                              //   pageIndex = index;
                              // });
                              Provider.of<AppModels>(context, listen: false)
                                  .pageViewIndex(index);
                              // Provider.of<AppModels>(context, listen: false)
                              //     .automaticallyHideBottomBar(index);
                              Provider.of<AppModels>(context, listen: false)
                                  .automaticHideBars(index);
                              Provider.of<AppModels>(context, listen: false)
                                  .automaticShowBars(index);
                              print(index);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return index == 0
                                  ? WillPopScope(
                                      onWillPop: () => Future.sync(onWillPop),
                                      child: MenuProvider(),
                                    )
                                  : index == 1
                                      ? DoubleBackToCloseApp(
                                          snackBar: SnackBar(
                                            content: Text(
                                              'Tap back again to leave',
                                              style: AppTextStyle.newsTitle,
                                            ),
                                          ),
                                          child: Consumer<Utils>(
                                            builder: (context, utils, child) =>
                                                TransformerPageView(
                                              index: utils.currentIndex,
                                              controller: _indexController,
                                              onPageChanged: (index) {
                                                Provider.of<Utils>(context,
                                                        listen: false)
                                                    .getCurrentIndex(index);
                                                addNewsIdWithTime(utils
                                                    .newsLoaded[index].newsId);
                                                getNewsId();
                                              },
                                              scrollDirection: Axis.vertical,
                                              transformer:
                                                  DepthPageTransformer(),
                                              curve: Curves.easeInBack,
                                              itemCount:
                                                  utils.newsLoaded.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return NewsView(
                                                  newsId: utils
                                                      .newsLoaded[index].newsId,
                                                  image: utils.newsLoaded[index]
                                                      .imagePath,
                                                  tags: utils.newsLoaded[index]
                                                      .tagList,
                                                  newsHeadline: utils
                                                      .newsLoaded[index]
                                                      .newsTitle,
                                                  newsSource: utils
                                                      .newsLoaded[index]
                                                      .provider,
                                                  newsSummary: utils
                                                      .newsLoaded[index]
                                                      .newsSummary,
                                                  isBookmark: utils.newsLoaded[index].isBookmark,
                                                  datePublished: utils.newsLoaded[index].datePublished,
                                                  newsType: utils.newsLoaded[index].newsType,
                                                  videoUrl: utils.newsLoaded[index].videoPath,
                                                  // showHideBars: () {
                                                  //   Provider.of<AppModels>(
                                                  //           context,
                                                  //           listen: false)
                                                  //       .showAndHideTopAndBottomBar();
                                                  // },
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      : WillPopScope(
                                          onWillPop: () =>
                                              Future.sync(onWillPop),
                                          child: WebScreen(
                                            url: Provider.of<Utils>(context,
                                                    listen: false)
                                                .getUrl(),
                                            onTap: () {
                                              _pageController.previousPage(
                                                  duration: Duration(
                                                      milliseconds: 20),
                                                  curve: Curves.easeIn);
                                            },
                                          ),
                                        );
                            }),
                      ),

                      // Consumer<AppModels>(
                      //   builder: (context, appModel, child) => Align(
                      //     alignment: Alignment.topCenter,
                      //     child: CollapsableContainer(
                      //       // color: configs.cont ? AppColor.background : AppColor.darkThemeColor,
                      //       height: 60.0,
                      //       isVisible: appModel.topVisibleOnOff,
                      //       topAppBarPadding: true,
                      //       child: CustomAppBar(
                      //         pageController: _pageController,
                      //         index: appModel.index,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Consumer<AppModels>(
                      //   builder: (context, appModel, child) => Consumer<Configs>(
                      //     builder: (context, configs, widget) => Align(
                      //       alignment: Alignment.bottomCenter,
                      //       child: CollapsableContainer(
                      //         //  color: !configs.darkMode ? AppColor.background : AppColor.darkThemeColor,
                      //         height: 65.0,
                      //         isVisible: appModel.bottomVisibleOnOff,
                      //         child: Material(
                      //           child: Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               IconizeButton(
                      //                 iconData: FontAwesomeIcons.shareAlt,
                      //                 onPress: () async {
                      //                   Provider.of<Utils>(context)
                      //                       .showWatermark();
                      //
                      //                   //  Future.delayed(Duration(seconds: 2), () => Utils.saveNewsImage(context, Utils.containerKey));
                      //                   Provider.of<Utils>(context)
                      //                       .hideWatermark();
                      //                 },
                      //               ),
                      //               IconizeButton(
                      //                 iconData: FontAwesomeIcons.download,
                      //                 onPress: () async {
                      //                   Provider.of<Utils>(context, listen: false)
                      //                       .showWatermark();
                      //                   final image = await Utils
                      //                       .screenshotController
                      //                       .capture();
                      //                   if (image == null) {
                      //                     print('error');
                      //                   }
                      //                   await Utils.saveImage(image);
                      //                   Provider.of<Utils>(context, listen: false)
                      //                       .hideWatermark();
                      //                 },
                      //               ),
                      //               Consumer<Utils>(
                      //                 builder: (context, utils, child) =>
                      //                     IconizeButton(
                      //                         iconData: FontAwesomeIcons.bookOpen,
                      //                         onPress: () {
                      //                           bookmarkBloc.add(
                      //                             SaveBookmarkEvent(
                      //                                 deviceId: utils.deviceId,
                      //                                 userId: utils.userId,
                      //                                 newsId: utils
                      //                                     .newsLoaded[
                      //                                         utils.currentIndex]
                      //                                     .newsId),
                      //                           );
                      //                         }),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                );
              }
              return Text(
                'Failed to Fetch News',
                style: AppTextStyle.newsTitle,
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
