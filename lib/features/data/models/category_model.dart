import '../../../core/custom_methods/try_cast.dart';
import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {

  const CategoryModel({
    required String id,
    required String description,
  }) : super(
    id: id,
    description: description,
  );

  factory CategoryModel.fromJson(Map<String, dynamic> json, {String? id}) => CategoryModel(
    id: id ?? tryCast<String>(json['id'], ''),
    description: tryCast<String>(json['description'], ''),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'description': description,
  };

}