import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CompilerPage extends StatefulWidget {
  const CompilerPage({super.key});

  @override
  State<CompilerPage> createState() => _CompilerPageState();
}

class _CompilerPageState extends State<CompilerPage> {
  final TextEditingController _codeController = TextEditingController();
  String _output = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCode();
  }

  Future<void> _loadSavedCode() async {
    final prefs = await SharedPreferences.getInstance();
    _codeController.text = prefs.getString('last_cpp_code') ?? _defaultCode;
  }

  Future<void> _saveCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_cpp_code', code);
  }

  Future<void> _runCode() async {
    setState(() {
      _isLoading = true;
      _output = '';
    });

    final code = _codeController.text;
    await _saveCode(code);

    try {
      final response = await http.post(
        Uri.parse('https://emkc.org/api/v2/piston/execute'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "language": "cpp",
          "version": "10.2.0",
          "files": [
            {"name": "main.cpp", "content": code}
          ],
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final stdout = result['run']?['stdout'] ?? '';
        final stderr = result['run']?['stderr'] ?? '';
        final code = result['run']?['code'];

        setState(() {
          _output = '''
📤 Exit Code: $code

${stderr.isNotEmpty ? "❌ Errors:\n$stderr\n" : ""}
✅ Output:\n$stdout
''';
        });
      } else {
        setState(() {
          _output = '❗ Error: ${response.statusCode} - ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _output = '❗ Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  final String _defaultCode = '''
#include <iostream>
using namespace std;

int main() {
    cout << "Hello, CodeMaze!" << endl;
    return 0;
}
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        title: Row(
          children: const [
            Icon(Icons.code, color: Colors.white),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                'C++ Compiler',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ElevatedButton.icon(
              onPressed: _runCode,
              icon: const Icon(Icons.play_arrow),
              label: const Text("Run"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildEditor(),
          const Divider(height: 1),
          _buildOutput(),
        ],
      ),
    );
  }

  Widget _buildEditor() {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _codeController,
              maxLines: null,
              expands: true,
              style: const TextStyle(
                fontFamily: 'Courier',
                fontSize: 15,
                color: Colors.black87,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Write your C++ code here...',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOutput() {
    return Expanded(
      flex: 2,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.deepPurple.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.shade100.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.pinkAccent))
            : SingleChildScrollView(
          child: SelectableText(
            _output.trim(),
            style: const TextStyle(
              fontFamily: 'Courier',
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
