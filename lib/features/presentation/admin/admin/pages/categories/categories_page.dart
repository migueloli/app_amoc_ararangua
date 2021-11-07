import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../core/states/bloc_state.dart';
import '../../../../../domain/entities/category_entity.dart';
import '../../../../widgets/error_message_widget.dart';
import '../../widgets/create_category_dialog.dart';
import 'bloc/categories_page_bloc.dart';
import 'bloc/events/categories_page_bloc_event.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({ Key? key }) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends ModularState<CategoriesPage, CategoriesPageBloc> {

  @override
  void initState() {
    bloc.add(const GetCategoriesBlocEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if(state is SuccessBlocState) return _onState(state.value as List<CategoryEntity>);

        if(state is ErrorBlocState) return _onError(context, state.message);

        return _onLoading(context);
      },
    );
  }

  Widget _onLoading(BuildContext context) => const Center(
    child: CircularProgressIndicator(),
  );

  Widget _onError(BuildContext context, String? error) => ErrorMessageWidget(
    errorMessage: error ?? 'Ocorreu um erro, tente novamente.',
  );

  Widget _onState(List<CategoryEntity> list) => ListView.builder(
    itemCount: list.length,
    itemBuilder: (context, index) => _buildCategories(context, list[index]),
  );

  Widget _buildCategories(BuildContext context, CategoryEntity item) => ListTile(
    leading: const Icon(Icons.category),
    title: Text(item.description),
    onLongPress: () => _showCreateCategoryDialog(context, item),
  );

  Future _showCreateCategoryDialog(BuildContext context, CategoryEntity? item) => showDialog(
    context: context,
    builder: (context) => CreateCategoryDialog(
      category: item,
      onSave: (value) => bloc.add(SaveCategoryBlocEvent(item?.id ?? '', value)),
    ),
  );
}
