import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String street;
  final String suite;
  final String city;
  final String zipcode;

  const Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
  });

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      street: map['street'],
      suite: map['suite'],
      city: map['city'],
      zipcode: map['zipcode'],
    );
  }

  @override
  List<Object?> get props => [street, suite, city, zipcode];
}
