class DockerService {
  final String id;
  final String name;
  final String image;
  final String state;
  final String status;
  final int port;

  DockerService({
    required this.id,
    required this.name,
    required this.image,
    required this.state,
    required this.status,
    required this.port,
  });

  factory DockerService.fromJson(Map<String, dynamic> json) {
    return DockerService(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      state: json['state'] ?? '',
      status: json['status'] ?? '',
      port: json['port'] ?? 0,
    );
  }

  bool get isRunning => state.toLowerCase() == 'running';

  bool get isStopped =>
      state.toLowerCase() == 'exited' || state.toLowerCase() == 'created';
}
