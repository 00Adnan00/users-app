import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/src/common_widgets/app_error_widget.dart';
import 'package:users_app/src/features/users/domain/user.dart';
import 'package:users_app/src/features/users/presentation/detailed_user_screen_controller.dart';

class DetailedUserScreen extends ConsumerWidget {
  const DetailedUserScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(detailedUserScreenControllerProvider(id));
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
      ),
      body: asyncValue.when(
        data: (user) => _UserInfo(user: user!),
        error: (error, stackTrace) => Center(
          child: AppErrorWidget(
            error: error,
            onRetry: () async {
              await ref
                  .read(detailedUserScreenControllerProvider(id).notifier)
                  .fetchUser(id);
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

/// This is just the body of [DetailedUserScreen]
class _UserInfo extends StatelessWidget {
  const _UserInfo({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(user.name),
            subtitle: Text(user.email),
          ),
          Text(
            'Address:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          _LabledInfo(label: 'City', text: user.address.city),
          _LabledInfo(label: 'Street', text: user.address.street),
          _LabledInfo(label: 'Suite', text: user.address.suite),
          const SizedBox(height: 10),
          Text(
            'Company:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          _LabledInfo(label: 'Name', text: user.company.name),
          _LabledInfo(label: 'BS', text: user.company.bs),
          _LabledInfo(label: 'Catch Phrase', text: user.company.catchPhrase),
          const SizedBox(height: 10),
          _LabledInfo(
            label: 'More On',
            text: user.website,
            textColor: Theme.of(context).primaryColor,
            textDecoration: TextDecoration.underline,
          ),
        ],
      ),
    );
  }
}

/// A widget that puts text in this format => label: text
class _LabledInfo extends StatelessWidget {
  const _LabledInfo({
    required this.label,
    required this.text,
    this.textColor,
    this.textDecoration,
  });

  final String label;
  final String text;
  final Color? textColor;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$label: ',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
            ),
        children: [
          TextSpan(
            text: text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: textColor,
                  decoration: textDecoration,
                ),
          ),
        ],
      ),
    );
  }
}
