import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class SyntaxSpeedRunPage extends StatefulWidget {
  const SyntaxSpeedRunPage({Key? key}) : super(key: key);

  @override
  _SyntaxSpeedRunPageState createState() => _SyntaxSpeedRunPageState();
}

class _SyntaxSpeedRunPageState extends State<SyntaxSpeedRunPage> {
  final List<String> _phrases = [
    'int main() {',
    'std::cout << "Hello World";',
    'for(int i=0; i<10; i++) {',
    'return 0;',
    '}',
    'int a = 10;',
    'float b = 5.6;',
    'char c = \'A\';',
    'bool isReady = true;',
    'std::cin >> a;',
    'std::getline(std::cin, name);',
    'int sum = a + b;',
    'if(a > b) {',
    'else if(a == b) {',
    'else {',
    'while(i < 10) {',
    'do {',
    '} while(i < 5);',
    'int arr[5] = {1, 2, 3, 4, 5};',
    'for(auto x : arr) {',
    '#include <iostream>',
    '#include <string>',
    '#include <vector>',
    '#include <cmath>',
    'std::vector<int> v;',
    'v.push_back(10);',
    'v.pop_back();',
    'v.size();',
    'std::string str = "Hello";',
    'str.length();',
    'str += " World";',
    'return true;',
    'const double PI = 3.14;',
    'int* ptr = &a;',
    '*ptr = 20;',
    'std::cout << *ptr;',
    'int& ref = a;',
    'void greet() {',
    'int add(int x, int y) {',
    'return x + y;',
    '}',
    'class MyClass {',
    'public:',
    'void print() {',
    'std::cout << "Hello";',
    '}',
    'private:',
    'int data;',
    'MyClass obj;',
    'obj.print();',
    'try {',
    '} catch(std::exception& e) {',
    'std::cerr << e.what();',
    '}',
    'int x = 0;',
    'double radius = 7.5;',
    'std::string name = "John";',
    'name[0] = \'J\';',
    'std::cout << name;',
    'std::cout << name.length();',
    'std::cout << name.substr(0, 2);',
    'std::cout << name.find("o");',
    'std::vector<int> nums = {1, 2, 3};',
    'nums.at(1) = 5;',
    'nums.clear();',
    'nums.empty();',
    'std::map<std::string, int> ages;',
    'ages["Ali"] = 25;',
    'ages.count("Ali");',
    'ages.size();',
    'std::pair<int, int> p = {1, 2};',
    'std::cout << p.first;',
    'std::cout << p.second;',
    'std::set<int> s;',
    's.insert(10);',
    's.erase(10);',
    's.find(10);',
    's.size();',
    'std::stack<int> st;',
    'st.push(5);',
    'st.pop();',
    'st.top();',
    'st.empty();',
    'std::queue<int> q;',
    'q.push(1);',
    'q.front();',
    'q.pop();',
    'q.back();',
    '#define MAX 100',
    'typedef unsigned int uint;',
    'enum Color { RED, GREEN, BLUE };',
    'Color c = RED;',
    'const int LIMIT = 1000;',
    'switch(choice) {',
    'case 1:',
    'break;',
    'default:',
    'int* p = new int;',
    'delete p;',
    'new int[5];',
    'delete[] arr;',
    'auto result = sum(5, 10);',
    'template<typename T>',
    'T max(T a, T b) {',
    'return (a > b) ? a : b;',
    '}',
    'std::sort(arr, arr + n);',
    'std::reverse(v.begin(), v.end());',
    'std::min(10, 20);',
    'std::max(5, 15);',
    'std::abs(-10);',
    'std::pow(2, 3);',
    'std::sqrt(25);',
    'std::log(10);',
    'std::exp(1);',
    'std::sin(0);',
    'std::cos(0);',
    'std::tan(0);',
    'std::to_string(42);',
    'std::stoi("123");',
    'std::stof("3.14");',
    'std::isalpha(\'a\');',
    'std::isdigit(\'9\');',
    'std::isupper(\'A\');',
    'std::islower(\'b\');',
    'std::toupper(\'a\');',
    'std::tolower(\'Z\');',
    'std::cin.ignore();',
    'std::cin.clear();',
    'std::cin.fail();',
    'std::getline(std::cin, input);',
    'std::ofstream fout("file.txt");',
    'fout << "data";',
    'fout.close();',
    'std::ifstream fin("file.txt");',
    'std::string line;',
    'std::getline(fin, line);',
    'fin.close();',
    'std::fstream file;',
    'file.open("data.txt");',
    'file.is_open();',
    'file.close();',
    'std::time_t now = std::time(0);',
    'std::tm* ltm = std::localtime(&now);',
    'std::cout << 1900 + ltm->tm_year;',
    'std::this_thread::sleep_for(std::chrono::seconds(1));',
    '#include <thread>',
    '#include <chrono>',
    'std::exception e;',
    'throw std::runtime_error("error");',
    'catch(const std::exception& e) {',
    'std::cerr << e.what();',
    '}',
    'assert(x > 0);',
    '#include <cassert>',
    '#include <cstdlib>',
    'std::rand();',
    'std::srand(time(0));',
    'std::vector<int>::iterator it;',
    'for(it = v.begin(); it != v.end(); ++it) {',
    'std::advance(it, 2);',
    'std::distance(v.begin(), it);',
    'std::list<int> lst;',
    'lst.push_back(10);',
    'lst.push_front(5);',
    'lst.pop_back();',
    'lst.pop_front();',
    'lst.sort();',
    'lst.reverse();',
    'lst.remove(3);',
    'std::priority_queue<int> pq;',
    'pq.push(20);',
    'pq.top();',
    'pq.pop();',
    'pq.empty();',
    'std::deque<int> dq;',
    'dq.push_back(3);',
    'dq.push_front(1);',
    'dq.back();',
    'dq.front();',
    'dq.pop_back();',
    'dq.pop_front();',
    'std::multiset<int> ms;',
    'ms.insert(5);',
    'ms.count(5);',
    'ms.erase(ms.find(5));',
    'std::unordered_map<int, std::string> um;',
    'um[1] = "One";',
    'um.find(2);',
    'um.size();',
    'um.empty();',
    'std::unordered_set<int> us;',
    'us.insert(4);',
    'us.erase(4);',
    'std::bitset<8> bits("10101010");',
    'bits.flip();',
    'bits.count();',
    'bits.test(2);',
    'std::array<int, 5> arr = {1, 2, 3, 4, 5};',
    'arr.fill(0);',
    'arr.size();',
    'std::make_pair(3, "three");',
    'std::swap(a, b);',
    'std::endl;',
    'std::fixed;',
    'std::setprecision(2);',
    'std::boolalpha;',
    'std::noboolalpha;',
    'std::hex;',
    'std::oct;',
    'std::dec;',
    'std::setw(10);',
    'std::left;',
    'std::right;',
    'std::internal;',
    'std::showpos;',
    'std::noshowpos;',
    'std::setfill(\'*\');',
    'std::flush;',
    'std::showpoint;',
    'std::noshowpoint;',
    'std::scientific;',
    'std::defaultfloat;',
    '#pragma once',
    '#ifndef HEADER_H',
    '#define HEADER_H',
    '#endif',
    'namespace Math {',
    'int square(int x) { return x * x; }',
    '}',
    'using namespace Math;',
    'int result = Math::square(5);',
    '#error "Compilation stopped!"',
    '#ifdef DEBUG',
    '#endif',
    'std::move(v);',
    'std::forward<T>(val);',
    'std::function<void()> fn;',
    'fn = []() { std::cout << "Hello"; };',
    'fn();',
    'std::bind(add, 1, 2);',
    '#include <functional>',
    '#include <utility>',
    '#include <bitset>',
    'std::accumulate(v.begin(), v.end(), 0);',
    'std::count(v.begin(), v.end(), 10);',
    'std::find(v.begin(), v.end(), 3);',
    'std::any_of(v.begin(), v.end(), pred);',
    'std::all_of(v.begin(), v.end(), pred);',
    'std::none_of(v.begin(), v.end(), pred);',
    'std::generate(v.begin(), v.end(), rand);',
    'std::remove(v.begin(), v.end(), 5);',
    'std::unique(v.begin(), v.end());',
    'std::lower_bound(v.begin(), v.end(), val);',
    'std::upper_bound(v.begin(), v.end(), val);',
    'std::equal(v1.begin(), v1.end(), v2.begin());',
    'std::merge(v1.begin(), v1.end(), v2.begin(), v2.end(), result.begin());',
    'std::inplace_merge(v.begin(), mid, v.end());',
    'std::is_sorted(v.begin(), v.end());',
    'std::sort_heap(v.begin(), v.end());',
    'std::make_heap(v.begin(), v.end());',
    'std::push_heap(v.begin(), v.end());',
    'std::pop_heap(v.begin(), v.end());',
    'std::nth_element(v.begin(), v.begin() + 3, v.end());',
    'std::max_element(v.begin(), v.end());',
    'std::min_element(v.begin(), v.end());',
    'std::reverse_copy(v.begin(), v.end(), back_inserter(result));',
    'std::copy(v.begin(), v.end(), back_inserter(result));',
    'std::fill(v.begin(), v.end(), 0);',
    'std::replace(v.begin(), v.end(), 1, 0);',
    'std::partition(v.begin(), v.end(), pred);',
    'std::stable_partition(v.begin(), v.end(), pred);',
    'std::distance(v.begin(), v.end());',
    'std::next(it, 2);',
    'std::prev(it, 1);',
    'std::iterator_traits<std::vector<int>::iterator>::value_type;',
    'std::enable_if<true, int>::type;',
    'std::is_same<int, float>::value;',
    'std::is_integral<int>::value;',
    'std::is_floating_point<double>::value;',
    'std::is_class<std::string>::value;',
    'std::is_pointer<int*>::value;',
    'std::is_const<const int>::value;',
    'std::remove_const<const int>::type;',
    'std::add_pointer<int>::type;',
    'std::declval<T>();',
    'std::tuple<int, double, char> t;',
    'std::get<0>(t);',
    'std::tie(a, b) = std::make_pair(1, 2);',
    'std::ignore;',
    'std::variant<int, std::string> v;',
    'std::visit(visitor, v);',
    'std::optional<int> o;',
    'o.value_or(0);',
    'std::monostate;',
    'std::any a = 5;',
    'std::any_cast<int>(a);',

    // Paste your 300+ syntax phrases here...
    'int main() {',
    'std::cout << "Hello World";',
    'return 0;',
    '}',
  ];

