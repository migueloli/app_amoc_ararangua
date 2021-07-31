import 'package:flutter/material.dart';

import '../../../../../core/validators/validators.dart';
import '../../widgets/dropdown_widget.dart';
import '../../widgets/text_field_widget.dart';

class WorkerPage extends StatelessWidget {
  final GlobalKey<FormState> _form = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SwitchListTile(
              value: true,
              title: Text('Prestar serviço?'),
              onChanged: (value) {},
            ),
          ),
          TextFieldWidget(
            label: "Descrição",
            icon: Icon(Icons.description),
            inputType: TextInputType.multiline,
            minLines: 3,
            onSaved: (value) {},
            textInputAction: TextInputAction.newline,
            value: '',
            validator: validateDescription,
          ),
          DropdownWidget<String>(
            initialValue: '',
            onChanged: (value) {},
            items: [].map(
              (e) => DropdownMenuItem<String>(
                value: e.description,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.category,),
                    SizedBox(width: 12,),
                    Text(
                      e.description.toUpperCase(),
                    ),
                  ],
                ),
              )
            ).toList(),
          ),
        ],
      )
    );
  }
}