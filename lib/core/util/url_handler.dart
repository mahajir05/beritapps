import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_utils.dart';

class UrlHandler {
  static openUrl({required BuildContext context, required String? url}) async {
    final uri = Uri.tryParse(url ?? "");
    if (uri == null) return;
    canLaunchUrl(uri).then((value) async {
      if (value) {
        await launchUrl(uri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Couldn\'t open detail news'),
        ));
      }
    }).onError((error, stackTrace) {
      appPrint("error: $error: $stackTrace");
    });
  }
}