  late String _currentPhrase;
  late TextEditingController _controller;
  int _score = 0;
  int _timeLeft = 60;
  Timer? _timer;
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _newPhrase();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft <= 0) {
        setState(() {
          _gameOver = true;
          _timer?.cancel();
        });
        _showNotification();
      } else {
        setState(() {
          _timeLeft--;
        });
      }
    });
  }

  void _newPhrase() {
    final random = DateTime.now().millisecondsSinceEpoch;
    setState(() {
      _currentPhrase = _phrases[random % _phrases.length];
      _controller.clear();
    });
  }

  void _submit() {
    if (_controller.text.trim() == _currentPhrase) {
      setState(() {
        _score++;
      });
      _newPhrase();
    }
  }

  void _showNotification() async {
    await flutterLocalNotificationsPlugin.show(
      0,
      '⏱️ Syntax Run Complete!',
      'You scored $_score points in Syntax Speed Run!',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'code_maze_channel',
          'CodeMaze Alerts',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = _timeLeft / 60;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syntax Speed Run'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _gameOver
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Time\'s up! Your score: $_score',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _score = 0;
                    _timeLeft = 60;
                    _gameOver = false;
                    _newPhrase();
                    _startTimer();
                  });
                },
                child: const Text('Play Again'),
              ),
            ],
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: Colors.purple.shade100,
              valueColor: const AlwaysStoppedAnimation<Color>(
                  Colors.purple),
            ),
            const SizedBox(height: 12),
            Text('Time Left: $_timeLeft s',
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text('Type this code:',
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(_currentPhrase,
                  style: const TextStyle(
                      fontFamily: 'Courier', fontSize: 18)),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Type here',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Submit'),
            ),
            const Spacer(),
            Text('Score: $_score',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
