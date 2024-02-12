import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:users_app/src/common_widgets/app_error_widget.dart';
import 'package:users_app/src/features/users/domain/user.dart';
import 'package:users_app/src/features/users/presentation/users_scren_controller.dart';
import 'package:users_app/src/routing/app_router.dart';
import 'package:users_app/src/utils/async_value_ui.dart';

class UsersList extends ConsumerWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(usersScreenControllerProvider, (_, current) {
      current.showSnackBarOnError(context);
    });

    final asyncValue = ref.watch(usersScreenControllerProvider);

    return asyncValue.when(
      skipLoadingOnReload: true,
      skipError: asyncValue.hasValue,
      data: (users) => _UsersList(users: users),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) {
        return Center(
          child: AppErrorWidget(
            error: e,
            onRetry: () async {
              await ref
                  .read(usersScreenControllerProvider.notifier)
                  .fetchUsers();
            },
          ),
        );
      },
    );
  }
}

class _UsersList extends ConsumerWidget {
  const _UsersList({required this.users});

  final List<User> users;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      top: false,
      child: RefreshIndicator(
        onRefresh: () async {
          await ref.watch(usersScreenControllerProvider.notifier).fetchUsers();
        },
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: users.length,
          itemBuilder: (_, index) {
            return Card(
              child: ListTile(
                title: Text(users[index].name),
                subtitle: Text(users[index].company.name),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onTap: () {
                  context.goNamed(
                    AppRoute.detailedUser.name,
                    pathParameters: {
                      'id': users[index].id.toString(),
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
