import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../providers/font_provider.dart';
import '../providers/sound_provider.dart';
import '../services/notification_service.dart';
import 'home.dart'; // Make sure HomePage class is here

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool dailyReminder = true;
  String fontSize = "Medium";

  final List<String> fontOptions = ["Small", "Medium", "Large"];

  void _showFontSizeDialog() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select Font Size'),
        children: fontOptions.map((size) {
          return SimpleDialogOption(
            child: Text(size),
            onPressed: () {
              setState(() => fontSize = size);
              Provider.of<FontProvider>(context, listen: false).setFontSize(size);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Font size set to $size")));
            },
          );
        }).toList(),
      ),
    );
  }

  void _showPrivacyPolicyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Privacy Policy"),
        content: const SingleChildScrollView(
          child: Text(
            '''
We collect basic user info to personalize your learning experience. Your data is securely stored and never sold. We use SharedPreferences and Firebase for settings, progress, and authentication. Notifications are optional and can be disabled anytime.
            ''',
            style: TextStyle(fontSize: 14),
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Close"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Terms & Conditions"),
        content: const SingleChildScrollView(
          child: Text(
            '''
By using CodeMaze, you agree not to misuse the app and respect intellectual property. Your progress and profile are used only within the app to enhance your experience. Violations may result in account suspension.
            ''',
            style: TextStyle(fontSize: 14),
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Close"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final fontProvider = Provider.of<FontProvider>(context);
    final soundProvider = Provider.of<SoundProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomePage()));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('App Settings'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const HomePage())),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          children: [
            _sectionTitle('Appearance'),
            SwitchListTile(
              secondary: const Icon(Icons.dark_mode),
              title: const Text('Dark Mode'),
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleDarkMode(value);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(value
                        ? 'Dark mode enabled'
                        : 'Light mode enabled')));
              },
            ),
            ListTile(
              leading: const Icon(Icons.format_size),
              title: const Text('Font Size'),
              subtitle: Text(fontProvider.fontSize),
              onTap: _showFontSizeDialog,
            ),
            const Divider(),

            _sectionTitle('Notifications'),
            SwitchListTile(
              secondary: const Icon(Icons.notifications_active),
              title: const Text('Daily Challenge Reminder'),
              value: dailyReminder,
              onChanged: (value) {
                setState(() => dailyReminder = value);
                if (value) {
                  NotificationService.scheduleDailyReminder();
                } else {
                  NotificationService.cancelDailyReminder();
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.notification_add),
              title: const Text('Send Test Notification'),
              onTap: () => NotificationService.sendTestNotification(),
            ),
            const Divider(),

            _sectionTitle('Legal'),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text('Privacy Policy'),
              onTap: _showPrivacyPolicyDialog,
            ),
            ListTile(
              leading: const Icon(Icons.rule),
              title: const Text('Terms & Conditions'),
              onTap: _showTermsDialog,
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
      child: Text(title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
