enum FailureType { validation, unauthorized, network, data, unknown }

class Failure {
  final FailureType type;
  final String message;
  final Object? cause;

  const Failure({required this.type, required this.message, this.cause});
}
