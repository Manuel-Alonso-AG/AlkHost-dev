import '../models/docker_service.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final DockerService service;
  final VoidCallback? onStart;
  final VoidCallback? onStop;
  final VoidCallback? onRestart;
  const ServiceCard({
    super.key,
    required this.service,
    this.onStart,
    this.onStop,
    this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 2,
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(service.name),
                Text('Puerto local: ${service.port}'),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: service.isRunning ? null : onStart,
                  child: Text('Iniciar'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: service.isRunning ? onStop : null,
                  child: Text('Detener'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: service.isRunning ? onRestart : null,
                  child: Text('Reiniciar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
