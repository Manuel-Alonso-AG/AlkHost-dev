class DockerService {
  final String id;
  final String name;
  final String image;
  final String state;
  final String status;
  final String ports;

  DockerService({
    required this.id,
    required this.name,
    required this.image,
    required this.state,
    required this.status,
    required this.ports,
  });

  factory DockerService.fromJson(Map<String, dynamic> json) {
    return DockerService(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      state: json['state'],
      status: json['status'],
      ports: json['ports'],
    );
  }

  bool get isRunning => state == 'running';
  bool get isStopped => state == 'exited' || state == 'created';
}
