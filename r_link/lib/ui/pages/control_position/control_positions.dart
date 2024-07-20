import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:r_link/domain/comunication/transmition.dart';
import 'package:r_link/domain/robot/robot.dart';
import 'package:r_link/domain/robot/robot_position.dart';
import 'package:r_link/mock/robot_mock.dart';
import 'package:r_link/repositories/global_device.dart';
import 'package:r_link/resources/theme/app_theme.dart';
import 'package:r_link/ui/widgets/dialogs/add_position_page.dart';
import 'package:r_link/utils/log.dart';

class ControlPositionsPage extends StatefulWidget {
  const ControlPositionsPage(
      {super.key, required this.robot, required this.device});

  final BluetoothDevice? device;
  final Robot robot;

  @override
  State<ControlPositionsPage> createState() => _ControlPositionsPageState();
}

class _ControlPositionsPageState extends State<ControlPositionsPage> {
  List<RobotPosition> positions = [];
  List<BluetoothService> _services = [];
  StreamSubscription<BluetoothConnectionState>?
      _connectionStateSubscription;
  BluetoothConnectionState _connectionState =
      BluetoothConnectionState.disconnected;

  @override
  void initState() {
    setState(() => positions.add(robot.initialPosition));
    if (widget.device != null) {
      _connectionStateSubscription =
          widget.device!.connectionState.listen((state) async {
        _connectionState = state;
        if (state == BluetoothConnectionState.connected) {}
        if (mounted) {
          setState(() {});
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    if (_connectionStateSubscription != null) {
      _connectionStateSubscription!.cancel();
    }
    super.dispose();
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
      onPressed: () async {
        await onWritePressed();
      },
      icon: const Icon(Icons.send),
    );
  }

  Future onWritePressed() async {
    try {
      if (GlobalDevice.device != null) {
        final c = GlobalDevice.device!.getCharacteristic();
        final pos = transmite(robot, positions);
        Log.i("Enviando: $pos");
        await c.write(
          pos,
          withoutResponse: c.properties.writeWithoutResponse,
        );
      }
    } catch (e) {
      Log.f("Falha ao enviar as posições", error: e);
    }
  }

  Widget _tile(Robot robot, RobotPosition pos, index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: index == 0
              ? const Text("Posição inicial")
              : Text("Posição ${index + 1}"),
          subtitle: Text(
              "Juntas: $pos\nFerramenta: ${robot.toolPosition(pos)}"),
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
        color: colorScheme.error,
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
                  return _tile(robot, pos, index);
                },
              ),
      ),
    );
  }
}
