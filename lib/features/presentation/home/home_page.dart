import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../widgets/app_bar_widget.dart';
import 'pages/account/account_page.dart';
import 'pages/services/services_page.dart';
import 'store/home_store.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'AMOC'),
      body: PageView(
        controller: _pageController,
        onPageChanged: controller.changePage,
        children: _getPages(),
      ),
      bottomNavigationBar: ScopedBuilder(
        store: controller,
        onState: _onState,
      ),
    );
  }

  List<Widget> _getPages() => [
    ServicesPage(),
    AccountPage(),
  ];

  Widget _onState(BuildContext context, int state) => BottomNavyBar(
    selectedIndex: state,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    onItemSelected: (i) => _pageController.animateToPage(i,
      duration: Duration(milliseconds: 500),
      curve: Curves.linearToEaseOut
    ),
    items: _getBottomNavyBarItems(context),
  );

  List<BottomNavyBarItem> _getBottomNavyBarItems(BuildContext context) => [
    BottomNavyBarItem(
      icon: Icon(Icons.business),
      title: Text('Serviços'),
      textAlign: TextAlign.center,
      activeColor: Theme.of(context).accentColor,
      inactiveColor: Theme.of(context).accentColor,
    ),
    BottomNavyBarItem(
      icon: Icon(Icons.person_pin_circle),
      title: Text('Conta'),
      textAlign: TextAlign.center,
      activeColor: Theme.of(context).accentColor,
      inactiveColor: Theme.of(context).accentColor,
    ),
  ];
}
