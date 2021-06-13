import 'package:app_amoc_ararangua/core/states/bloc_state.dart';
import 'package:app_amoc_ararangua/features/presentation/home/bloc/home_bloc.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'pages/account/account_page.dart';
import 'pages/services/services_page.dart';

class HomePage extends StatelessWidget {

  final _pageController = PageController();
  final HomeBloc homeBloc = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AMOC',
        ),
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (i) => homeBloc.add(PageControllerEvent(i)),
        children: <Widget>[
          ServicesPage(),
          AccountPage(),
        ],
      ),
      bottomNavigationBar: BlocBuilder<HomeBloc, BlocState>(
        bloc: homeBloc,
        builder: (_, state) {
          final page;
          if(state is SuccessBlocState) {
            page = state.value;
          } else {
            page = 0;
          }

          return BottomNavyBar(
            selectedIndex: page,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            onItemSelected: (i) => _pageController.animateToPage(i,
                duration: Duration(milliseconds: 500),
                curve: Curves.linearToEaseOut),
            items: [
              BottomNavyBarItem(
                icon: Icon(Icons.business),
                title: Text('Serviços'),
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.person_pin_circle),
                title: Text('Conta'),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}
