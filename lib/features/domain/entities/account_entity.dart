import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable {

  final String id;
  final String name;
  final String document;
  final String email;
  final String phone;
  final String zip;
  final String address;
  final String number;
  final String neighborhood;
  final String city;
  final String state;
  final bool isWorker;
  final String description;
  final int status;
  final String cause;
  final String categoryId;

  const AccountEntity({
    this.id = '',
    required this.name,
    required this.document,
    required this.email,
    required this.phone,
    required this.zip,
    required this.address,
    required this.number,
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.isWorker,
    required this.description,
    required this.status,
    required this.cause,
    required this.categoryId,
  });

  factory AccountEntity.empty() => const AccountEntity(
    name: '',
    document: '',
    email: '',
    phone: '',
    zip: '',
    address: '',
    number: '',
    neighborhood: '',
    city: '',
    state: '',
    isWorker: false,
    description: '',
    status: 0,
    cause: '',
    categoryId: '',
  );

  @override
  List<Object?> get props => [
    id,
    name,
    document,
    email,
    phone,
    zip,
    address,
    number,
    neighborhood,
    city,
    state,
    isWorker,
    description,
    status,
    cause,
    categoryId,
  ];

}