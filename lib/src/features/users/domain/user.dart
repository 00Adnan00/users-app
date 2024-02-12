import 'package:equatable/equatable.dart';
import 'package:users_app/src/features/users/domain/address.dart';
import 'package:users_app/src/features/users/domain/company.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final Address address;
  final Company company;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
    required this.company,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
      website: map['website'],
      address: Address.fromMap(map['address']),
      company: Company.fromMap(map['company']),
    );
  }

  @override
  List<Object?> get props =>
      [id, name, username, email, phone, website, address, company];
}
