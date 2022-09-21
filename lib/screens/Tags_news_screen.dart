import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:news360_api/api_calls.dart';
import 'package:news60/bloc/bookmark/bookmark_blog.dart';
import 'package:news60/bloc/bookmark/bookmark_event.dart';
import 'package:news60/bloc/feeds_bloc/news_feed_bloc.dart';
import 'package:news60/bloc/feeds_bloc/news_feed_events.dart';
import 'package:news60/bloc/feeds_bloc/news_feed_state.dart';
import 'package:news60/components/colors.dart';
import 'package:news60/components/text_styles.dart';
import 'package:news60/configs/settings_config.dart';
import 'package:news60/custom_widgets/collapsable_container.dart';
import 'package:news60/custom_widgets/iconize_button.dart';
import 'package:news60/custom_widgets/transformer.dart';
import 'package:news60/models/tags_search_category_home_screens_models.dart';
import 'package:news60/screens/Menu.dart';
import 'package:news60/screens/web_view.dart';
import 'package:news60/utils/utils.dart';
import 'package:news60/views/news_view.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class TagProvider extends StatelessWidget {
  final String tagIdCatIdOrUserId;
  final String tagNameCatNameOrDeviceId;
  final event type;
  TagProvider({Key? key, required this.tagIdCatIdOrUserId, required this.tagNameCatNameOrDeviceId, required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NewsFeedBloc(
          ApiCalls(),
        ),
        child: TagOrCategoryHomeScreen(tagIdCatIdOrUserId: tagIdCatIdOrUserId, tagCatNameOrDeviceId: tagNameCatNameOrDeviceId, type: type,)
    );
  }
}

class TagOrCategoryHomeScreen extends StatefulWidget {
  final String tagIdCatIdOrUserId;
  final String tagCatNameOrDeviceId;
  final event type;
  TagOrCategoryHomeScreen({Key? key, required this.tagIdCatIdOrUserId, required this.tagCatNameOrDeviceId, required this.type});
  @override
  _TagOrCategoryHomeScreenState createState() => _TagOrCategoryHomeScreenState();
}

