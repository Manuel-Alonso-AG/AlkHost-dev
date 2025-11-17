import 'package:flutter/cupertino.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class Project {
  final String name;
  final String type;
  final String lastModified;

  Project({required this.name, required this.type, required this.lastModified});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      lastModified: json['lastModified'] ?? '',
    );
  }

  IconData get icon {
    switch (type.toLowerCase()) {
      case 'php':
        return Symbols.php;
      case 'html':
        return Symbols.html;
      default:
        return Symbols.folder;
    }
  }
}
