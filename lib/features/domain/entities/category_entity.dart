import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {

  final int id;
  final String description;

  const CategoryEntity({
    required this.id,
    required this.description,
  });

  @override
  List<Object> get props => [
    id,
    description,
  ];

}