class _TagOrCategoryHomeScreenState extends State<TagOrCategoryHomeScreen> with AutomaticKeepAliveClientMixin{
  Utils _utils = Utils();
  late PageController _pageController;
  TransformerPageController _transformerPageController = TransformerPageController(keepPage: true);
  int newsIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: 0);
    final _newsBloc = BlocProvider.of<NewsFeedBloc>(context);
    final String deviceId = Hive.box('deviceInfo').get('deviceId');
    String userid = Hive.box('deviceInfo').get('userId');
  if(widget.type == event.FromTag){
    _newsBloc.add(FetchNewsDataByTagEvent(deviceId: deviceId, tagId: widget.tagIdCatIdOrUserId),);
  }else if(widget.type == event.FromCategory){
    _newsBloc.add(FetchNewsDataByCategoryEvent(deviceId: deviceId, catId: widget.tagIdCatIdOrUserId),);
  }else{
    _newsBloc.add(GetBookmarkDataEvent(deviceId: deviceId, userId: userid),);
  }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Utils(),
          ),
          ChangeNotifierProvider(
              create: (context) => STCHomeScreensModel(),
          ),
        ],
        child: Scaffold(
            // appBar: searchModel.currentIndex == 0 ? AppBar(
            //   leadingWidth: double.infinity,
            //   leading: ValueListenableBuilder(
            //     valueListenable: Hive.box(Configs.darkModeBox).listenable(),
            //     builder: (context, Box box, childs) {
            //       bool darkMode = box.get('darkMode', defaultValue: true);
            //       return Row(
            //         children: [
            //           IconButton(
            //             onPressed: () {
            //               _pageController.previousPage(
            //                   duration: Duration(milliseconds: 200),
            //                   curve: Curves.easeIn);
            //             },
            //             icon: IconButton(
            //               onPressed: (){
            //                 Navigator.pop(context);
            //               },
            //               icon: Icon(
            //                 FontAwesomeIcons.chevronLeft,
            //                 color: darkMode ? AppColor.background : AppColor.primary,
            //                 size: 20.0,
            //               ),
            //             ),
            //           ),
            //           // SizedBox(
            //           //   width: 10.0,
            //           // ),
            //           Text(
            //             widget.tagCatNameOrDeviceId,
            //             style: TextStyle(
            //               fontSize: 18.0,
            //               fontFamily: 'Roboto',
            //               color: darkMode == true
            //                   ? AppColor.background
            //                   : AppColor.primary,
            //             ),
            //           ),
            //         ],
            //       );
            //     }
            //   ),
            //
            // ): null,
            body: Container(
              child:  BlocBuilder<NewsFeedBloc, NewsFeedState>(
                builder: (context, state){
                  if(state is LoadingNewsFeedState){
                    return Center(
                      child: ValueListenableBuilder(
                        valueListenable: Hive.box(Configs.darkModeBox).listenable(),
                        builder: (context, Box box, childs){
                          bool darkMode = box.get('darkMode', defaultValue: true);
                          return CircularProgressIndicator(
                            color: darkMode == true
                                ? AppColor.background
                                : AppColor.primary,
                          );
                        }
                      ),
                    );
                  }else if (state is LoadedNewsFeedState){
                    print(state.news);
                    if(state.news.isNotEmpty){
                      final List<String> searchNewsImages = List.generate(
                        state.news.length,
                            (index) => state.news[index].imagePath,
                        growable: false,
                      );
                      void loadImages () {
                        searchNewsImages.map((urlImage) => Utils.cacheImage(context, urlImage));
                      }
                      loadImages();
                      return SafeArea(
                        child: Column(
                          children: [
                        Consumer<STCHomeScreensModel>(
                          builder: (context, searchModel, child) => Align(
                              alignment: Alignment.topCenter,
                              child: ValueListenableBuilder(
                                valueListenable: Hive.box(Configs.darkModeBox).listenable(),
                                builder: (context, Box box, widgets) {
                                  bool darkMode =  box.get('darkMode', defaultValue: true);
                                  final textStyle = TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Roboto',
                                    color: darkMode == true ? AppColor.background : AppColor.primary,
                                  );
                                  return CollapsableContainer(
                                    color: darkMode == true ? AppColor.background : AppColor.darkThemeColor,
                                    height: 52.0,
                                    isVisible: searchModel.topVisibleOnOff,
                                    topAppBarPadding: true,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              child: InkWell(
                                                onTap: (){
                                                  Navigator.pop(context);
                                  },
                                                child: Row(
                                            children: [
                                            Icon(
                                                FontAwesomeIcons.chevronLeft,
                                                color: darkMode == true ? AppColor.background : AppColor.primary,
                                                size: 20.0,
                                            ),
                                            SizedBox(
                                                width: 10.0,
                                            ),
                                            Text(
                                                'Menu',
                                                style: textStyle,
                                            ),
                                            ],
                                          ),
                                              ),
                                              alignment: Alignment.centerLeft,
                                            ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                widget.type == event.FromBookmark ? 'Bookmarks' : widget.tagCatNameOrDeviceId,
                                                style: textStyle,
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                height: 3.0,
                                              ),
                                              Container(
                                                width: 40.0,
                                                height: 3.0,
                                                decoration: BoxDecoration(
                                                  color: darkMode ? AppColor.background : AppColor.primary,
                                                  borderRadius: BorderRadius.circular(100.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                          ],
                                        ),
                                        // Row(
                                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //     children: [
                                        //   Expanded(
                                        //     child: Align(
                                        //       alignment: Alignment.centerLeft,
                                        //       child: Row(
                                        //         children: [
                                        //           Icon(
                                        //             FontAwesomeIcons.chevronLeft,
                                        //             color: AppColor.primary,
                                        //             size: 20.0,
                                        //           ),
                                        //           SizedBox(
                                        //             width: 10.0,
                                        //           ),
                                        //           Text(
                                        //             'Menu',
                                        //             style: textStyle,
                                        //           ),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ),
                                        //       Text(
                                        //         widget.type == event.FromBookmark ? 'Bookmarks' : widget.tagCatNameOrDeviceId,
                                        //         style: textStyle,
                                        //         textAlign: TextAlign.center,
                                        //       ),
                                        // ]),

                                      ],
                                    ),
                                  );
                                }
                            ),
                          ),
                        ),
                            Expanded(
                              child: PageView.builder(
                                itemCount: 2,
                                controller: _pageController,
                                onPageChanged: (index) {
                                  Provider.of<STCHomeScreensModel>(context, listen: false)
                                      .updateIndex(index);
                                  Provider.of<STCHomeScreensModel>(context, listen: false)
                                      .automaticHideBars(index);
                                  Provider.of<STCHomeScreensModel>(context, listen: false)
                                      .automaticShowBars(index);
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return index == 0
                                      ? TransformerPageView(
                                    index: newsIndex,
                                    onPageChanged: (index) {
                                      setState(() {
                                        newsIndex = index;
                                      });
                                    },
                                    scrollDirection: Axis.vertical,
                                    transformer: DepthPageTransformer(),
                                    curve: Curves.easeInBack,
                                    itemCount: state.news.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return NewsView(
                                        datePublished: state.news[newsIndex].datePublished,
                                        isBookmark: state.news[newsIndex].isBookmark,
                                        newsId: state.news[newsIndex].newsId,
                                        tags: state.news[newsIndex].tagList,
                                        image: searchNewsImages[index],
                                        newsHeadline:
                                        state.news[newsIndex].newsTitle,
                                        newsSource: state.news[newsIndex].provider,
                                        newsSummary:
                                        state.news[newsIndex].newsSummary,
                                        newsType: state.news[newsIndex].newsType, 
                                        videoUrl: state.news[newsIndex].videoPath,
                                        /// Till next version
                                        // showHideBars: () {
                                        //   Provider.of<STCHomeScreensModel>(context, listen: false)
                                        //       .showAndHideTopAndBottomBar();
                                        // },
                                      );
                                    },
                                  )
                                      : WebScreen(
                                    url: state.news[newsIndex].newsLink,
                                    onTap: (){
                                      _pageController.previousPage(duration: Duration(milliseconds: 20), curve: Curves.easeIn);
                                    },
                                  );
                                },
                              ),
                            ),
                            // Consumer<STCHomeScreensModel>(
                            //   builder: (context, searchModel, child) => Align(
                            //       alignment: Alignment.topCenter,
                            //       child: Consumer<Configs>(
                            //         builder: (context, configs, widget) => CollapsableContainer(
                            //        // color: !configs.darkMode ? AppColor.background : AppColor.darkThemeColor,
                            //         height: 52.0,
                            //         isVisible: searchModel.topVisibleOnOff,
                            //         topAppBarPadding: true,
                            //         child: Material(
                            //           child: Row(children: [
                            //             Expanded(
                            //               child: Align(
                            //                 alignment: Alignment.centerLeft,
                            //                 child: Row(
                            //                   children: [
                            //                     Icon(
                            //                       FontAwesomeIcons.chevronLeft,
                            //                       color: AppColor.primary,
                            //                       size: 20.0,
                            //                     ),
                            //                     SizedBox(
                            //                       width: 10.0,
                            //                     ),
                            //                     // Text(
                            //                     //   widget,
                            //                     //   style: AppTextStyle.customAppBarNextTitleStyle,
                            //                     // ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ),
                            //           ]),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Consumer<STCHomeScreensModel>(
                            //   builder: (context, appModel, child) => Align(
                            //     alignment: Alignment.bottomCenter,
                            //     child: Consumer<Configs>(
                            //       builder: (context, configs, widget) => CollapsableContainer(
                            //         // color: !configs.darkMode ? AppColor.background : AppColor.darkThemeColor,
                            //         height: 60.0,
                            //         isVisible: appModel.bottomVisibleOnOff,
                            //         child: Material(
                            //           child: Row(
                            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //             children: [
                            //               IconizeButton(
                            //                 iconData: FontAwesomeIcons.shareAlt,
                            //                 onPress: () async {
                            //                   Provider.of<Utils>(context).showWatermark();
                            //                   // final image = await _screenshotController.capture();
                            //                   // if (image == null) return;
                            //                   // await Utils.shareImage(image);
                            //                   // Provider.of<Utils>(context).hideWatermark();
                            //                 },
                            //               ),
                            //               IconizeButton(
                            //                 iconData: FontAwesomeIcons.download,
                            //                 onPress: () async{
                            //                   // Provider.of<Utils>(context).showWatermark();
                            //                   // final image =  await _screenshotController.capture();
                            //                   // if (image == null){
                            //                   //   print('error');
                            //                   // }
                            //                   // await Utils.shareImage(image);
                            //                   // Provider.of<Utils>(context).hideWatermark();
                            //                 },
                            //               ),
                            //               IconizeButton(
                            //                 iconData: FontAwesomeIcons.bookOpen,
                            //                 onPress: () => print('bookmark'),
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
                    }else{
                      return Center(
                        child: Text(
                          widget.type == event.FromBookmark ? 'No Bookmark Stories' : 'No News!',
                          style: AppTextStyle.newsTitle,
                        ),
                      );
                    }
                  }else
                  return Center(
                    child: Text(
                      'Failed Try Again',
                      style: AppTextStyle.newsTitle,
                    ),
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
