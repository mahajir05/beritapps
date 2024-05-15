import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  final String? title;
  final String? dateTime;
  final String? source;
  final String? imageUrl;
  final String? content;

  const DetailPage(
      {super.key,
      this.title,
      this.dateTime,
      this.source,
      this.imageUrl,
      this.content});

  @override
  Widget build(BuildContext context) {
    var dateTimePublishedAt =
        DateFormat('yyyy-MM-ddTHH:mm:ssZ').tryParse(dateTime ?? "", true);
    String? strPublishedAt;
    if (dateTimePublishedAt != null) {
      strPublishedAt =
          DateFormat('MMM dd, yyyy HH:mm').format(dateTimePublishedAt);
    }
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? "-",
                style: TextStyle(
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    strPublishedAt ?? "-",
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    source ?? "-",
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: imageUrl ?? "",
                  fit: BoxFit.cover,
                  width: double.infinity,
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
              SizedBox(height: 16.h),
              Text(
                content ?? "-",
                style: const TextStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
