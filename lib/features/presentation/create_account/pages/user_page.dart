import 'package:app_amoc_ararangua/core/validators/validators.dart';
import 'package:app_amoc_ararangua/features/presentation/create_account/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {

  final GlobalKey<FormState> _form = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: ListView(
        children: <Widget>[
          TextFieldWidget(
            label: "Nome",
            icon: Icon(Icons.person),
            inputType: TextInputType.name,
            validator: validateName,
            onSaved: (value) {},
            capitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
          ),
          TextFieldWidget(
            label: "E-mail",
            icon: Icon(Icons.mail),
            inputType: TextInputType.emailAddress,
            validator: validateEmail,
            onSaved: (value) {},
            textInputAction: TextInputAction.next,
          ),
          TextFieldWidget(
            label: "Senha",
            icon: Icon(Icons.lock),
            validator: validatePassword,
            onSaved: (value) {},
            obscureText: true,
            textInputAction: TextInputAction.next,
          ),
          TextFieldWidget(
            label: "Confirmação Senha",
            icon: Icon(Icons.lock),
            validator: validatePassword,
            onSaved: (value) {},
            obscureText: true,
            textInputAction: TextInputAction.done,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SwitchListTile(
              value: true,
              title: Text('Prestar serviço?'),
              onChanged: (value) {},
            ),
          ),
          Divider(),
          SizedBox(height: 10,),
        ],
      ),
    );
  }

}