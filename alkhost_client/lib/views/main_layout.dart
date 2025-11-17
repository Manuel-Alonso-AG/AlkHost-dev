import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final List<NavigationItem> _navItems = [
    NavigationItem(
      icon: Symbols.dashboard_rounded,
      label: 'Panel de control',
      route: '/controlPanel',
    ),
    NavigationItem(
      icon: Symbols.folder_rounded,
      label: 'Proyectos',
      route: '/projects',
    ),
    NavigationItem(
      icon: Symbols.database_rounded,
      label: 'Bases de datos',
      route: '/databases',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(flex: 1, child: _buildDrawer()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              //linear-gradient(120deg, #289455 0%, #20a2ac 35%, #2b4f9e 100%);
              gradient: LinearGradient(
                colors: [
                  Color(0xFF289455),
                  Color(0xFF20A2AC),
                  Color(0xFF2B4F9E),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.developer_board, size: 32, color: Colors.white),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Alkhost -Dev',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Admin Panel',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: _navItems.length,
              itemBuilder: (context, index) {
                final item = _navItems[index];

                return ListTile(
                  leading: Icon(item.icon, fill: 1),
                  title: Text(item.label),
                  onTap: () => context.go(item.route),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String label;
  final String route;

  NavigationItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}
