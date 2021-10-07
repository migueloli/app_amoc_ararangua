import 'package:equatable/equatable.dart';

class AccountPresenter extends Equatable {
  final String id;
  String name;
  String document;
  String email;
  String phone;
  String zip;
  String address;
  String number;
  String neighborhood;
  String city;
  String state;
  bool isWorker;
  String description;
  String categoryId;
  final int status;
  final String cause;

  AccountPresenter({
    required this.id,
    required this.status,
    required this.cause,
    this.name = '',
    this.document = '',
    this.email = '',
    this.phone = '',
    this.zip = '',
    this.address = '',
    this.number = '',
    this.neighborhood = '',
    this.city = '',
    this.state = '',
    this.isWorker = false,
    this.description = '',
    this.categoryId = '',
  });

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
    categoryId,
  ];
}