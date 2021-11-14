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
  final bool isAdmin;

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
    required this.isAdmin,
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
    isAdmin: false,
  );

  @override
  List<Object> get props {
    return [
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
      isAdmin,
    ];
  }


  AccountEntity copyWith({
    String? id,
    String? name,
    String? document,
    String? email,
    String? phone,
    String? zip,
    String? address,
    String? number,
    String? neighborhood,
    String? city,
    String? state,
    bool? isWorker,
    String? description,
    int? status,
    String? cause,
    String? categoryId,
    bool? isAdmin,
  }) {
    return AccountEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      document: document ?? this.document,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      zip: zip ?? this.zip,
      address: address ?? this.address,
      number: number ?? this.number,
      neighborhood: neighborhood ?? this.neighborhood,
      city: city ?? this.city,
      state: state ?? this.state,
      isWorker: isWorker ?? this.isWorker,
      description: description ?? this.description,
      status: status ?? this.status,
      cause: cause ?? this.cause,
      categoryId: categoryId ?? this.categoryId,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }
}
