import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';

/// unlimited message
appLog(String message) {
  if (kDebugMode) {
    if (!kIsWeb) {
      if (Platform.isIOS) {
        print(message);
      }
    }
    log(message);
  }
}

/// limited message
appPrint(String message) {
  if (kDebugMode) {
    print(message);
  }
}

appPrintError(String message) {
  if (kDebugMode) {
    print('\x1B[31m$message\x1B[0m');
  }
}
