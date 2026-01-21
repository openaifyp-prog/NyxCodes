import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppDrawer extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const AppDrawer({
    Key? key,
    required this.isDarkMode,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool _showExtraProfileOptions = false;
  bool _showSettings = true;
  bool _showCommunity = false;
  bool _showLegal = false;

  String _selectedLanguage = 'English';

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileSection(),
              const Divider(),
              _buildSection(
                title: 'Navigation',
                initiallyExpanded: true,
                child: _buildNavigationSection(context),
                onExpansionChanged: (_) {},
              ),
              const Divider(),
              _buildDrawerItem(
                context,
                icon: Icons.videogame_asset,
                label: 'Game Mode',
                route: '/game_mode',
              ),
              const Divider(),
              _buildSection(
                title: 'Settings',
                initiallyExpanded: _showSettings,
                child: _buildSettingsSection(context),
                onExpansionChanged: (expanded) {
                  setState(() => _showSettings = expanded);
                },
              ),
              const Divider(),
              _buildSection(
                title: 'Community',
                initiallyExpanded: _showCommunity,
                child: _buildCommunityLinksSection(context),
                onExpansionChanged: (expanded) {
                  setState(() => _showCommunity = expanded);
                },
              ),
              const Divider(),
              _buildSection(
                title: 'Legal',
                initiallyExpanded: _showLegal,
                child: _buildLegalSection(context),
                onExpansionChanged: (expanded) {
                  setState(() => _showLegal = expanded);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Logout'),
                onTap: () => _logout(context),
              ),
              const SizedBox(height: 16),
              _buildFooterSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: Colors.deepPurple.shade700),
      accountName: const Text('John Doe'),
      accountEmail: const Text('john.doe@example.com'),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: const Icon(Icons.person, color: Colors.deepPurple, size: 40),
      ),
      otherAccountsPictures: [
        IconButton(
          icon: Icon(
            _showExtraProfileOptions ? Icons.expand_less : Icons.expand_more,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _showExtraProfileOptions = !_showExtraProfileOptions;
            });
          },
        )
      ],
      margin: const EdgeInsets.only(bottom: 0),
    );
  }

  Widget _buildNavigationSection(BuildContext context) {
    return Column(
      children: [
        _buildDrawerItem(
          context,
          icon: Icons.home,
          label: 'Home',
          route: '/home',
        ),
        _buildDrawerItem(
          context,
          icon: Icons.school,
          label: 'Lessons',
          route: '/lessons',
        ),
        _buildDrawerItem(
          context,
          icon: Icons.extension,
          label: 'Puzzles',
          route: '/puzzles',
        ),
        _buildDrawerItem(
          context,
          icon: Icons.person,
          label: 'Profile',
          route: '/profile',
        ),
        _buildDrawerItem(
          context,
          icon: Icons.code,
          label: 'C++ Compiler',
          route: '/compiler',
        ),
        _buildDrawerItem(
          context,
          icon: Icons.chat,
          label: 'AI Chat',
          route: '/ai_chat',
        ),
      ],
    );
  }

  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon, required String label, required String route}) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(label),
      onTap: () {
        Navigator.pop(context); // Close drawer first
        Navigator.pushNamedAndRemoveUntil(context, route, (route) => route.isFirst);
      },
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: widget.isDarkMode,
            onChanged: (bool value) {
              widget.onThemeChanged(value);
              setState(() {});
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              items: <String>['English', 'Urdu', 'Chinese', 'Spanish', 'French']
                  .map<DropdownMenuItem<String>>((String val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              }).toList(),
              onChanged: (String? newVal) {
                if (newVal != null) {
                  setState(() {
                    _selectedLanguage = newVal;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Language set to $newVal')),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityLinksSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.forum),
            title: const Text('Community Forum'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Community Forum link coming soon!')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.facebook),
            title: const Text('Facebook Group'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Facebook Group link coming soon!')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLegalSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Privacy Policy coming soon!')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.rule),
            title: const Text('Terms & Conditions'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Terms & Conditions coming soon!')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFooterSection() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          'CodeMaze © 2025\nLearn C++ the Smart Way',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black54, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget child,
    required bool initiallyExpanded,
    required ValueChanged<bool> onExpansionChanged,
  }) {
    return ExpansionTile(
      title: Text(title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          )),
      initiallyExpanded: initiallyExpanded,
      onExpansionChanged: onExpansionChanged,
      children: [child],
    );
  }
}
