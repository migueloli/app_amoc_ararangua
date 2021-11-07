import 'package:app_amoc_ararangua/core/validators/validators.dart';
import 'package:app_amoc_ararangua/features/domain/entities/category_entity.dart';
import 'package:app_amoc_ararangua/features/presentation/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CreateCategoryDialog extends StatefulWidget {
  final CategoryEntity? category;
  final ValueChanged<String> onSave;

  const CreateCategoryDialog({
    Key? key,
    this.category,
    required this.onSave,
  }) : super(key: key);

  @override
  _CreateCategoryDialogState createState() => _CreateCategoryDialogState();
}

class _CreateCategoryDialogState extends State<CreateCategoryDialog> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.category?.description ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nova categoria'),
      content: TextFieldWidget(
        controller: controller,
        label: "Descrição",
        icon: Icons.category,
        inputType: TextInputType.name,
        validator: validateDescription,
        capitalization: TextCapitalization.words,
      ),
      actions: [
        TextButton(
          onPressed: () => Modular.to.pop(),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            Modular.to.pop();
            widget.onSave(controller.text);
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
