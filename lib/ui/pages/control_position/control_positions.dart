import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:r_link/domain/robot/robot.dart';
import 'package:r_link/domain/robot/robot_position.dart';
import 'package:r_link/mock/robot_mock.dart';
import 'package:r_link/resources/theme/app_theme.dart';
import 'package:r_link/ui/widgets/dialogs/add_position_page.dart';

class ControlPositionsPage extends StatefulWidget {
  const ControlPositionsPage({super.key, required this.robot});
  final Robot robot;

  @override
  State<ControlPositionsPage> createState() => _ControlPositionsPageState();
}

class _ControlPositionsPageState extends State<ControlPositionsPage> {
  List<RobotPosition> positions = [];

  @override
  void initState() {
    setState(() => positions.add(robot.initialPosition));
    super.initState();
  }

  Future<RobotPosition> _addPosition(BuildContext context) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddPositionPage(robot: robot),
        ));
  }

  Widget _sendPositions() {
    return IconButton(
      onPressed: () {
        if (positions.isNotEmpty) {}
      },
      icon: const Icon(Icons.send),
    );
  }

  Widget _tile(RobotPosition pos, index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: index == 0
              ? const Text("Posição inicial")
              : Text("Posição ${index + 1}"),
          subtitle: Text(pos.toString()),
          trailing: index != 0 ? _deletePosButton(index) : null,
        ),
        const Divider()
      ],
    );
  }

  Widget _deletePosButton(int index) {
    return IconButton(
      icon: Icon(
        Icons.delete,
        color: colorScheme.secondary,
      ),
      onPressed: () {
        setState(() => positions.removeAt(index));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Controlar Posição"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [_sendPositions()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          RobotPosition position = await _addPosition(context);
          setState(() => positions.add(position));
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: positions.isEmpty
              ? const Center(child: Text("Não há posições registradas"))
              : ListView.builder(
                  itemCount: positions.length,
                  itemBuilder: (context, index) {
                    final pos = positions[index];
                    return _tile(pos, index);
                  },
                )),
    );
  }
}
