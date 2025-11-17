import 'package:alkhost_client/providers/database_provider.dart';
import 'package:alkhost_client/providers/projects_provider.dart';
import 'package:alkhost_client/providers/services_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';

void main() {
  //!Agregar providers
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ServicesProvider()),
        ChangeNotifierProvider(create: (_) => ProjectsProvider()),
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
      ],
      child: const App(),
    ),
  );
}
