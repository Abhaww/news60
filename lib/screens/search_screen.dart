import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:news360_api/api_calls.dart';
import 'package:news60/bloc/feeds_bloc/news_feed_events.dart';
import 'package:news60/components/colors.dart';
import 'package:news60/components/text_styles.dart';
import 'package:news60/bloc/feeds_bloc/news_feed_bloc.dart';
import 'package:news60/bloc/feeds_bloc/news_feed_state.dart';
import 'package:news60/configs/settings_config.dart';
import 'package:news60/custom_widgets/collapsable_container.dart';
import 'package:news60/custom_widgets/iconize_button.dart';
import 'package:news60/custom_widgets/search_screen_components/search_news_card.dart';
import 'package:news60/custom_widgets/transformer.dart';
import 'package:news60/models/tags_search_category_home_screens_models.dart';
import 'package:news60/screens/web_view.dart';
import 'package:news60/utils/utils.dart';
import 'package:news60/views/news_view.dart';
import 'package:provider/provider.dart';
import 'package:news360_api/models/news_data_model/news_data.dart';
import 'package:screenshot/screenshot.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchProviders extends StatelessWidget {
  const SearchProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NewsFeedBloc(
              ApiCalls(),
            ),
        child: SearchScreen());
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with AutomaticKeepAliveClientMixin{
  TextEditingController _searchController = TextEditingController();
 // TransformerPageController _transformerPageController = TransformerPageController(keepPage: true);
  late String searchTerm;
  late var newsFeedBloc;
  @override
  void initState() {
    // TODO: implement initState
    newsFeedBloc = BlocProvider.of<NewsFeedBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: ValueListenableBuilder(
              valueListenable: Hive.box(Configs.darkModeBox).listenable(),
              builder: (context, Box box, chidls){
                bool darkMode = box.get('darkMode', defaultValue: true);
                return IconButton(
                icon: Icon(
                  FontAwesomeIcons.arrowLeft,
                  size: 20.0,
                  color: darkMode ? AppColor.background : AppColor.primary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            }
          ),
          elevation: 1,
         // backgroundColor: Theme.of(context).cardColor,
          title: ValueListenableBuilder(
            valueListenable: Hive.box(Configs.darkModeBox).listenable(),
            builder: (context, Box box, childs){
              bool darkMode = box.get('darkMode', defaultValue: true);
              final searchHintTextStyle = TextStyle(
                  color: darkMode ? AppColor.background : AppColor.primary,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  fontFamily: 'Roboto'
              );
              return TextField(
                textAlign: TextAlign.start,
                autofocus: true,
                controller: _searchController,
                textInputAction: TextInputAction.search,
                // style: AppTextStyle.searchbar,
                decoration: InputDecoration(
                  hintText: "search for news",
                  hintStyle: searchHintTextStyle,
                  border: InputBorder.none,
                  suffixIcon: BlocProvider(
                    create: (context) => NewsFeedBloc(ApiCalls()),
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: darkMode ? AppColor.background : AppColor.primary,
                        size: 25.0,
                      ),
                      onPressed: () {
                        _searchController.clear();
                      },
                    ),
                  ),
                  // hintStyle: AppTextStyle.searchbar.copyWith(),
                ),
                onChanged: (terms) {
                  setState(() {
                    searchTerm = terms;
                  });
                },
                onSubmitted: (s) {
                  final String deviceId = Hive.box('deviceInfo').get('deviceId');
                  print(searchTerm);
                  newsFeedBloc.add(
                    FetchNewsDataBySearchEvent(
                        deviceId: deviceId, searchKey: searchTerm),
                  );
                },
              );
            },
          ),
        ),
        body: Container(
          // color: AppColor.background,
          child: BlocBuilder<NewsFeedBloc, NewsFeedState>(
            builder: (context, state) {
              if (state is InitialNewsFeedState) {
                return Center(
                  child: Text(
                    'You have\'nt searched anything yet!',
                    style: AppTextStyle.newsTitle,
                  ),
                );
              } else if (state is LoadingNewsFeedState) {
                print('loading');
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primary,
                  ),
                );
              } else if (state is LoadedNewsFeedState) {
                print('loaded');
                if(state.news.isNotEmpty) {
                  final List<String> searchNewsImages = List.generate(
                    state.news.length,
                        (index) => state.news[index].imagePath,
                    growable: false,
                  );
                  void loadImages() {
                    searchNewsImages.map((urlImage) =>
                        Utils.cacheImage(context, urlImage));
                  }
                  loadImages();
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return SearchNewsCard(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SearchHomeScreen(
                                    index: index,
                                    searchTerm: searchTerm,
                                    searchNews: state.news,
                                    searchedNewsImages: searchNewsImages,
                                  ),
                            ),
                          );
                        },
                        image: state.news[index].imagePath,
                        // date: state.news[index].datePublished.substring(0, 8),
                        title: state.news[index].newsTitle,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10.0,
                      );
                    },
                    itemCount: state.news.length,
                  );
                }else{
                  return Center(
                    child: Text(
                      'News not found',
                      style: AppTextStyle.newsTitle,
                    ),
                  );
                }
              }
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

