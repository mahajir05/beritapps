import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../../core/util/url_handler.dart';
import '../../../../detail/presentation/detail_page.dart';
import '../../../domain/entities/article_entity.dart';
import '../../blocs/top_headlines_news/top_headlines_news_bloc.dart';
import '../../../data/model/categorynews/category_news_model.dart';
import '../../../../search/presentation/pages/search_page.dart';
import '../../cubits/home_news_helper/home_news_helper_cubit.dart';
import '../../widget/category_news_widget.dart';
import '../../widget/country_widget.dart';
import '../../widget/date_today_widget.dart';
import '../../widget/home_item_widget.dart';
import '../settings/settings_page.dart';
import '../../../../../core/widgets/widget_failure_message.dart';
import '/injection_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final topHeadlinesNewsBloc = sl<TopHeadlinesNewsBloc>();
  final listCategories = <CategoryNewsModel>[
    const CategoryNewsModel(image: '', title: 'All'),
    const CategoryNewsModel(
        image: 'assets/images/img_business.png', title: 'Business'),
    const CategoryNewsModel(
        image: 'assets/images/img_entertainment.png', title: 'Entertainment'),
    const CategoryNewsModel(
        image: 'assets/images/img_health.png', title: 'Health'),
    const CategoryNewsModel(
        image: 'assets/images/img_science.png', title: 'Science'),
    const CategoryNewsModel(
        image: 'assets/images/img_sport.png', title: 'Sports'),
    const CategoryNewsModel(
        image: 'assets/images/img_technology.png', title: 'Technology'),
  ];
  final listCountries = ["id", "us"];
  final refreshIndicatorState = GlobalKey<RefreshIndicatorState>();

  bool isLoadingCenterIOS = false;
  late Completer completerRefresh;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Platform.isIOS) {
        isLoadingCenterIOS = true;
        topHeadlinesNewsBloc.add(
          LoadTopHeadlinesNewsEvent(
              countryCode: listCountries[context
                  .read<HomeNewsHelperCubit>()
                  .state
                  .indexCountrySelected],
              category: listCategories[context
                      .read<HomeNewsHelperCubit>()
                      .state
                      .indexCategorySelected]
                  .title
                  ?.toLowerCase()),
        );
      } else {
        completerRefresh = Completer();
        refreshIndicatorState.currentState?.show();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<TopHeadlinesNewsBloc>(
            create: (context) => topHeadlinesNewsBloc,
          ),
          BlocProvider(
            create: (context) => sl<HomeNewsHelperCubit>(),
          ),
        ],
        child: BlocListener<TopHeadlinesNewsBloc, TopHeadlinesNewsState>(
          listener: (context, state) {
            if (state is FailureTopHeadlinesNewsState) {
              _resetRefreshIndicator();
            } else if (state is LoadedTopHeadlinesNewsState) {
              _resetRefreshIndicator();
            } else if (state is ChangedCategoryTopHeadlinesNewsState) {
              context
                  .read<HomeNewsHelperCubit>()
                  .changeCountry(state.indexCountrySelected ?? 0);
              context
                  .read<HomeNewsHelperCubit>()
                  .changeCategory(state.indexCategorySelected ?? 0);

              if (Platform.isIOS) {
                isLoadingCenterIOS = true;
                var category = listCategories[context
                        .read<HomeNewsHelperCubit>()
                        .state
                        .indexCategorySelected]
                    .title
                    ?.toLowerCase();
                var country = listCountries[context
                    .read<HomeNewsHelperCubit>()
                    .state
                    .indexCountrySelected];
                topHeadlinesNewsBloc.add(LoadTopHeadlinesNewsEvent(
                    countryCode: country, category: category));
              } else {
                refreshIndicatorState.currentState?.show();
              }
            }
          },
          child: ValueListenableBuilder(
            valueListenable: Hive.box('settings').listenable(),
            builder: (context, box, widget) {
              var isDarkMode = box.get('darkMode') ?? false;
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: isDarkMode ? null : const Color(0xFFEFF5F5),
                  ),
                  SafeArea(
                    child: Container(
                      width: double.infinity,
                      color: isDarkMode ? null : const Color(0xFFEFF5F5),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Daily News',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SearchPage()),
                                  );
                                },
                                child: Hero(
                                  tag: 'iconSearch',
                                  child: Icon(
                                    Icons.search,
                                    size: 20.w,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingsPage(),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.settings,
                                  size: 20.w,
                                ),
                              ),
                            ],
                          ),
                          const DateTodayWidget(),
                          SizedBox(height: 16.h),
                          CountryWidget(
                            indexCategorySelected: context
                                .watch<HomeNewsHelperCubit>()
                                .state
                                .indexCategorySelected,
                            indexDefaultSelected: context
                                .watch<HomeNewsHelperCubit>()
                                .state
                                .indexCountrySelected,
                            countries: listCountries,
                          ),
                          SizedBox(height: 16.h),
                          CategoryNewsWidget(
                              indexCountrySelected: context
                                  .watch<HomeNewsHelperCubit>()
                                  .state
                                  .indexCountrySelected,
                              listCategories: listCategories,
                              indexDefaultSelected: context
                                  .watch<HomeNewsHelperCubit>()
                                  .state
                                  .indexCategorySelected),
                          SizedBox(height: 16.h),
                          Expanded(
                            child: Platform.isIOS
                                ? _buildWidgetContentNewsIOS()
                                : _buildWidgetContentNewsAndroid(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _resetRefreshIndicator() {
    if (isLoadingCenterIOS) {
      isLoadingCenterIOS = false;
    }
    completerRefresh.complete();
    completerRefresh = Completer();
  }

  Widget _buildWidgetContentNewsIOS() {
    return BlocBuilder<TopHeadlinesNewsBloc, TopHeadlinesNewsState>(
      builder: (context, state) {
        var listArticles = [];
        if (state is LoadedTopHeadlinesNewsState) {
          listArticles.addAll(state.listArticles.toList());
        } else if (isLoadingCenterIOS) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        return Stack(
          children: <Widget>[
            CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: <Widget>[
                CupertinoSliverRefreshControl(
                  onRefresh: () {
                    topHeadlinesNewsBloc.add(
                      LoadTopHeadlinesNewsEvent(
                          countryCode: listCountries[context
                              .read<HomeNewsHelperCubit>()
                              .state
                              .indexCountrySelected],
                          category: listCategories[context
                                  .read<HomeNewsHelperCubit>()
                                  .state
                                  .indexCategorySelected]
                              .title
                              ?.toLowerCase()),
                    );
                    return completerRefresh.future;
                  },
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var itemArticle = listArticles[index];
                      var dateTimePublishedAt =
                          DateFormat('yyyy-MM-ddTHH:mm:ssZ')
                              .tryParse(itemArticle?.publishedAt ?? "", true);
                      if (dateTimePublishedAt == null) {
                        return const SizedBox();
                      }
                      var strPublishedAt = DateFormat('MMM dd, yyyy HH:mm')
                          .format(dateTimePublishedAt);
                      if (index == 0) {
                        return _buildWidgetItemLatestNews(
                            itemArticle, strPublishedAt);
                      } else {
                        return _buildWidgetItemNews(
                            index, itemArticle, strPublishedAt);
                      }
                    },
                    childCount: listArticles.length,
                  ),
                ),
              ],
            ),
            listArticles.isEmpty && state is! LoadingTopHeadlinesNewsState
                ? _buildWidgetFailureLoadData()
                : Container(),
          ],
        );
      },
    );
  }

  Widget _buildWidgetContentNewsAndroid() {
    return BlocBuilder<TopHeadlinesNewsBloc, TopHeadlinesNewsState>(
      builder: (context, state) {
        var listArticles = [];
        if (state is LoadedTopHeadlinesNewsState) {
          listArticles.addAll(state.listArticles.toList());
        }
        return Stack(
          children: <Widget>[
            RefreshIndicator(
              key: refreshIndicatorState,
              onRefresh: () {
                topHeadlinesNewsBloc.add(
                  LoadTopHeadlinesNewsEvent(
                      countryCode: listCountries[context
                          .read<HomeNewsHelperCubit>()
                          .state
                          .indexCountrySelected],
                      category: listCategories[context
                              .read<HomeNewsHelperCubit>()
                              .state
                              .indexCategorySelected]
                          .title
                          ?.toLowerCase()),
                );
                return completerRefresh.future;
              },
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var itemArticle = listArticles[index];
                  var dateTimePublishedAt = DateFormat('yyyy-MM-ddTHH:mm:ssZ')
                      .tryParse(itemArticle?.publishedAt ?? "", true);
                  if (dateTimePublishedAt == null) {
                    return const SizedBox();
                  }
                  var strPublishedAt = DateFormat('MMM dd, yyyy HH:mm')
                      .format(dateTimePublishedAt);
                  if (index == 0) {
                    return _buildWidgetItemLatestNews(
                        itemArticle, strPublishedAt);
                  } else {
                    return _buildWidgetItemNews(
                        index, itemArticle, strPublishedAt);
                  }
                },
                itemCount: listArticles.length,
              ),
            ),
            listArticles.isEmpty && state is FailureTopHeadlinesNewsState
                ? _buildWidgetFailureLoadData()
                : Container(),
          ],
        );
      },
    );
  }

  Widget _buildWidgetFailureLoadData() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const WidgetFailureMessage(),
          ElevatedButton(
            onPressed: () {
              if (Platform.isIOS) {
                isLoadingCenterIOS = true;
                topHeadlinesNewsBloc.add(
                  LoadTopHeadlinesNewsEvent(
                      countryCode: listCountries[context
                          .read<HomeNewsHelperCubit>()
                          .state
                          .indexCountrySelected],
                      category: listCategories[context
                              .read<HomeNewsHelperCubit>()
                              .state
                              .indexCategorySelected]
                          .title
                          ?.toLowerCase()),
                );
              } else {
                refreshIndicatorState.currentState?.show();
              }
            },
            child: Text(
              'Try Again'.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 36.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetItemNews(
    int? index,
    ArticleEntity? itemArticle,
    String? strPublishedAt,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        top: index == 1 ? 32.h : 16.h,
        bottom: 16.h,
      ),
      child: HomeItemWidget(
        itemArticle: itemArticle,
        strPublishedAt: strPublishedAt,
      ),
    );
  }

  Widget _buildWidgetItemLatestNews(
    ArticleEntity? itemArticle,
    String? strPublishedAt,
  ) {
    return GestureDetector(
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            alignment: Alignment.center,
            child: SizedBox(
              height: 128.h,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      UrlHandler.openUrl(
                          context: context, url: itemArticle?.url);
                    },
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Text(
                        "open in web",
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            title: itemArticle?.title,
                            dateTime: itemArticle?.publishedAt,
                            source: itemArticle?.source?.name,
                            imageUrl: itemArticle?.urlToImage,
                            content: itemArticle?.content,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Text(
                        "open in app",
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: ScreenUtil().screenWidth / 1.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: NetworkImage(
              itemArticle?.urlToImage ?? "",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              // height: ScreenUtil().screenWidth / 1.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black,
                    Colors.black.withOpacity(0.0),
                  ],
                  stops: const [
                    0.0,
                    1.0,
                  ],
                ),
                image: DecorationImage(
                  image: NetworkImage(itemArticle?.urlToImage ?? ""),
                  onError: (exception, stackTrace) => ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/img_not_found.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(48),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 4.w,
                    ),
                    child: Text(
                      'Latest News',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    itemArticle?.title ?? "-",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        strPublishedAt ?? "-",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.sp,
                        ),
                      ),
                      Text(
                        ' | ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        itemArticle?.source?.name ?? "-",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
