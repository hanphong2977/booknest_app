import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProvider with ChangeNotifier {
  final List<String> _users = ['User1', 'User2', 'User3'];

  List<String> get users => _users;

  void addUser(String user) {
    _users.add(user);
    notifyListeners();
  }

  void removeUser(String user) {
    _users.remove(user);
    notifyListeners();
  }
}

class UserManagement extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quản lý user')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Thêm User',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  Provider.of<UserProvider>(context, listen: false)
                      .addUser(_controller.text);
                  _controller.clear();
                }
              },
              child: Text('Add User'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  return ListView.builder(
                    itemCount: userProvider.users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(userProvider.users[index]),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            userProvider.removeUser(userProvider.users[index]);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
