import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:r_link/domain/robot/robot.dart';
import 'package:r_link/domain/robot/robot_position.dart';
import 'package:r_link/widgets/textFields/link_text_field.dart';

class AddPositionPage extends StatelessWidget {
  AddPositionPage({super.key, required this.robot});
  final Robot robot;
  final _formKey = GlobalKey<FormBuilderState>();

  List<Widget> _createTextField() {
    List<Widget> textFields = [];
    final links = robot.links;
    for (int i = 0; i < links.length; i++) {
      final textField =
          LinkTextField(link: links[i], name: "q$i", label: "Junta $i");
      textFields.add(textField);
      textFields.add(const SizedBox(height: 10));
    }
    return textFields;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar posição"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ..._createTextField(),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  final state = _formKey.currentState!;
                  if (state.saveAndValidate()) {
                    final values = state.value.values.toList();
                    final position =
                        values.map((e) => int.tryParse(e.toString())!).toList();
                    final pos = RobotPosition(3, position);
                    Navigator.pop(context, pos);
                  }
                },
                child: const Text("Adicionar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
