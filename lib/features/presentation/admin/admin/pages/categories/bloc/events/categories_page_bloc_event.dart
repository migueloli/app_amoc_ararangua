import 'package:equatable/equatable.dart';

abstract class CategoriesPageBlocEvent extends Equatable {
  const CategoriesPageBlocEvent();
}

class GetCategoriesBlocEvent extends CategoriesPageBlocEvent {
  const GetCategoriesBlocEvent();

  @override
  List<Object?> get props => [];
}

class SaveCategoryBlocEvent extends CategoriesPageBlocEvent {
  final String id;
  final String description;

  const SaveCategoryBlocEvent(this.id, this.description);

  @override
  List<Object?> get props => [description];
}
