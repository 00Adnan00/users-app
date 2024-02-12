import 'package:flutter/material.dart';
import 'package:users_app/src/features/users/presentation/users_list.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: const UsersList(),
    );
  }
}
