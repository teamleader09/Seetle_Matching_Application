import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:settee/src/exceptions/app_exception.dart';

extension AsyncValueUI on AsyncValue {
  bool showAlertDialogOnError(BuildContext context) {
    if (!isRefreshing && hasError) {
      _errorMessage(error, context);
      return true;
    }
    return false;
  }

  String _errorMessage(Object? error, BuildContext context) {
    if (error is AppException) {
      return error.toString();
    } else {
      return error.toString();
    }
  }
}
