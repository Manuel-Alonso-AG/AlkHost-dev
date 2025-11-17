import 'package:alkhost_client/models/database.dart';
import 'package:alkhost_client/services/api_service.dart';
import 'package:flutter/material.dart';

class DatabaseProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Database> _databases = [];
  bool _isLoading = false;
  String? _error;

  List<Database> get databases => _databases;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadDatabases() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _databases = await _apiService.getDatabases();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
