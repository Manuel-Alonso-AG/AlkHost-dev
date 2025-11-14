import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/docker_service.dart';
import '../utils/constants.dart';

class ApiService {
  final String baseUrl = AppConstants.apiUrl;

  Future<List<DockerService>> getServices() async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/services'));

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
        Uri.parse('$baseUrl/services/$serviceId/start'),
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
        Uri.parse('$baseUrl/services/$serviceId/stop'),
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
        Uri.parse('$baseUrl/services/$serviceId/restart'),
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
        Uri.parse('$baseUrl/services/$serviceId/logs?tail=$tail'),
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
      final res = await http.post(Uri.parse('$baseUrl/services/start-all'));
      return res.statusCode == 200;
    } catch (e) {
      print('Error iniciando todos: $e');
      return false;
    }
  }

  Future<bool> stopAllServices() async {
    try {
      final res = await http.post(Uri.parse('$baseUrl/services/stop-all'));
      return res.statusCode == 200;
    } catch (e) {
      print('Error deteniendo todos: $e');
      return false;
    }
  }
}
