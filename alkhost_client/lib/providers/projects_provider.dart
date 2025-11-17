import 'package:flutter/material.dart';

import '../models/project.dart';
import '../services/api_service.dart';

class ProjectsProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Project> _projects = [];
  bool _isLoading = false;
  String? _error;

  List<Project> get projects => _projects;
  bool get isLoading => _isLoading;
  String? get error => _error;

  int get projectsCount => _projects.length;

  Future<void> loadProjects() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _projects = await _apiService.getProjects();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
