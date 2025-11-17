import 'dart:io';

import 'package:url_launcher/url_launcher.dart';
import 'package:alkhost_client/providers/projects_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  void _loadData() {
    final provider = context.read<ProjectsProvider>();
    provider.loadProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectsProvider>(
      builder: (BuildContext context, projectsProvider, Widget? child) {
        if (projectsProvider.isLoading && projectsProvider.projects.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        if (projectsProvider.error != null) {
          return Text(projectsProvider.error!);
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
                  spacing: 8,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Proyectos'),
                        IconButton(
                          onPressed: _loadData,
                          icon: Icon(Icons.refresh),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        onPressed: () async {
                          final urlProject = 'http://localhost:3000/dashboard/';

                          final Uri url = Uri.parse(urlProject);

                          if (!await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          )) {
                            throw Exception('No se pudo abrir el enlace');
                          }
                        },
                        child: Text('Ver dashboard'),
                      ),
                    ),
                    SearchBar(
                      leading: Icon(Icons.search),
                      hintText: 'Buscar proyecto',
                      constraints: BoxConstraints(minHeight: 45),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: projectsProvider.projects.length,
                itemBuilder: (context, index) {
                  final project = projectsProvider.projects[index];
                  return ListTile(
                    leading: Icon(project.icon),
                    trailing: ElevatedButton(
                      onPressed: () async {
                        final urlProject =
                            'http://localhost:3000/${project.name}/';

                        final Uri url = Uri.parse(urlProject);

                        if (!await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        )) {
                          throw Exception('No se pudo abrir el enlace');
                        }
                      },
                      child: Text('Ver en la web'),
                    ),
                    title: Text(project.name),
                    subtitle: Text(project.lastModified),
                    onTap: () async {
                      final routeFile =
                          'C:\\Users\\%USERNAME%\\Alkhost\\www\\${project.name}';
                      await Process.run('explorer', [routeFile]);
                    },
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
