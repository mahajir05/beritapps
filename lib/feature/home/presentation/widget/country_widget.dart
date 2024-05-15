import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../blocs/top_headlines_news/top_headlines_news_bloc.dart';

class CountryWidget extends StatefulWidget {
  final List<String> countries;
  final int indexDefaultSelected;
  final int indexCategorySelected;

  const CountryWidget({
    super.key,
    required this.countries,
    required this.indexDefaultSelected,
    required this.indexCategorySelected,
  });

  @override
  State<StatefulWidget> createState() => _CountryWidgetState();
}

class _CountryWidgetState extends State<CountryWidget> {
  int? indexCountrySelected;

  @override
  void initState() {
    indexCountrySelected = widget.indexDefaultSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.h,
      child: Row(
        children: [
          const Text("Country: "),
          const SizedBox(width: 16),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var itemCategory = widget.countries[index];
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 0 : 4.w,
                    right: index == widget.countries.length - 1 ? 0 : 8.w,
                  ),
                  child: InkWell(
                    onTap: () {
                      if (indexCountrySelected == index) {
                        return;
                      }
                      setState(() => indexCountrySelected = index);
                      var topHeadlinesNewsBloc =
                          BlocProvider.of<TopHeadlinesNewsBloc>(context);
                      topHeadlinesNewsBloc.add(
                        ChangeCategoryAndCountryTopHeadlinesNewsEvent(
                          indexCountrySelected: index,
                          indexCategorySelected: widget.indexCategorySelected,
                        ),
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(
                          horizontal: 32.w,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(
                              indexCountrySelected == index ? 0.6 : 0.2),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                          border: indexCountrySelected == index
                              ? Border.all(
                                  color: Colors.grey,
                                  width: 2.0,
                                )
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            itemCategory.toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: widget.countries.length,
            ),
          ),
        ],
      ),
    );
  }
}
