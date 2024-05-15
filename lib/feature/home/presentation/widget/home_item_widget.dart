import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/util.dart';
import '../../../detail/presentation/detail_page.dart';
import '../../domain/entities/article_entity.dart';

class HomeItemWidget extends StatelessWidget {
  final ArticleEntity? itemArticle;
  final String? strPublishedAt;

  const HomeItemWidget({
    super.key,
    required this.itemArticle,
    required this.strPublishedAt,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return GestureDetector(
      onTap: () {
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
      child: SizedBox(
        height: 64.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: itemArticle?.urlToImage ?? "",
                fit: BoxFit.cover,
                width: 100.w,
                height: 120.h,
                errorWidget: (context, url, error) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/img_not_found.jpg',
                      fit: BoxFit.cover,
                    ),
                  );
                },
                placeholder: (context, url) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/img_placeholder.jpg',
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 24.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      itemArticle?.title ?? "-",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  itemArticle?.author == null
                      ? Container()
                      : Text(
                          itemArticle?.author ?? "-",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.sp,
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
                      Expanded(
                        child: Text(
                          itemArticle?.source?.name ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.sp,
                          ),
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
