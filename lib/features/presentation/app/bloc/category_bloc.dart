import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/states/bloc_state.dart';
import '../../../domain/repositories/categories_repository.dart';
import 'events/category_bloc_event.dart';

class CategoryBloc extends Bloc<CategoryBlocEvent, BlocState> {
  final ICategoriesRepository categoryRepository;

  CategoryBloc(this.categoryRepository) : super(BlocState.empty());

  @override
  Stream<BlocState> mapEventToState(CategoryBlocEvent event) async* {
    if(event is GetCategoryEvent) {
      yield BlocState.loading();
      final result = await categoryRepository.getListOfCategories();
      yield result.fold(
        (failure) => BlocState.error('Ocorreu um erro ao buscar as categorias.'),
        (entity) => BlocState.success(entity),
      );
    }
  }
}