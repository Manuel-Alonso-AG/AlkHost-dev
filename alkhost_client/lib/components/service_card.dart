import 'package:alkhost_client/models/docker_service.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final DockerService service;
  final VoidCallback onStart;

  const ServiceCard({super.key, required this.service, required this.onStart});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(
          service.isRunning ? Icons.check_circle : Icons.cancel,
          color: service.isRunning ? Colors.green : Colors.red,
        ),
        title: Text(service.name),
        subtitle: Text(service.state),
        trailing: ElevatedButton(
          onPressed: service.isRunning ? null : onStart,
          child: Text('Iniciar'),
        ),
      ),
    );
  }
}
