import '../models/docker_service.dart';
import '../services/api_service.dart';
import 'package:flutter/foundation.dart';

class ServicesProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<DockerService> _services = [];
  bool _isLoading = false;
  String? _error;

  List<DockerService> get services => _services;
  bool get isLoading => _isLoading;
  String? get error => _error;

  int get runningCount =>
      _services.where((service) => service.isRunning).length;
  int get stoppedCount =>
      _services.where((service) => service.isStopped).length;
  int get totalCount => _services.length;

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

  Future<void> startService(String serviceId) async {
    try {
      final success = await _apiService.startService(serviceId);

      if (success) {
        await Future.delayed(Duration(seconds: 2));
        await loadServices();
        return;
      }

      _error = 'No de pudo iniciar el servicio';
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> stopService(String serviceId) async {
    try {
      final success = await _apiService.stopService(serviceId);

      if (success) {
        await Future.delayed(Duration(seconds: 2));
        await loadServices();
        return;
      }
      _error = 'No se pudo detener el servicio';
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
