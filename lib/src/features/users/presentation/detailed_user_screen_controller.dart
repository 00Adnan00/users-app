import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/src/features/users/data/users_repository.dart';
import 'package:users_app/src/features/users/domain/user.dart';

class DetailedUserScreenController
    extends AutoDisposeFamilyAsyncNotifier<User?, int> {
  Object? key;

  @override
  // ignore: avoid_renaming_method_parameters
  FutureOr<User?> build(int id) {
    key = Object();

    return fetchUser(id);
  }

  /// Returns [null] if back button is presssed before data is loaded
  Future<User?> fetchUser(int id) async {
    state = const AsyncValue.loading();

    final key = this.key;

    final newState = await AsyncValue.guard(
        () => ref.watch(usersRepositoryProvider).fetchUser(id));

    if (key != this.key) return null;

    state = newState;

    return state.value;
  }
}

final detailedUserScreenControllerProvider = AsyncNotifierProvider.autoDispose
    .family<DetailedUserScreenController, User?, int>(
        () => DetailedUserScreenController());
