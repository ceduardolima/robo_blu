import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DefaultTextField extends StatefulWidget {
  const DefaultTextField({
    super.key,
    required this.name,
    required this.label,
    this.hint,
    this.maxLines = 1,
    this.controller,
  });

  final String name;
  final String label;
  final String? hint;
  final int maxLines;
  final TextEditingController? controller;

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: widget.name,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
      ),
      maxLines: widget.maxLines,
    );
  }
}
