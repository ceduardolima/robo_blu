import 'package:flutter/material.dart';
import 'package:r_link/mock/robot_mock.dart';
import 'package:r_link/ui/pages/control_position/control_positions.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
          title: Text(
        "Menu",
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      )),
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
