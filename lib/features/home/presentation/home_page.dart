import 'package:flutter/material.dart';
import 'package:multas_app/features/doc/presentation/doc_page.dart';
import 'package:multas_app/core/services/database_helper.dart';
import 'package:multas_app/common/models/doc_model.dart';
import 'package:multas_app/core/widgets/doc_home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DocumentsPage()),
              );
            },
          )
        ],
      ),
      body: Center(
        child: _buildMainColumn(),
      ),
    );
  }

  Widget _buildMainColumn() => ListView(shrinkWrap: true, children: [
        _buildTopImage(),
        const SizedBox(
          height: 25.0,
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 5),
                  child: _buildRating(),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: _buildDocHome(context),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  // child: _buildBanner(),
                ),
              ],
            ),
          ),
        ),
      ]);

  Widget _buildTopImage() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/home.png',
              width: 150,
            ),
          ],
        ),
      );

  Widget _buildRating() => const ListTile(
        title: Text(
          'Mis vehículo',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
      );

  Widget _buildDocHome(BuildContext context) => FutureBuilder<List<Task>>(
        future: dbHelper.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tienes ningún vehículo'));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<Task> tasks = snapshot.data!;
            final List<Task> filteredTasks = tasks
                .where((task) => task.description == 'Patente'
                    // || task.description == 'DNI',
                    )
                .toList();

            return ListView.builder(
              shrinkWrap: true,
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) => DocHomeWidget(
                task: filteredTasks[index],
              ),
            );
          }
        },
      );
}
