import 'package:supabase_flutter/supabase_flutter.dart';

import '../features/users/data/datasources/user_remote_datasource.dart';
import '../features/users/data/repositories/user_repository_impl.dart';
import '../features/users/domain/usecases/create_user.dart';
import '../features/users/domain/usecases/delete_user.dart';
import '../features/users/domain/usecases/get_users.dart';
import '../features/users/domain/usecases/update_user.dart';
import '../features/users/presentation/viewmodels/users_viewmodel.dart';

class AppDependencies {
  final SupabaseClient supabaseClient;

  const AppDependencies({required this.supabaseClient});

  UsersViewModel createUsersViewModel() {
    final dataSource = UserRemoteDataSource(supabaseClient);
    final repository = UserRepositoryImpl(dataSource);

    return UsersViewModel(
      getUsersUseCase: GetUsers(repository),
      createUserUseCase: CreateUser(repository),
      updateUserUseCase: UpdateUser(repository),
      deleteUserUseCase: DeleteUser(repository),
    );
  }
}
