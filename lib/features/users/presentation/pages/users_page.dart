import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// import '../../data/datasources/user_remote_datasource.dart';
// import '../../data/repositories/user_repository_impl.dart';
// import '../../domain/entities/user_entity.dart';
// import '../../domain/usecases/create_user.dart';
// import '../../domain/usecases/delete_user.dart';
// import '../../domain/usecases/get_users.dart';
// import '../../domain/usecases/update_user.dart';
// import '../viewmodels/users_viewmodel.dart';
// import '../widgets/user_form_dialog.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late final UsersViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    final client = Supabase.instance.client;
    final dataSource = UserRemoteDataSource(client);
    final repository = UserRepositoryImpl(dataSource);

    _viewModel = UsersViewModel(
      getUsersUseCase: GetUsers(repository),
      createUserUseCase: CreateUser(repository),
      updateUserUseCase: UpdateUser(repository),
      deleteUserUseCase: DeleteUser(repository),
    );

    _viewModel.addListener(_onViewModelChanged);
    _viewModel.loadUsers();
  }

  void _onViewModelChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    _viewModel.dispose();
    super.dispose();
  }

  Future<void> _openCreateDialog() async {
    await showDialog<void>(
      context: context,
      builder: (_) => UserFormDialog(
        title: 'Create User',
        initialName: '',
        initialEmail: '',
        submitLabel: 'Create',
        onSubmit: (name, email) async {
          await _viewModel.createUser(name: name, email: email);
        },
      ),
    );
  }

  Future<void> _openEditDialog(UserEntity user) async {
    await showDialog<void>(
      context: context,
      builder: (_) => UserFormDialog(
        title: 'Edit User',
        initialName: user.name,
        initialEmail: user.email,
        submitLabel: 'Save',
        onSubmit: (name, email) async {
          await _viewModel.updateUser(id: user.id, name: name, email: email);
        },
      ),
    );
  }

  Future<void> _confirmDelete(UserEntity user) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete User'),
        content: Text('Delete ${user.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _viewModel.deleteUser(user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enterprise Users CRUD'),
        actions: [
          IconButton(
            onPressed: _viewModel.loadUsers,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openCreateDialog,
        icon: const Icon(Icons.add),
        label: const Text('New User'),
      ),
      body: Column(
        children: [
          if (_viewModel.errorMessage != null)
            MaterialBanner(
              content: Text(_viewModel.errorMessage!),
              actions: [
                TextButton(
                  onPressed: _viewModel.loadUsers,
                  child: const Text('Retry'),
                ),
              ],
            ),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_viewModel.isLoading && _viewModel.users.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_viewModel.users.isEmpty) {
      return RefreshIndicator(
        onRefresh: _viewModel.loadUsers,
        child: ListView(
          children: const [
            SizedBox(height: 160),
            Center(child: Text('No users found')),
          ],
        ),
      );
    }

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: _viewModel.loadUsers,
          child: ListView.separated(
            itemCount: _viewModel.users.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final user = _viewModel.users[index];

              return ListTile(
                leading: CircleAvatar(child: Text(user.id.toString())),
                title: Text(user.name),
                subtitle: Text(user.email),
                trailing: Wrap(
                  spacing: 8,
                  children: [
                    IconButton(
                      onPressed: () => _openEditDialog(user),
                      icon: const Icon(Icons.edit_outlined),
                    ),
                    IconButton(
                      onPressed: () => _confirmDelete(user),
                      icon: const Icon(Icons.delete_outlined),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        if (_viewModel.isLoading)
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: LinearProgressIndicator(),
          ),
      ],
    );
  }
}
