import 'dart:ui';
import '../models/docker_service.dart';

class AppConstants {
  static const String apiUrl = 'http://localhost:3000/api';

  static const primaryColor = Color(0xFF2196F3);
  static const successColor = Color(0xFF4CAF50);
  static const errorColor = Color(0xFFF44336);
  static const warningColor = Color(0xFFFF9800);

  static const Duration refreshInterval = Duration(seconds: 5);
}

enum ServiceState { running, stopped, starting, stopping, error }
