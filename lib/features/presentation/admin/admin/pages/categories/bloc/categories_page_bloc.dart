import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/states/bloc_state.dart';
import '../../../../../../domain/entities/category_entity.dart';
import '../../../../../../domain/repositories/categories_repository.dart';
import 'events/categories_page_bloc_event.dart';

class CategoriesPageBloc extends Bloc<CategoriesPageBlocEvent, BlocState> {
  final ICategoriesRepository categoryRepository;
  final List<CategoryEntity> list = [];

  CategoriesPageBloc(this.categoryRepository) : super(BlocState.empty());

  @override
  Stream<BlocState> mapEventToState(CategoriesPageBlocEvent event) async* {
    yield BlocState.loading();
    if(event is GetCategoriesBlocEvent) {
      final result = await categoryRepository.getListOfCategories();
      yield result.fold(
        (failure) => BlocState.error(_processFailure(failure)),
        (entity) {
          list.clear();
          list.addAll(entity);
          return BlocState.success(list);
        }
      );
    } else if(event is SaveCategoryBlocEvent) {
      final result = await categoryRepository.saveCategory(CategoryEntity(id: event.id, description: event.description));
      yield result.fold(
        (failure) => BlocState.error(_processFailure(failure)),
        (entity) {
          list.add(entity);
          return BlocState.success(list);
        }
      );
    }
  }

  String _processFailure(Failure failure) {
    switch(failure.runtimeType) {
      case NetworkFailure:
        return networkFailureMessage;
      case ServerFailure:
        return serverFailureMessage;
    }

    return genericFailureMessage;
  }

  static const networkFailureMessage = 'Não foi possível conectar a internet, verifique as conexões do aparelho.';
  static const serverFailureMessage = 'Ocorreu um erro na comunicação com o servidor, tente novamente.';
  static const genericFailureMessage = 'Ocorreu um erro, tente novamente.';

}
