import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/states/bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/create_account_bloc.dart';
import 'pages/person_page.dart';
import 'pages/user_page.dart';
import 'pages/worker_page.dart';

class CreateAccountPage extends StatelessWidget {
  final CreateAccountBloc createAccountBloc = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Conta'),
      ),
      body: BlocBuilder<CreateAccountBloc, BlocState>(
        bloc: createAccountBloc,
        builder: (context, state) {
          final currentStep = state is SuccessBlocState ? state.value : 0;

          return Stepper(
            currentStep: currentStep,
            type: StepperType.horizontal,
            onStepContinue: () => createAccountBloc.add(ChangeStepEvent(step: currentStep+1)),
            onStepCancel: currentStep > 0 ? () => createAccountBloc.add(ChangeStepEvent(step: currentStep-1)) : null,
            steps: [
              Step(
                title: Text('Usuário'),
                content: UserPage(),
                state: _getStepState(currentStep, 0),
              ),
              Step(
                title: Text('Dados'),
                content: PersonPage(),
                state: _getStepState(currentStep, 1),
              ),
              Step(
                title: Text('Serviço'),
                content: WorkerPage(),
                state: _getStepState(currentStep, 2),
              ),
            ],
          );
        }
      ),
    );
  }

  StepState _getStepState(int currentStep, int indexForStep) {
    if(currentStep > indexForStep) {
      return StepState.complete;
    } else if(currentStep < indexForStep) {
      return StepState.disabled;
    } else {
      return StepState.editing;
    }
  }
}