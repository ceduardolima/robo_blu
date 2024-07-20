import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:r_link/mock/robot_mock.dart';
import 'package:r_link/repositories/global_device.dart';
import 'package:r_link/ui/pages/bluetooth_connection/bluetooth_connection_page.dart';
import 'package:r_link/ui/pages/control_position/control_positions.dart';
import 'package:r_link/ui/utils/app_snackbar.dart';
import 'package:r_link/ui/utils/extra.dart';
import 'package:r_link/ui/utils/global_variable.dart';
import 'package:r_link/utils/log.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  StreamSubscription<BluetoothConnectionState>?
      _connectionStateSubscription;

  @override
  void initState() {
    _checkDeviceConnection();
    super.initState();
  }

  void _checkDeviceConnection() {
    final device = _getDevice();
    if (device == null) return;
    _connectionStateSubscription = device.connectionState.listen(
      (state) async {
        if (state == BluetoothConnectionState.connected) {
          Log.i("Conectado ao device: ${device.platformName}");
        } else if (state == BluetoothConnectionState.disconnected) {
          _reconnectToDevice(device);
        }
        if (mounted) {
          setState(() {});
        }
      },
    );
  }


  @override
  void dispose() {
    if (_connectionStateSubscription != null) {
      _connectionStateSubscription!.cancel();
    }
    super.dispose();
  }

  Widget buildBluetoothButton(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BluetoothConnectionPage(),
          ),
        );
        setState(() {});
      },
      icon: const Icon(Icons.bluetooth),
    );
  }

  String _getConnectedName() {
    if (GlobalDevice.device == null) {
      return "Nenhum";
    } else {
      final device = GlobalDevice.device!.device;
      return device.platformName.isEmpty
          ? device.remoteId.str
          : device.platformName;
    }
  }

  BluetoothDevice? _getDevice() {
    final devices = FlutterBluePlus.connectedDevices;
    return devices.isEmpty ? null : devices[0];
  }

  void _reconnectToDevice(BluetoothDevice device) async {
    Log.i(("Conectando..."));
    await device.connectAndUpdateStream().catchError((e) {
      GlobalVariables.getScaffoldState()
          .showSnackBar(snackBar("Não foi possível conectar ao device"));
    });
    Log.i(("Conectado!"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 5, 10, 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Dispositivo conectado: ${_getConnectedName()}",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        actions: [buildBluetoothButton(context)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ControlPositionsPage(
                      robot: robot,
                      device: _getDevice(),
                    ),
                  ),
                );
              },
              child: Container(
                decoration:
                    BoxDecoration(color: Theme.of(context).colorScheme.surface),
                child: const ListTile(
                  title: Text("Controlar passo a passo"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
