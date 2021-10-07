import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/states/bloc_state.dart';
import '../../../../../core/validators/validators.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../app/bloc/category_bloc.dart';
import '../../../widgets/dropdown_widget.dart';
import '../../../widgets/error_message_widget.dart';
import '../../../widgets/text_field_widget.dart';
import '../../bloc/events/profile_event_bloc.dart';
import '../../bloc/profile_bloc.dart';
import '../../presenter/account_presenter.dart';

class WorkerPage extends StatefulWidget {
  const WorkerPage({ Key? key }) : super(key: key);

  @override
  _WorkerPageState createState() => _WorkerPageState();
}

class _WorkerPageState extends State<WorkerPage> {
  late final ProfileBloc _bloc;

  @override
  void initState() {
    _bloc = Modular.get<ProfileBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (context, state) {
        if(state is ErrorBlocState) return ErrorMessageWidget(errorMessage: state.message);

        if(state is SuccessBlocState) {
          return Form(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SwitchListTile(
                    value: (state.value as AccountPresenter).isWorker,
                    activeColor: Theme.of(context).colorScheme.secondary,
                    title: Text(
                      'Prestar serviço?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      )
                    ),
                    onChanged: (value) {
                      _bloc.saveProfileBloc.saveIsWorker(value: value);
                      _bloc.add(const GetProfileEventBloc(resend: true));
                    },
                  ),
                ),
                const SizedBox(height: 8,),
                TextFieldWidget(
                  label: "Descrição",
                  icon: Icons.description,
                  inputType: TextInputType.multiline,
                  minLines: null,
                  maxLines: null,
                  onSaved: _bloc.saveProfileBloc.saveDescription,
                  textInputAction: TextInputAction.newline,
                  validator: validateDescription,
                  value: _bloc.saveProfileBloc.presenter.description,
                ),
                const SizedBox(height: 8,),
                BlocBuilder(
                  bloc: Modular.get<CategoryBloc>(),
                  builder: (context, state) {
                    if(state is ErrorBlocState) return _onError(context, state.message);
                    if(state is SuccessBlocState) return _onState(context, state.value as List<CategoryEntity>);
                    return _onLoading(context);
                  }
                ),
              ],
            ),
          );
        }

        return const Center(child: CircularProgressIndicator(),);
      }
    );
  }

  Widget _onLoading(context) => const Center(child: CircularProgressIndicator(),);

  Widget _onError(context, String state) => const SizedBox();

  Widget _onState(BuildContext context, List<CategoryEntity> state) {
    final list = [const CategoryEntity(id: '', description: '')];
    list.addAll(state);

    return DropdownWidget<String>(
      initialValue: _bloc.saveProfileBloc.presenter.categoryId,
      onChanged: (value) {
        _bloc.saveProfileBloc.saveCategoryId(value);
        _bloc.add(const GetProfileEventBloc(resend: true));
      },
      items: list.map(
        (e) => DropdownMenuItem<String>(
          value: e.id,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.category, color: Theme.of(context).colorScheme.secondary),
              const SizedBox(width: 12,),
              Text(
                e.description.toUpperCase(),
              ),
            ],
          ),
        )
      ).toList(),
    );
  }
}