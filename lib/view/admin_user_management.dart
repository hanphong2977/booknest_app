import 'package:booknest_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:booknest_app/provider/user_provider.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({Key? key}) : super(key: key);

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  void _addUser() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final userName = _userNameController.text.trim();
    final password = _passwordController.text.trim();
    final address = _addressController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        userName.isEmpty ||
        password.isEmpty ||
        address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields.')),
      );
      return;
    }

    final user = User(
      id: DateTime.now().millisecondsSinceEpoch, // Generate unique ID
      name: name,
      email: email,
      phone: phone,
      userName: userName,
      password: password,
      address: address,
      tsCreated: DateTime.now(),
      tsUpdated: DateTime.now(),
    );

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final success = await userProvider.addUser(user);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$name has been added successfully.')),
      );
      _clearForm();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add user. Please try again.')),
      );
    }
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _userNameController.clear();
    _passwordController.clear();
    _addressController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            _buildTextField(_nameController, 'Enter name', Icons.person),
            _buildTextField(_emailController, 'Enter email', Icons.email),
            _buildTextField(_phoneController, 'Enter phone', Icons.phone),
            _buildTextField(_userNameController, 'Enter username', Icons.person_outline),
            _buildTextField(_passwordController, 'Enter password', Icons.lock, obscureText: true),
            _buildTextField(_addressController, 'Enter address', Icons.home),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addUser,
              child: const Text('Add User'),
            ),
            const SizedBox(height: 24),
            const Text(
              'User List:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                final users = userProvider.users;
                return users.isEmpty
                    ? const Center(
                  child: Text(
                    'No users available.',
                    style: TextStyle(fontSize: 16),
                  ),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      title: Text(user.name),
                      subtitle: Text('${user.email} • ${user.phone}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          final success = await userProvider.removeUser(user);
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${user.name} has been removed.')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Failed to remove user.')),
                            );
                          }
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, IconData icon,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hint,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        obscureText: obscureText,
      ),
    );
  }
}
