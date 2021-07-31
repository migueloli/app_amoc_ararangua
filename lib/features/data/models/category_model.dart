import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {

  const CategoryModel({
    required String id,
    required String description,
  }) : super(
    id: id,
    description: description,
  );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'],
    description: json['description'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'description': description,
  };

}