import 'package:app_amoc_ararangua/core/validators/validators.dart';
import 'package:flutter/material.dart';

import '../../widgets/text_field_widget.dart';

class UserPage extends StatelessWidget {

  final GlobalKey<FormState> _form = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: <Widget>[
          Divider(),
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
          Divider(),
          SizedBox(height: 10,),
        ],
      ),
    );
  }

}