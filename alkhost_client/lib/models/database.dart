class Database {
  final String name;
  final List<String> tables;

  Database({required this.name, required this.tables});

  factory Database.fromJson(Map<String, dynamic> json) {
    return Database(
      name: json['name'] ?? '',
      tables: (json['tables'] as List<String>?)?.toList() ?? [],
    );
  }
}
