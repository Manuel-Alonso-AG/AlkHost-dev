import 'package:alkhost_client/providers/services_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/service_card.dart';

class ControllPanelPage extends StatefulWidget {
  const ControllPanelPage({super.key});

  @override
  State<ControllPanelPage> createState() => _ControllPanelPageState();
}

class _ControllPanelPageState extends State<ControllPanelPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  void _loadData() {
    final provider = context.read<ServicesProvider>();
    provider.loadServices();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServicesProvider>(
      builder: (BuildContext context, servicesProvider, Widget? child) {
        if (servicesProvider.isLoading && servicesProvider.services.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        if (servicesProvider.error != null) {
          return Text(servicesProvider.error!);
        }
        return Column(
          spacing: 8,
          children: [
            Card(
              elevation: 2,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Servicios'),
                        IconButton(
                          onPressed: _loadData,
                          icon: Icon(Icons.refresh),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: servicesProvider.services.length,
                itemBuilder: (context, index) {
                  final service = servicesProvider.services[index];

                  return ServiceCard(
                    service: service,
                    onStop: () => servicesProvider.stopService(service.id),
                    onStart: () => servicesProvider.startService(service.id),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
