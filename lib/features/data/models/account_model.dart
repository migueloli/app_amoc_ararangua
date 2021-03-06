import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/custom_methods/try_cast.dart';
import '../../domain/entities/account_entity.dart';

class AccountModel extends AccountEntity {

  const AccountModel({
    required String id,
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
    required String categoryId,
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
    categoryId: categoryId,
  );

  factory AccountModel.fromJson(Map<String, dynamic> json, {String? id}) => AccountModel(
    id: id ?? tryCast<String>(json['id'], ''),
    name: tryCast<String>(json['name'], ''),
    document: tryCast<String>(json['document'], ''),
    email: tryCast<String>(json['email'], ''),
    phone: tryCast<String>(json['phone'], ''),
    zip: tryCast<String>(json['zip'], ''),
    address: tryCast<String>(json['address'], ''),
    number: tryCast<String>(json['number'], ''),
    neighborhood: tryCast<String>(json['neighborhood'], ''),
    city: tryCast<String>(json['city'], ''),
    state: tryCast<String>(json['state'], ''),
    isWorker: tryCast<bool>(json['is_worker'], false),
    description: tryCast<String>(json['description'], ''),
    status: tryCast<int>(json['status'], 1),
    cause: tryCast<String>(json['cause'], ''),
    categoryId: tryCast<String>(json['categoryId'], ''),
  );

  factory AccountModel.fromUser(User user) => AccountModel(
    id: user.uid,
    name: user.displayName ?? '',
    document: '',
    email: user.email ?? '',
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
    'categoryId': categoryId,
  };
}
