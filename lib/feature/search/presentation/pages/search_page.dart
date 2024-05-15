import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/widget_failure_message.dart';
import '../blocs/search_top_headlines/search_top_headlines_bloc.dart';
import '../widgets/search_item_widget.dart';
import '/injection_container.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchTopHeadlinesBloc>(),
      child: _Content(key: key),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content({super.key});

  @override
  State<StatefulWidget> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  final controllerKeyword = TextEditingController();
  final focusNodeIconSearch = FocusNode();
  String? keyword;
  Timer? debounce;

  @override
  void initState() {
    keyword = '';
    controllerKeyword.addListener(_onSearching);
    super.initState();
  }

  @override
  void dispose() {
    focusNodeIconSearch.dispose();
    controllerKeyword.removeListener(_onSearching);
    controllerKeyword.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    var theme = Theme.of(context);
    var isDarkTheme = theme.brightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: isDarkTheme ? null : const Color(0xFFEFF5F5),
          ),
          SafeArea(
            child: Container(
              color: isDarkTheme ? null : const Color(0xFFEFF5F5),
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 16.h,
                horizontal: 16.w,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Platform.isIOS
                              ? Icons.arrow_back_ios
                              : Icons.arrow_back,
                        ),
                      ),
                      SizedBox(width: 24.w),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(99.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  controller: controllerKeyword,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: 'Searching something?',
                                    hintStyle: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey,
                                    ),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                              Hero(
                                tag: 'iconSearch',
                                child: Focus(
                                  focusNode: focusNodeIconSearch,
                                  child: Icon(
                                    Icons.search,
                                    size: 16.w,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  const Text("This search only returns results in Indonesia"),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: BlocBuilder<SearchTopHeadlinesBloc,
                        SearchTopHeadlinesState>(
                      builder: (context, state) {
                        if (state is SearchTopHeadlinesStateLoading) {
                          return Center(
                            child: Platform.isIOS
                                ? const CupertinoActivityIndicator()
                                : const CircularProgressIndicator(),
                          );
                        } else if (state is SearchTopHeadlinesStateFailure) {
                          return const WidgetFailureMessage();
                        } else if (state is SearchTopHeadlinesStateSuccess) {
                          var listArticles = state.listArticles;
                          if (listArticles.isEmpty) {
                            return const WidgetFailureMessage(
                              errorTitle: 'Data not found',
                              errorSubtitle:
                                  'Hm, we couldn\'t find what you were looking for.',
                            );
                          } else {
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                var itemArticle = listArticles[index];
                                var dateTimePublishedAt =
                                    DateFormat('yyy-MM-ddTHH:mm:ssZ').tryParse(
                                        itemArticle.publishedAt ?? "", true);
                                if (dateTimePublishedAt == null) {
                                  return const SizedBox();
                                }
                                var strPublishedAt =
                                    DateFormat('MMM dd, yyyy HH:mm')
                                        .format(dateTimePublishedAt);
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  child: SearchItemWidget(
                                    itemArticle: itemArticle,
                                    strPublishedAt: strPublishedAt,
                                  ),
                                );
                              },
                              itemCount: listArticles.length,
                            );
                          }
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSearching() {
    if (debounce?.isActive ?? false) {
      debounce?.cancel();
    }
    debounce = Timer(const Duration(milliseconds: 800), () {
      var keyword = controllerKeyword.text.trim();
      if (keyword.isEmpty || this.keyword == keyword) {
        return;
      }
      this.keyword = keyword;
      focusNodeIconSearch.requestFocus();
      context
          .read<SearchTopHeadlinesBloc>()
          .add(SearchTopHeadlinesNowEvent(countryCode: "id", keyword: keyword));
    });
  }
}
