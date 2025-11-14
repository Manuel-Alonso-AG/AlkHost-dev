import 'package:alkhost_client/models/docker_service.dart';
import 'package:alkhost_client/widgets/service_card.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final List<DockerService> services = [
    DockerService(
      id: "id",
      name: "node",
      image: "img",
      state: "exited",
      status: "status",
      port: 3000,
    ),
    DockerService(
      id: "id",
      name: "Php",
      image: "img",
      state: "exited",
      status: "status",
      port: 9000,
    ),
    DockerService(
      id: "id",
      name: "MySQL",
      image: "img",
      state: "exited",
      status: "status",
      port: 3308,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.black45)),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 8,
                        children: [
                          _buildHeaderMain(),
                          Column(
                            children: services
                                .map((service) => ServiceCard(service: service))
                                .toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildCardStat(
                                "Proyectos totales",
                                "5 encontrados",
                                Icons.folder,
                                acction: TextButton(
                                  onPressed: () {},
                                  child: Text('Abrir Dashboard web'),
                                ),
                              ),
                              _buildCardStat(
                                "Bases de datos totales",
                                "5 encontrados",
                                Icons.archive,
                                acction: TextButton(
                                  onPressed: () {},
                                  child: Text('Ver detalles'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Card _buildCardStat(
    String title,
    String content,
    IconData icon, {
    Widget? acction,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 8,
          children: [
            Text(title),
            Row(spacing: 8, children: [Icon(icon), Text(content)]),
            acction ?? SizedBox(),
          ],
        ),
      ),
    );
  }

  Container _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black45)),
      ),
      child: ListTile(
        title: Text("AlkHost -dev"),
        subtitle: Text(
          "Entorno de desarrollo web local realizado con node, uso de PHP + MySQL",
        ),
      ),
    );
  }

  Container _buildHeaderMain() {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      child: Text("Servicios", textAlign: TextAlign.left),
    );
  }
}
