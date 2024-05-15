import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/model/categorynews/category_news_model.dart';
import '../blocs/top_headlines_news/top_headlines_news_bloc.dart';

class CategoryNewsWidget extends StatefulWidget {
  final List<CategoryNewsModel> listCategories;
  final int indexDefaultSelected;
  final int indexCountrySelected;

  const CategoryNewsWidget({
    super.key,
    required this.listCategories,
    required this.indexDefaultSelected,
    required this.indexCountrySelected,
  });

  @override
  State<StatefulWidget> createState() => _CategoryNewsWidgetState();
}

class _CategoryNewsWidgetState extends State<CategoryNewsWidget> {
  int? indexCategorySelected;

  @override
  void initState() {
    indexCategorySelected = widget.indexDefaultSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var itemCategory = widget.listCategories[index];
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0 : 4.w,
              right: index == widget.listCategories.length - 1 ? 0 : 8.w,
            ),
            child: InkWell(
              onTap: () {
                if (indexCategorySelected == index) {
                  return;
                }
                setState(() => indexCategorySelected = index);
                var topHeadlinesNewsBloc =
                    BlocProvider.of<TopHeadlinesNewsBloc>(context);
                topHeadlinesNewsBloc.add(
                  ChangeCategoryAndCountryTopHeadlinesNewsEvent(
                      indexCountrySelected: widget.indexCountrySelected,
                      indexCategorySelected: index),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: itemCategory.title.toLowerCase() == 'all'
                      ? const Color(0xFFBBCDDC)
                      : null,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                  image: itemCategory.title.toLowerCase() == 'all'
                      ? null
                      : DecorationImage(
                          image: AssetImage(
                            itemCategory.image,
                          ),
                          fit: BoxFit.cover,
                        ),
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        itemCategory.title.toLowerCase() == 'all' ? 48.w : 32.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(
                        indexCategorySelected == index ? 0.6 : 0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                    border: indexCategorySelected == index
                        ? Border.all(
                            color: Colors.grey,
                            width: 2.0,
                          )
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      itemCategory.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: widget.listCategories.length,
      ),
    );
  }
}
