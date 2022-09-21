import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news360_api/api_calls.dart';
import 'package:news60/custom_widgets/bookmark_card.dart';
import 'package:news60/bloc/category_list_bloc/category_list_bloc.dart';
import 'package:news60/bloc/tags_%20bloc/tags_bloc.dart';
import 'package:news60/components/colors.dart';
import 'package:news60/configs/settings_config.dart';
import 'package:news60/custom_widgets/menu_screen_components/tags_texts.dart';
import 'package:news60/custom_widgets/menu_screen_components/headline.dart';
import 'package:news60/custom_widgets/menu_screen_components/topics_card.dart';
import 'package:news60/custom_widgets/menu_screen_components/search_bar.dart';
import 'package:news60/screens/Tags_news_screen.dart';
import 'package:news60/utils/utils.dart';
import 'package:provider/provider.dart';

enum event{
  FromCategory,
  FromTag,
  FromBookmark,
}

class MenuProvider extends StatelessWidget {
  const MenuProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TagListBloc(
            ApiCalls(),
          ),
        ),
        BlocProvider(
          create: (context) => CategoryListBloc(
            ApiCalls(),
          ),
        ),
      ],
      child: MenuScreen(),
    );
  }
}

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with AutomaticKeepAliveClientMixin{
  @override
  void initState() {
    super.initState();
    final String deviceId = Hive.box('deviceInfo').get('deviceId');
    final tagsBloc = BlocProvider.of<TagListBloc>(context);
    final categoryBloc = BlocProvider.of<CategoryListBloc>(context);
    tagsBloc.add(
      FetchTagListEvent(deviceId: deviceId),
    );
    categoryBloc.add(
      GetCategoryListEvent(deviceId: deviceId),
    );
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
          create: (context) => Configs(),
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                 ValueListenableBuilder(
                   valueListenable: Hive.box(Configs.darkModeBox).listenable(),
                   builder: (context,Box box, child) {
                     bool darkMode =  box.get('darkMode', defaultValue: true);
                     return  SearchBar(
                       color1: darkMode == true ? AppColor.darkThemeColor  : AppColor.background,
                       color2: darkMode == true ? AppColor.background  : AppColor.darkThemeColor,
                     );
                   },
                 ),
                SizedBox(
                  height: 16,
                ),
                LimitedBox(
                  maxHeight: 90,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: BlocBuilder<TagListBloc, TagsState>(
                        builder: (context, state) {
                      if (state is LoadingTagsListState) {
                        return CircularProgressIndicator(
                          color: AppColor.primary,
                        );
                      } else if (state is LoadedTagsListState) {
                        print(state.tags[0].tagName);
                        Provider.of<Utils>(context).getTagList(state.tags);
                        return Consumer<Utils>(
                          builder: (context, utils, child) => GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 8/3,
                                mainAxisSpacing: 0.0,
                                crossAxisSpacing: 0.9,
                              ),
                              itemCount: utils.tagList.length,
                              itemBuilder: (context, index) {
                                return HashTags(
                                  text: '#${utils.tagList[index].tagName}',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TagProvider(
                                          tagIdCatIdOrUserId: utils.tagList[index].tagId,
                                          tagNameCatNameOrDeviceId: utils.tagList[index].tagName,
                                          type: event.FromTag,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }),
                        );
                      }
                      return Text('HashTags');
                    }),
                  ),
                ),
                buildHeadlines('Bookmark'),
                Align(
                  alignment: Alignment.centerLeft,
                  child: BookmarkCard(
                    title: 'Open Bookmark',
                    icon: 'bookmark',
                    onTap: (){
                      final String deviceId = Hive.box('deviceInfo').get('deviceId');
                      String userid = Hive.box('deviceInfo').get('userId');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TagProvider(
                            tagIdCatIdOrUserId: userid,
                            tagNameCatNameOrDeviceId: deviceId,
                            type: event.FromBookmark,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                buildHeadlines('Categories'),
                SizedBox(
                  height: 10,
                ),
                BlocBuilder<CategoryListBloc, CategoryListState>(
                    builder: (context, state) {
                  if (state is LoadingCategoryListState) {
                    return CircularProgressIndicator(
                      color: AppColor.primary,
                    );
                  } else if (state is LoadedCategoryListState) {
                    print('cat_id: ${state.categories[8].categoryId}');
                    Provider.of<Utils>(context)
                        .getCategoryList(state.categories);
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Consumer<Utils>(
                        builder: (context, utils, child) => GridView.count(
                          shrinkWrap: true,
                          childAspectRatio: (1 / 1.4),
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          children: <Widget>[
                            CategoryCard(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TagProvider(
                                      tagIdCatIdOrUserId: utils.categoryCard[10].categoryId,
                                      tagNameCatNameOrDeviceId: utils.categoryCard[10].categoryName,
                                      type: event.FromCategory,
                                    ),
                                  ),
                                );
                              },
                              title: utils.categoryCard[10].categoryName,
                              icon: "coronavirus",
                            ),
                            CategoryCard(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TagProvider(
                                      tagIdCatIdOrUserId: utils.categoryCard[0].categoryId,
                                      tagNameCatNameOrDeviceId: utils.categoryCard[0].categoryName,
                                      type: event.FromCategory,
                                    ),
                                  ),
                                );
                              },
                              title: utils.categoryCard[0].categoryName,
                              icon: "india",
                            ),
                            CategoryCard(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TagProvider(
                                      tagIdCatIdOrUserId: utils.categoryCard[11].categoryId,
                                      tagNameCatNameOrDeviceId: utils.categoryCard[11].categoryName,
                                      type: event.FromCategory,
                                    ),
                                  ),
                                );
                              },
                              title: utils.categoryCard[11].categoryName,
                              icon: "business",
                            ),
                            CategoryCard(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TagProvider(
                                      tagIdCatIdOrUserId: utils.categoryCard[2].categoryId,
                                      tagNameCatNameOrDeviceId: utils.categoryCard[2].categoryName,
                                      type: event.FromCategory,
                                    ),
                                  ),
                                );
                              },
                              title: utils.categoryCard[2].categoryName,
                              icon: "politics",
                            ),
                            CategoryCard(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TagProvider(
                                      tagIdCatIdOrUserId: utils.categoryCard[1].categoryId,
                                      tagNameCatNameOrDeviceId: utils.categoryCard[1].categoryName,
                                      type: event.FromCategory,
                                    ),
                                  ),
                                );
                              },
                              title: utils.categoryCard[1].categoryName,
                              icon: "sports",
                            ),
                            CategoryCard(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TagProvider(
                                      tagIdCatIdOrUserId: utils.categoryCard[5].categoryId,
                                      tagNameCatNameOrDeviceId: utils.categoryCard[5].categoryName,
                                      type: event.FromCategory,
                                    ),
                                  ),
                                );
                              },
                              title: utils.categoryCard[5].categoryName,
                              icon: "technology",
                            ),
                            CategoryCard(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TagProvider(
                                      tagIdCatIdOrUserId: utils.categoryCard[6].categoryId,
                                      tagNameCatNameOrDeviceId: utils.categoryCard[6].categoryName,
                                      type: event.FromCategory,
                                    ),
                                  ),
                                );
                              },
                              title: utils.categoryCard[6].categoryName,
                              icon: "startups",
                            ),
                            CategoryCard(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TagProvider(
                                      tagIdCatIdOrUserId: utils.categoryCard[3].categoryId,
                                      tagNameCatNameOrDeviceId: utils.categoryCard[3].categoryName,
                                      type: event.FromCategory,
                                    ),
                                  ),
                                );
                              },
                              title: utils.categoryCard[3].categoryName,
                              icon: "entertainment",
                            ),
                            CategoryCard(
                              onTap: (){
                                print(utils.categoryCard[8].categoryId);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TagProvider(
                                      tagIdCatIdOrUserId: utils.categoryCard[8].categoryId,
                                      tagNameCatNameOrDeviceId: utils.categoryCard[8].categoryName,
                                      type: event.FromCategory,
                                    ),
                                  ),
                                );
                              },
                              title: utils.categoryCard[8].categoryName,
                              icon: "sports",
                            ),
                            CategoryCard(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TagProvider(
                                      tagIdCatIdOrUserId: utils.categoryCard[7].categoryId,
                                      tagNameCatNameOrDeviceId: utils.categoryCard[7].categoryName,
                                      type: event.FromCategory,
                                    ),
                                  ),
                                );
                              },
                              title: utils.categoryCard[7].categoryName,
                              icon: "sports",
                            ),
                            CategoryCard(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TagProvider(
                                      tagIdCatIdOrUserId: utils.categoryCard[4].categoryId,
                                      tagNameCatNameOrDeviceId: utils.categoryCard[4].categoryName,
                                      type: event.FromCategory,
                                    ),
                                  ),
                                );
                              },
                              title: utils.categoryCard[4].categoryName,
                              icon: "science",
                            ),
                            CategoryCard(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TagProvider(
                                      tagIdCatIdOrUserId: utils.categoryCard[9].categoryId,
                                      tagNameCatNameOrDeviceId: utils.categoryCard[9].categoryName,
                                      type: event.FromCategory,
                                    ),
                                  ),
                                );
                              },
                              title: utils.categoryCard[9].categoryName,
                              icon: "coronavirus",
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Text('Failed to Fetch Category Cards!');
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Align buildHeadlines(String headline) {
    return Align(
                alignment: Alignment.centerLeft,
                child: ValueListenableBuilder(
                  valueListenable: Hive.box(Configs.darkModeBox).listenable(),
                  builder: (context, Box box, childs){
                    bool darkMode =  box.get('darkMode', defaultValue: true);
                    return headLine(headline, darkMode ? AppColor.background : AppColor.primary);
                  },
                ),
              );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
