import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/src/utils/show_snackbar.dart';

extension AsyncValueUI on AsyncValue {
  void showSnackBarOnError(BuildContext context) {
    if (!isLoading && hasError && !snackbarIsShown) {
      if (error is DioException) {
        final errorType = (error as DioException).type;
        if (errorType == DioExceptionType.connectionError) {
          showAppSnackBar(context, title: 'No internet connection!');
        } else if (errorType == DioExceptionType.receiveTimeout) {
          showAppSnackBar(context, title: 'Server took too long to respond');
        } else if (errorType == DioExceptionType.sendTimeout) {
          showAppSnackBar(context, title: "Your request didn't make it");
        } else {
          showAppSnackBar(context, title: 'Unexpected error');
        }
      } else {
        showAppSnackBar(context, title: 'Unexpected error');
      }
    }
  }
}
