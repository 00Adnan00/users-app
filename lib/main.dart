import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/src/app.dart';

void main() {
  EquatableConfig.stringify = true;

  runApp(const ProviderScope(child: App()));
}
