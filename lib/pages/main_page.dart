import 'package:flutter/material.dart';
import 'package:r_link/mock/robot_mock.dart';
import 'package:r_link/pages/control_position/control_positions.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
                      builder: (context) => ControlPositionsPage(robot: robot,),
                    ));
              },
              child: Container(
                child: ListTile(
                  title: Text("Controlar Posições"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
