class NetworkResponse{
  final bool successful;
  final Map<String, dynamic>? body;
  NetworkResponse({
    required this.successful,
    this.body,
  });
}
