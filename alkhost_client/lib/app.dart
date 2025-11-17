import 'package:alkhost_client/views/pages/controll_panel_page.dart';
import 'package:alkhost_client/views/pages/database_page.dart';
import 'package:alkhost_client/views/pages/projects_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/theme.dart';
import 'views/main_layout.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'AlkHost',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: _routes,
    );
  }
}

final GoRouter _routes = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
      routes: [
        GoRoute(path: '/', redirect: (context, state) => '/controlPanel'),
        GoRoute(
          path: '/controlPanel',
          builder: (context, state) => const ControllPanelPage(),
        ),
        GoRoute(
          path: '/projects',
          builder: (context, state) => const ProjectsPage(),
        ),
        GoRoute(
          path: '/databases',
          builder: (context, state) => const DatabasePage(),
        ),
      ],
    ),
  ],
);
