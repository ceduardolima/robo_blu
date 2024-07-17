import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:r_link/mock/robot_mock.dart';
import 'package:r_link/ui/pages/bluetooth_connection/bluetooth_connection_page.dart';
import 'package:r_link/ui/pages/control_position/control_positions.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget buildBluetoothButton(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BluetoothConnectionPage(),
          ),
        );
        setState((){});
      },
      icon: const Icon(Icons.bluetooth),
    );
  }

  String _getConnectedName() {
    if (FlutterBluePlus.connectedDevices.isEmpty) {
      return "Nenhum";
    } else {
      final name = FlutterBluePlus.connectedDevices[0].platformName;
      final id = FlutterBluePlus.connectedDevices[0].remoteId.str;
      return name.isNotEmpty ? name : id;
    }
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
          preferredSize: Size.fromHeight(30),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 5, 10, 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Dispositivo conectado: ${_getConnectedName()}", style: TextStyle(color: Colors.white),),
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
                      ),
                    ));
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
