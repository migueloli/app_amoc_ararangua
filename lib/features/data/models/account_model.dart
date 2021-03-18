import '../../domain/entities/account_entity.dart';

class AccountModel extends AccountEntity {

  const AccountModel({
    required int id,
    required String name,
    required String document,
    required String email,
    required String phone,
    required String zip,
    required String address,
    required String number,
    required String neighborhood,
    required String city,
    required String state,
    required bool isWorker,
    required String description,
    required int status,
    required String cause,
    required String password,
  }): super(
    id: id,
    name: name,
    document: document,
    email: email,
    phone: phone,
    zip: zip,
    address: address,
    number: number,
    neighborhood: neighborhood,
    city: city,
    state: state,
    isWorker: isWorker,
    description: description,
    status: status,
    cause: cause,
    password: password,
  );

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'],
      name: json['name'],
      document: json['document'],
      email: json['email'],
      phone: json['phone'],
      zip: json['zip'],
      address: json['address'],
      number: json['number'],
      neighborhood: json['neighborhood'],
      city: json['city'],
      state: json['state'],
      isWorker: json['is_worker'],
      description: json['description'],
      status: json['status'],
      cause: json['cause'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'document': document,
    'email': email,
    'phone': phone,
    'zip': zip,
    'address': address,
    'number': number,
    'neighborhood': neighborhood,
    'city': city,
    'state': state,
    'is_worker': isWorker,
    'description': description,
    'status': status,
    'cause': cause,
    'password': password,
  };

  @override
  List<Object?> get props => super.props..add(password);

}