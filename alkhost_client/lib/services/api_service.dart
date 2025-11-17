import 'dart:convert';
import 'package:alkhost_client/models/database.dart';
import 'package:http/http.dart' as http;
import '../models/docker_service.dart';
import '../models/project.dart';
import '../utils/constants.dart';

class ApiService {
  final String baseUrl = AppConstants.apiUrl;

  /*
    servicios
  */

  Future<List<DockerService>> getServices() async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/docker/services'));

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final services = (data['services'] as List)
            .map((json) => DockerService.fromJson(json))
            .toList();
        return services;
      } else {
        throw Exception('Error ${res.statusCode}: ${res.body}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<bool> startService(String serviceId) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/docker/services/$serviceId/start'),
      );
      return res.statusCode == 200;
    } catch (e) {
      print('Error iniciando servicio: $e');
      return false;
    }
  }

  Future<bool> stopService(String serviceId) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/docker/services/$serviceId/stop'),
      );
      return res.statusCode == 200;
    } catch (e) {
      print('Error deteniendo servicio: $e');
      return false;
    }
  }

  Future<bool> restartService(String serviceId) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/docker/services/$serviceId/restart'),
      );
      return res.statusCode == 200;
    } catch (e) {
      print('Error reiniciando servicio: $e');
      return false;
    }
  }

  Future<String> getServiceLogs(String serviceId, {int tail = 100}) async {
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/docker/services/$serviceId/logs?tail=$tail'),
      );

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        return data['logs'] ?? '';
      } else {
        throw Exception('Error ${res.statusCode}');
      }
    } catch (e) {
      throw Exception('Error obteniendo logs: $e');
    }
  }

  Future<bool> startAllServices() async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/docker/services/start-all'),
      );
      return res.statusCode == 200;
    } catch (e) {
      print('Error iniciando todos: $e');
      return false;
    }
  }

  Future<bool> stopAllServices() async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/docker/services/stop-all'),
      );
      return res.statusCode == 200;
    } catch (e) {
      print('Error deteniendo todos: $e');
      return false;
    }
  }

  /*
    proyectos
  */

  Future<List<Project>> getProjects() async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/projects'));

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final projects = (data['projectsList'] as List)
            .map((json) => Project.fromJson(json))
            .toList();
        return projects;
      } else {
        throw Exception('Error ${res.statusCode}: ${res.body}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  /*
    base de datos
  */

  Future<List<Database>> getDatabases() async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/databases'));
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final List<Database> databases = [];
        for (final jsonItem in (data['databases'] as List)) {
          final dbName = jsonItem['Database'];
          final tables = await getTables(dbName);
          databases.add(Database.fromJson({'name': dbName, 'tables': tables}));
        }
        return databases;
      } else {
        throw Exception('Error ${res.statusCode}: ${res.body}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<List<String>> getTables(String database) async {
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/databases/$database/tables'),
      );
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final tables =
            (data['tables'] as List?)
                ?.map((table) => table.toString())
                .toList() ??
            [];
        return tables;
      } else {
        throw Exception('Error ${res.statusCode}: ${res.body}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
