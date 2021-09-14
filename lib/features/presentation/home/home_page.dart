import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/states/bloc_state.dart';
import '../widgets/app_bar_widget.dart';
import 'bloc/events/home_bloc_event.dart';
import 'bloc/home_bloc.dart';
import 'pages/account/account_page.dart';
import 'pages/services/services_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeBloc> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'AMOC'),
      body: PageView(
        controller: _pageController,
        onPageChanged: (page) => bloc.add(PageHomeBlocEvent(page: page)),
        children: _getPages(),
      ),
      bottomNavigationBar: BlocBuilder(
        bloc: bloc,
        builder: _buildBottomNavigationBar,
      ),
    );
  }

  List<Widget> _getPages() => [
    ServicesPage(),
    AccountPage(),
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
        curve: Curves.linearToEaseOut
      ),
      items: _getBottomNavigationBarItems(context),
    );
  }

  List<BottomNavigationBarItem> _getBottomNavigationBarItems(BuildContext context) => const [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Serviços',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_pin_circle),
      label: 'Conta',
    ),
  ];
}
