import 'dart:convert';
import 'package:alkhost_client/models/docker_service.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String urlApi = "http://localhost:3000/api/docker";

  Future<List<DockerService>> getServices() async {
    try {
      final res = await http.get(Uri.parse('$urlApi/services'));

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final services = (data['services'] as List)
            .map((json) => DockerService.fromJson(json))
            .toList();
        return services;
      } else {
        throw Exception('Error obteniendo servicios: ${res.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<bool> startService(String serviceId) async {
    try {
      final res = await http.post(
        Uri.parse('$urlApi/services/$serviceId/start'),
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
        Uri.parse('$urlApi/services/$serviceId/stop'),
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
        Uri.parse('$urlApi/services/$serviceId/restart'),
      );

      return res.statusCode == 200;
    } catch (e) {
      print('Error reiniciando servicio: $e');
      return false;
    }
  }

  //* Implementacion futura para mostar datos internos (Estadisticas, logs)

  Future<String> getServiceLogs(String serviceId, {int tail = 100}) async {
    try {
      final res = await http.get(
        Uri.parse('$urlApi/services/$serviceId/logs?tail=$tail'),
      );

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        return data['logs'];
      } else {
        throw Exception('Error obteniendo logs: ${res.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<bool> startAllServices() async {
    try {
      final res = await http.post(Uri.parse('$urlApi/services/start-all'));

      return res.statusCode == 200;
    } catch (e) {
      print('Error iniciando todos los servicios: $e');
      return false;
    }
  }

  Future<bool> stopAllServices() async {
    try {
      final res = await http.post(Uri.parse('$urlApi/services/stop-all'));

      return res.statusCode == 200;
    } catch (e) {
      print('Error deteniendo todos los servicios: $e');
      return false;
    }
  }
}
