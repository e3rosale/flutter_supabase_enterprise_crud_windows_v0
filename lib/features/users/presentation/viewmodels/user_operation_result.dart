enum UserOperationFailureType { mutationFailed, reloadFailed }

class UserOperationResult {
  final bool isSuccess;
  final UserOperationFailureType? failureType;
  final String? message;

  const UserOperationResult._({
    required this.isSuccess,
    this.failureType,
    this.message,
  });

  factory UserOperationResult.success() {
    return UserOperationResult._(isSuccess: true);
  }

  factory UserOperationResult.mutationFailed(String? message) {
    return UserOperationResult._(
      isSuccess: false,
      failureType: UserOperationFailureType.mutationFailed,
      message: message,
    );
  }

  factory UserOperationResult.reloadFailed(String? message) {
    return UserOperationResult._(
      isSuccess: false,
      failureType: UserOperationFailureType.reloadFailed,
      message: message,
    );
  }
}
