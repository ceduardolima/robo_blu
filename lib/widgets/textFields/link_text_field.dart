import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:r_link/domain/links/link.dart';

class LinkTextField extends StatelessWidget {
  const LinkTextField({
    super.key,
    required this.link,
    required this.name,
    required this.label,
  });

  final Link link;
  final String name;
  final String label;

  String? _validator(String? value) {
    if (value == null) {
      return 'Campo obrigatório';
    } else {
      final number = int.tryParse(value);
      if (number == null) return 'O campo deve ser numérico';
      if (link.bound != null) {
        if (!link.bound!.isValid(number)) {
          return 'Valor deve estar entre ${link.bound!.lower} e ${link.bound!.upper}';
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      keyboardType: TextInputType.number,
      validator: _validator,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
