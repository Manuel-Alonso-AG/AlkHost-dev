import 'package:alkhost_client/models/database.dart';
import 'package:alkhost_client/providers/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class DatabasePage extends StatefulWidget {
  const DatabasePage({super.key});

  @override
  State<DatabasePage> createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  void _loadData() {
    final provider = context.read<DatabaseProvider>();
    provider.loadDatabases();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (BuildContext context, databaseProvider, Widget? child) {
        if (databaseProvider.isLoading && databaseProvider.databases.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        if (databaseProvider.error != null) {
          return Text(databaseProvider.error!);
        }
        return ListView(
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
                        Text('Bases de datos'),
                        IconButton(
                          onPressed: _loadData,
                          icon: Icon(Icons.refresh),
                        ),
                      ],
                    ),
                    SearchBar(
                      leading: Icon(Icons.search),
                      hintText: 'Buscar base de datos',
                      constraints: BoxConstraints(minHeight: 45),
                    ),
                  ],
                ),
              ),
            ),

            Column(
              children: databaseProvider.databases.map(_buildTitle).toList(),
            ),
          ],
        );
      },
    );
  }

  ExpansionTile _buildTitle(Database database) {
    return ExpansionTile(
      expandedAlignment: Alignment.centerLeft,
      childrenPadding: EdgeInsets.all(8),
      title: Row(
        spacing: 8,
        children: [
          Icon(Symbols.database_rounded, fill: 1),
          Text(database.name),
        ],
      ),
      children: database.tables
          .map(
            (table) => Row(
              spacing: 8,
              children: [
                Icon(Symbols.data_table_rounded, fill: 1),
                Text(table),
              ],
            ),
          )
          .toList(),
    );
  }
}
