import '../../domain/entities/user_entity.dart';

class UsersState {
  final List<UserEntity> users;
  final bool isLoading;
  final String? errorMessage;

  const UsersState({
    this.users = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  UsersState copyWith({
    List<UserEntity>? users,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    final nextErrorMessage = clearError
        ? null
        : errorMessage ?? this.errorMessage;

    return UsersState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: nextErrorMessage,
    );
  }
}
