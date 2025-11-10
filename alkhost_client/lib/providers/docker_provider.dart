import 'package:alkhost_client/models/docker_service.dart';
import 'package:alkhost_client/services/api_service.dart';
import 'package:flutter/material.dart';

class DockerProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<DockerService> _services = [];
  bool _isLoading = false;
  String? _error;

  List<DockerService> get services => _services;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadServices() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _services = await _apiService.getServices();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> startService(String serviceId) async {
    final success = await _apiService.startService(serviceId);

    if (success) await loadServices();

    return success;
  }

  Future<bool> stopService(String serviceId) async {
    final success = await _apiService.stopService(serviceId);

    if (success) await loadServices();

    return success;
  }

  Future<bool> restartService(String serviceId) async {
    final success = await _apiService.restartService(serviceId);

    if (success) await loadServices();

    return success;
  }

  Future<bool> startAll() async {
    final success = await _apiService.startAllServices();
    if (success) {
      await Future.delayed(Duration(seconds: 2));
      await loadServices();
    }
    return success;
  }

  Future<bool> stopAll() async {
    final success = await _apiService.stopAllServices();
    if (success) {
      await Future.delayed(Duration(seconds: 2));
      await loadServices();
    }
    return success;
  }
}
