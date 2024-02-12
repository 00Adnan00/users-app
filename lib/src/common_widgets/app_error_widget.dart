import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// Can be placed at the center of a page to indicate that
/// something went wrong.
///
/// A retry button will be visible if [onRetry] is not null.
class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    required this.error,
    required this.onRetry,
  });

  final Object error;
  final FutureOr<void> Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    late final String textError;

    if (error is DioException) {
      final errorType = (error as DioException).type;
      if (errorType == DioExceptionType.connectionError) {
        textError = 'No internet connection!';
      } else if (errorType == DioExceptionType.receiveTimeout) {
        textError = 'Server took too long to respond';
      } else if (errorType == DioExceptionType.sendTimeout) {
        textError = "Your request didn't make it";
      } else {
        textError = 'Unexpected error';
      }
    } else {
      textError = 'Unexpected error';
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(textError),
        if (onRetry != null) ...[
          const SizedBox(height: 2),
          _RetryButton(onRetry: onRetry),
        ]
      ],
    );
  }
}

class _RetryButton extends StatefulWidget {
  const _RetryButton({required this.onRetry});

  final FutureOr<void> Function()? onRetry;

  @override
  State<_RetryButton> createState() => _RetryButtonState();
}

class _RetryButtonState extends State<_RetryButton> {
  bool disabled = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: disabled
          ? null
          : () async {
              setState(() {
                disabled = true;
              });
              try {
                await widget.onRetry?.call();
              } finally {
                setState(() {
                  disabled = false;
                });
              }
            },
      child: const Text('Retry'),
    );
  }
}