class SearchHomeScreen extends StatefulWidget {
  final int index;
  final String searchTerm;
  final List<NewsData> searchNews;
  final List<String> searchedNewsImages;
  SearchHomeScreen(
      {required this.index,
      required this.searchTerm,
      required this.searchNews,
      required this.searchedNewsImages});

  @override
  _SearchHomeScreenState createState() => _SearchHomeScreenState();
}

class _SearchHomeScreenState extends State<SearchHomeScreen> with AutomaticKeepAliveClientMixin{
  late PageController _pageController;
  late int newsIndex;
  ScreenshotController _screenshotController = ScreenshotController();
  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: 0);
    newsIndex = widget.index;
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
      child: Consumer<STCHomeScreensModel>(
        builder: (context, searchModel, childs) => Scaffold(
          // appBar: searchModel.currentIndex == 0 ? AppBar(
          //   leadingWidth: 150.0,
          //   leading: ValueListenableBuilder(
          //       valueListenable: Hive.box(Configs.darkModeBox).listenable(),
          //       builder: (context, Box box, childs) {
          //         bool darkMode = box.get('darkMode', defaultValue: true);
          //         return Row(
          //           children: [
          //             IconButton(
          //               onPressed: () {
          //                 _pageController.previousPage(
          //                     duration: Duration(milliseconds: 200),
          //                     curve: Curves.easeIn);
          //               },
          //               icon: IconButton(
          //                 onPressed: (){
          //                   Navigator.pop(context);
          //                 },
          //                 icon: Icon(
          //                   FontAwesomeIcons.chevronLeft,
          //                   color: darkMode ? AppColor.background : AppColor.primary,
          //                   size: 20.0,
          //                 ),
          //               ),
          //             ),
          //             // SizedBox(
          //             //   width: 10.0,
          //             // ),
          //             Text(
          //               widget.searchTerm,
          //               style: TextStyle(
          //                 fontSize: 20.0,
          //                 fontFamily: 'Roboto',
          //                 color: darkMode == true
          //                     ? AppColor.background
          //                     : AppColor.primary,
          //               ),
          //             ),
          //           ],
          //         );
          //       }
          //   ),
          // ): null,
          body: SafeArea(
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
                            color: darkMode ? AppColor.background : AppColor.primary,
                          );
                          return CollapsableContainer(
                          height: 52.0,
                          isVisible: searchModel.topVisibleOnOff,
                          topAppBarPadding: true,
                          color: darkMode ? AppColor.background : AppColor.darkThemeColor,
                          child: Row(
                            children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.chevronLeft,
                                      color: AppColor.primary,
                                      size: 20.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      widget.searchTerm,
                                      style: textStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                      // Provider.of<STCHomeScreensModel>(context, listen: false)
                      //     .updateIndex(index);
                      Provider.of<STCHomeScreensModel>(context, listen: false)
                          .automaticHideBars(index);
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
                                itemCount: widget.searchNews.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return NewsView(
                                    datePublished: widget.searchNews[index].datePublished,
                                    isBookmark: widget.searchNews[index].isBookmark,
                                    newsId: widget.searchNews[index].newsId,
                                    tags: widget.searchNews[index].tagList,
                                    image: widget.searchedNewsImages[index],
                                    newsHeadline:
                                        widget.searchNews[newsIndex].newsTitle,
                                    newsSource: widget.searchNews[newsIndex].provider,
                                    newsSummary:
                                        widget.searchNews[newsIndex].newsSummary, 
                                        newsType: widget.searchNews[newsIndex].newsType, 
                                        videoUrl: widget.searchNews[newsIndex].videoPath,
                                    /// next version
                                    // showHideBars: () {
                                    //   Provider.of<STCHomeScreensModel>(context, listen: false)
                                    //       .showAndHideTopAndBottomBar();
                                    // },
                                  );
                                },
                              )
                          : WebScreen(
                              url: widget.searchNews[newsIndex].newsLink,
                        onTap: (){
                          _pageController.previousPage(duration: Duration(milliseconds: 20), curve: Curves.easeIn);
                        },
                            );
                    },
                  ),
                ),
                /// Till next version (version 2) see yah!
                // Consumer<STCHomeScreensModel>(
                //   builder: (context, searchModel, child) => Align(
                //     alignment: Alignment.topCenter,
                //     child: Consumer<Configs>(
                //       builder: (context, configs, widget) => CollapsableContainer(
                //         height: 52.0,
                //         isVisible: searchModel.topVisibleOnOff,
                //         topAppBarPadding: true,
                //         //color: !configs.darkMode ? AppColor.background : AppColor.darkThemeColor,
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
                //                     //   widget.searchTerm,
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
                //                   final image = await Utils.screenshotController.capture();
                //                   if (image == null) return;
                //                   await Utils.saveImage(image);
                //                   Provider.of<Utils>(context).hideWatermark();
                //                 },
                //               ),
                //               IconizeButton(
                //                 iconData: FontAwesomeIcons.download,
                //                 onPress: () async{
                //                   Provider.of<Utils>(context).showWatermark();
                //                   final image =  await  Utils.screenshotController.capture();
                //                   if (image == null){
                //                     print('error');
                //                   }
                //                   await Utils.saveImage(image);
                //                   Provider.of<Utils>(context).hideWatermark();
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
          ),
        ),
      ),
    );
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
