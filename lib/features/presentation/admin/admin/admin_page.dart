import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/states/bloc_state.dart';
import '../../widgets/app_bar_widget.dart';
import 'bloc/admin_bloc.dart';
import 'bloc/events/admin_bloc_event.dart';
import 'pages/accounts/accounts_page.dart';
import 'pages/categories/bloc/categories_page_bloc.dart';
import 'pages/categories/bloc/events/categories_page_bloc_event.dart';
import 'pages/categories/categories_page.dart';
import 'widgets/create_category_dialog.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({ Key? key }) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends ModularState<AdminPage, AdminBloc> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Admin'),
      body: PageView(
        controller: _pageController,
        children: _getPages(),
        onPageChanged: (i) => bloc.add(PageAdminBlocEvent(page: i)),
      ),
      bottomNavigationBar: BlocBuilder(
        bloc: bloc,
        builder: _buildBottomNavigationBar,
      ),
      floatingActionButton: BlocBuilder(
        bloc: bloc,
        builder: _buildFloatingActionButton,
      ),
    );
  }

  List<Widget> _getPages() => const [
    AccountsPage(),
    CategoriesPage(),
  ];

  Widget _buildBottomNavigationBar(BuildContext context, BlocState state) {
    var index = 0;
    if(state is SuccessBlocState && state.value is int) {
      index = state.value as int;
    }

    return BottomNavigationBar(
      currentIndex: index,
      onTap: (i) => _pageController.animateToPage(i,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut,
      ),
      items: _getBottomNavigationBarItems(context),
    );
  }

  List<BottomNavigationBarItem> _getBottomNavigationBarItems(BuildContext context) => const [
    BottomNavigationBarItem(
      icon: Icon(Icons.person_pin_circle),
      label: 'Contas',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: 'Categorias',
    ),
  ];

  Widget _buildFloatingActionButton(BuildContext context, BlocState state) {
    if(state is SuccessBlocState && state.value is int && state.value == 1) {
      return FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showCreateCategoryDialog(context),
      );
    }

    return const SizedBox();
  }

  Future _showCreateCategoryDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) => CreateCategoryDialog(
      onSave: (value) => Modular.get<CategoriesPageBloc>().add(SaveCategoryBlocEvent('', value)),
    ),
  );
}
