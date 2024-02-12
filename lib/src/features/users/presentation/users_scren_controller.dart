import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/src/features/users/data/users_repository.dart';
import 'package:users_app/src/features/users/domain/user.dart';

class UsersScreenController extends AutoDisposeAsyncNotifier<List<User>> {
  @override
  FutureOr<List<User>> build() => fetchUsers();

  Future<List<User>> fetchUsers() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
        () => ref.watch(usersRepositoryProvider).fetchUsers());

    return state.value ?? [];
  }
}

final usersScreenControllerProvider =
    AsyncNotifierProvider.autoDispose<UsersScreenController, List<User>>(
  () => UsersScreenController(),
);
