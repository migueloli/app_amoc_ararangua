import 'package:app_amoc_ararangua/core/validators/validators.dart';

import 'package:app_amoc_ararangua/features/presentation/create_account/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kayta/kayta.dart';

class PersonPage extends StatelessWidget {
  final GlobalKey<FormState> _form = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: [
          TextFieldWidget(
                label: "CPF",
                icon: Icon(Icons.payment),
                inputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfOuCnpjFormatter(),
                ],
                validator: validateDocument,
                onSaved: (value) {},
                textInputAction: TextInputAction.next,
                value: "",
              ),
              TextFieldWidget(
                label: "Telefone",
                icon: Icon(Icons.phone_android),
                inputType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter()
                ],
                validator: validatePhone,
                onSaved: (value) {},
                textInputAction: TextInputAction.next,
                value: "",
              ),
              TextFieldWidget(
                label: "CEP",
                icon: Icon(Icons.pin_drop),
                inputType: TextInputType.number,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter(),
                ],
                validator: validateZip,
                onSaved: (value) {},
                value: "",
              ),
              TextFieldWidget(
                label: "Endereço",
                icon: Icon(Icons.place),
                validator: validateAddress,
                onSaved: (value) {},
                capitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                value: "",
              ),
              TextFieldWidget(
                label: "Número",
                icon: Icon(Icons.exposure_zero),
                onSaved: (value) {},
                textInputAction: TextInputAction.next,
                value: "",
              ),
              TextFieldWidget(
                label: "Bairro",
                icon: Icon(Icons.place),
                validator: validateNeighborhood,
                onSaved: (value) {},
                capitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                value: "",
              ),
              TextFieldWidget(
                label: "Cidade",
                icon: Icon(Icons.map),
                validator: validateCity,
                onSaved: (value) {},
                capitalization: TextCapitalization.characters,
                value: "",
              ),
              TextFieldWidget(
                label: 'Estado',
                icon: Icon(Icons.map),
                onSaved: (value) {},
              ),
        ],
      )
    );
  }
}