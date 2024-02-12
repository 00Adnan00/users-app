import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/src/features/users/domain/user.dart';
import 'package:users_app/src/utils/api_client.dart';

class UsersRepository {
  const UsersRepository(this._apiClient);

  final Dio _apiClient;

  /// Throws an exception of type [DioException] if
  /// something went wrong  & [FormatException] if
  /// the json response is not as excpected.
  Future<List<User>> fetchUsers() async {
    final response = await _apiClient.get('/users');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      final List<User> users = data.map((json) => User.fromMap(json)).toList();
      return users;
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  /// Throws an exception of type [DioException] if
  /// something went wrong  & [FormatException] if
  /// the json response is not as excpected.
  Future<User> fetchUser(int id) async {
    final response = await _apiClient.get('/users/$id');
    if (response.statusCode == 200) {
      return User.fromMap(response.data);
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}

final usersRepositoryProvider = Provider.autoDispose(
  (ref) => UsersRepository(ref.watch(dioProvider)),
);
