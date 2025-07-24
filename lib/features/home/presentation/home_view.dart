import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../documents/providers/task_providers.dart';
import 'widgets/vehicle_card.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicleTasks = ref.watch(vehicleTasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Multas'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/images/home.png',
                width: 150,
              ),
            ),
            const SizedBox(height: 25),
            const ListTile(
              title: Text(
                'Mis vehículos',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
            ),
            if (vehicleTasks.isEmpty)
              const Center(child: Text('No tienes ningún vehículo'))
            else
              ...vehicleTasks.map((task) => VehicleCard(task: task)),
          ],
        ),
      ),
    );
  }
}
