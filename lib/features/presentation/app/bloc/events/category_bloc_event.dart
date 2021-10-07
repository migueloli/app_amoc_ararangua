import 'package:equatable/equatable.dart';

abstract class CategoryBlocEvent extends Equatable {
  const CategoryBlocEvent();
}

class GetCategoryEvent extends CategoryBlocEvent {
  const GetCategoryEvent();

  @override
  List<Object?> get props => [];
}
