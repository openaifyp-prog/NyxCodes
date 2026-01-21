import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userName = 'Guest User';
  String userEmail = 'No Email';
  String selectedAvatar = '';
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  final List<String> avatarPaths = [
    'assets/avatars/avatar1.jpg',
    'assets/avatars/avatar2.jpg',
    'assets/avatars/avatar4.jpg',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadUserData(); // ✅ Called every time this screen appears again
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final email = user.email ?? '';
    userEmail = email;
    final emailKey = email.replaceAll('.', ',');

    // Firebase: Load only username
    final usernameSnap = await _dbRef.child('users/$emailKey/username').get();
    if (usernameSnap.exists) userName = usernameSnap.value.toString();

    // ✅ Load avatar from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    selectedAvatar = prefs.getString('selectedAvatar') ?? '';

    setState(() {});
  }

  Future<void> _saveAvatarLocally(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedAvatar', path);
    setState(() {
      selectedAvatar = path;
    });
    Navigator.pop(context); // ✅ Close the avatar dialog
  }

  void _showAvatarPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Choose Avatar"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: avatarPaths.map((path) {
              return GestureDetector(
                onTap: () => _saveAvatarLocally(path),
                child: CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage(path),
                  backgroundColor: Colors.grey.shade200,
                ),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTile(BuildContext context, IconData icon, String title, String routeName) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => Navigator.pushNamed(context, routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: _showAvatarPopup,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.deepPurple.shade100,
                  backgroundImage: selectedAvatar.isNotEmpty ? AssetImage(selectedAvatar) : null,
                  child: selectedAvatar.isEmpty
                      ? Text(
                    userName.isNotEmpty ? userName[0].toUpperCase() : 'G',
                    style: const TextStyle(fontSize: 40, color: Colors.deepPurple),
                  )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Column(
                children: [
                  Text(userName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(userEmail, style: const TextStyle(color: Colors.black54)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildTile(context, Icons.bar_chart, 'View Progress', '/progress'),
            _buildTile(context, Icons.settings, 'App Settings', '/settings'),
            _buildTile(context, Icons.logout, 'Logout', '/login'),
          ],
        ),
      ),
    );
  }
}
