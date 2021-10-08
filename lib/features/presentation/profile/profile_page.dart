import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/states/bloc_state.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/rectangular_button.dart';
import 'bloc/events/profile_event_bloc.dart';
import 'bloc/profile_bloc.dart';
import 'bloc/profile_page_bloc.dart';
import 'pages/person/person_page.dart';
import 'pages/worker/worker_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ModularState<ProfilePage, ProfilePageBloc> {
  final _pageController = PageController();
  late final ProfileBloc _profileBloc;

  @override
  void initState() {
    _profileBloc = Modular.get<ProfileBloc>();
    _profileBloc.add(const GetProfileEventBloc());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Perfil',),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) => bloc.add(PageProfileEventBloc(page: page)),
                children: const [
                  PersonPage(),
                  WorkerPage(),
                ],
              ),
            ),
            BlocListener(
              bloc: _profileBloc.saveProfileBloc,
              listenWhen: (oldState, state) => state is SuccessBlocState || state is ErrorBlocState,
              listener: (context, state) {
                if(state is SuccessBlocState) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Perfil salvo com sucesso.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            _profileBloc.add(const GetProfileEventBloc(resend: true));
                            Modular.to.pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else if (state is ErrorBlocState) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Ocorreu um erro.'),
                      content: Text(state.message),
                      actions: [
                        TextButton(
                          onPressed: () {
                            _profileBloc.add(const GetProfileEventBloc(resend: true));
                            Modular.to.pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: BlocBuilder(
                bloc: _profileBloc,
                builder: (context, state) {
                  if(state is ErrorBlocState) return const SizedBox();

                  if(state is SuccessBlocState) {
                    return RectangularButton(
                      label: 'Salvar',
                      icon: const Icon(Icons.check),
                      onPressed: () => _profileBloc.add(const SaveProfileEventBloc()),
                    );
                  }

                  return const Center(child: CircularProgressIndicator(),);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder(
        bloc: bloc,
        builder: _builder,
      ),
    );
  }

  Widget _builder(context, state) {
      var page = 0;
      if(state is SuccessBlocState && state.value is int) page = state.value as int;

      return BottomNavigationBar(
        currentIndex: page,
        onTap: (i) => _pageController.animateToPage(i,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linearToEaseOut,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Dados',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Serviço',
          ),
        ],
      );
    }
}
