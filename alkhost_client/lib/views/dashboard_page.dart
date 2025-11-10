import 'package:alkhost_client/components/service_card.dart';
import 'package:alkhost_client/providers/docker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DockerProvider>(context);

    provider.loadServices();

    return Expanded(
      child: Column(
        children: [
          ListView(
            children: provider.services
                .map((service) => ServiceCard(service: service, onStart: () {}))
                .toList(),
          ),
        ],
      ),
    );
  }
}
