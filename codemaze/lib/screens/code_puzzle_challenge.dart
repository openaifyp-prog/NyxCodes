import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CodePuzzleChallenge extends StatefulWidget {
  const CodePuzzleChallenge({Key? key}) : super(key: key);

  @override
  _CodePuzzleChallengeState createState() => _CodePuzzleChallengeState();
}

class _CodePuzzleChallengeState extends State<CodePuzzleChallenge> {
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  final List<Map<String, String>> _allPuzzles = [
    {
      'question':
      'Fill in the blank to print Hello World in C++:\n\n#include <iostream>\nint main() {\n  std::cout << "_____";\n  return 0;\n}',
      'answer': 'Hello World',
      'hint': 'The string inside the quotes is what will be printed.',
    },
    {
      'question': 'What keyword is used to define a constant value in C++?',
      'answer': 'const',
      'hint': 'It starts with "c" and ensures the value cannot be changed.',
    },
    {
      'question': 'How do you start a for loop in C++ that counts from 0 to 9?',
      'answer': 'for(int i=0; i<10; i++)',
      'hint': 'Remember the three parts: initialization, condition, and increment.',
    },
    {
      'question': 'What header file is required for input/output operations in C++?',
      'answer': '<iostream>',
      'hint': 'It starts with an "i" and ends in "stream".',
    },
    {
      'question': 'Fill in the blank: int main() { _____ return 0; }',
      'answer': ' ',
      'hint': 'There can be no code or just comments here.',
    },
    {
      'question': 'What symbol is used to denote a single-line comment in C++?',
      'answer': '//',
      'hint': 'It’s a double forward slash.',
    },
    {
      'question': 'Which operator is used to get the remainder in C++?',
      'answer': '%',
      'hint': 'It looks like the percent sign.',
    },
    {
      'question': 'Fill in the blank to declare a variable with value 42:\n\n_____ num = 42;',
      'answer': 'int',
      'hint': 'It’s the keyword used to declare integers.',
    },
    {
      'question': 'Which keyword is used to create a loop that continues as long as a condition is true?',
      'answer': 'while',
      'hint': 'This loop evaluates the condition before running.',
    },
    {
      'question': 'How do you include the math library in C++?',
      'answer': '#include <cmath>',
      'hint': 'It starts with #include and the name is 5 letters.',
    },
    {
      'question': 'Which keyword is used to define a function in C++?',
      'answer': 'void',
      'hint': 'Used for functions that return nothing.',
    },
    {
      'question': 'What is the output of this code?\n\nint a = 2 * 3 + 1;\nstd::cout << a;',
      'answer': '7',
      'hint': 'Follow order of operations: multiply then add.',
    },
    {
      'question': 'Fill in the blank:\n\nif(x > 10) {\n  std::cout << "High";\n} _____ {\n  std::cout << "Low";\n}',
      'answer': 'else',
      'hint': 'It comes after an if-block.',
    },
    {
      'question': 'How do you read an integer from user input?',
      'answer': 'std::cin >> x;',
      'hint': 'You use std::cin and the >> operator.',
    },
    {
      'question': 'Which keyword prevents a variable from being modified?',
      'answer': 'const',
      'hint': 'It starts with a "c" and is 5 letters.',
    },
    {
      'question': 'How do you print multiple variables in C++?',
      'answer': 'std::cout << a << b;',
      'hint': 'Use << to chain them.',
    },
    {
      'question': 'What does `return 0;` signify in `main()`?',
      'answer': 'successful execution',
      'hint': 'It tells the OS that the program finished correctly.',
    },
    {
      'question': 'Which loop guarantees at least one execution?',
      'answer': 'do-while',
      'hint': 'It checks the condition after the body.',
    },
    {
      'question': 'Fill in the blank:\n\nstd::string name = "John";\nstd::cout << name._____();',
      'answer': 'length',
      'hint': 'Use this to get the number of characters in a string.',
    },
    {
      'question': 'What is the data type for a single character?',
      'answer': 'char',
      'hint': 'It is 4 letters and starts with "c".',
    },
    {
      'question': 'How do you access the third element in array arr?',
      'answer': 'arr[2]',
      'hint': 'Arrays start at index 0.',
    },
    {
      'question': 'Which keyword is used to create a class in C++?',
      'answer': 'class',
      'hint': 'It’s the same word as the concept itself.',
    },
    {
      'question': 'What is the correct syntax for a switch-case block?',
      'answer': 'switch(x) { case 1: break; }',
      'hint': 'Uses switch, case, and break.',
    },
    {
      'question': 'What keyword is used to inherit from another class in C++?',
      'answer': 'public',
      'hint': 'This access specifier is used in inheritance.',
    },
    {
      'question': 'What symbol is used to define a block of code?',
      'answer': '{}',
      'hint': 'They are curly braces.',
    },
    {
      'question': 'How do you comment multiple lines in C++?',
      'answer': '/* */',
      'hint': 'It starts with a slash and a star.',
    },
    {
      'question': 'What will be the output?\n\nint a = 3;\na += 2;\nstd::cout << a;',
      'answer': '5',
      'hint': '+= means add and assign.',
    },
    {
      'question': 'How do you declare a pointer to an int?',
      'answer': 'int* ptr;',
      'hint': 'Use an asterisk.',
    },
    {
      'question': 'Fill in the blank: std::cout << "Result: " << _____;',
      'answer': 'value',
      'hint': 'This is the variable being printed.',
    },
    {
      'question': 'How do you allocate an array of 5 integers dynamically?',
      'answer': 'new int[5];',
      'hint': 'Use new and square brackets.',
    },
    {
      'question': 'What operator is used to access members via a pointer?',
      'answer': '->',
      'hint': 'It’s an arrow.',
    },
    {
      'question': 'Fill in the blank to declare a string:\n\nstd::_____ s = "text";',
      'answer': 'string',
      'hint': 'It’s from the std namespace.',
    },
    {
      'question': 'How do you convert a string to integer in C++?',
      'answer': 'std::stoi()',
      'hint': 'Starts with s, ends with i.',
    },
    {
      'question': 'What is the size of a char in C++?',
      'answer': '1',
      'hint': 'It’s one byte.',
    },
    {
      'question': 'What is the correct syntax for a ternary operator?',
      'answer': 'a > b ? a : b',
      'hint': 'Use ? and :',
    },
    {
      'question': 'Which operator is used for logical AND?',
      'answer': '&&',
      'hint': 'It is two ampersands.',
    },
    {
      'question': 'What header file is required to use std::vector?',
      'answer': '<vector>',
      'hint': 'Name of the container inside angle brackets.',
    },
    {
      'question': 'How do you add an element to a vector?',
      'answer': 'push_back()',
      'hint': 'Think of adding to the back.',
    },
    {
      'question': 'What function returns the size of a vector?',
      'answer': 'size()',
      'hint': 'It returns how many elements are stored.',
    },
    {
      'question': 'How do you access the first element of a vector v?',
      'answer': 'v[0]',
      'hint': 'Use the first index.',
    },
    {
      'question': 'Which keyword defines a constant reference?',
      'answer': 'const',
      'hint': 'Same keyword used for constants.',
    },
    {
      'question': 'How do you print "Yes" only if x > 10?',
      'answer': 'if(x > 10) std::cout << "Yes";',
      'hint': 'Standard if statement syntax.',
    },
    {
      'question': 'What does this do?\n\nint* p = nullptr;',
      'answer': 'initializes pointer to null',
      'hint': 'It points to nothing.',
    },
    {
      'question': 'Fill in the blank to increment a variable:\n\nx_____;',
      'answer': '++',
      'hint': 'Two plus signs.',
    },
    {
      'question': 'How do you check if a string is empty?',
      'answer': 'str.empty()',
      'hint': 'It’s a method with parentheses.',
    },
    {
      'question': 'Which loop is best when the number of iterations is known?',
      'answer': 'for',
      'hint': 'The classic counting loop.',
    },
    {
      'question': 'How do you check if two strings are equal?',
      'answer': 'str1 == str2',
      'hint': 'Use comparison operator.',
    },
    {
      'question': 'What does `break` do in a loop?',
      'answer': 'exits the loop',
      'hint': 'It stops loop execution.',
    },
    {
      'question': 'What does `continue` do?',
      'answer': 'skips to next iteration',
      'hint': 'It ignores rest of current loop cycle.',
    },
    {
      'question': 'What is the correct way to define a function returning int?',
      'answer': 'int func()',
      'hint': 'Start with the return type.',
    },
    {
      'question': 'What keyword is used for a user-defined type?',
      'answer': 'class',
      'hint': 'It’s used for OOP.',
    },
    {
      'question': 'How do you end every C++ statement?',
      'answer': ';',
      'hint': 'A single punctuation mark.',
    },
    {
      'question': 'What is a correct syntax for a switch-case block?',
      'answer': 'switch(x) { case 1: break; }',
      'hint': 'Includes switch, case, and break.',
    },
    {
      'question': 'What symbol separates arguments in function calls?',
      'answer': ',',
      'hint': 'It’s a comma.',
    },
    {
      'question': 'How do you define a boolean variable?',
      'answer': 'bool flag = true;',
      'hint': 'It starts with "bool".',
    },
    {
      'question': 'Which function terminates a program immediately?',
      'answer': 'exit()',
      'hint': 'Declared in <cstdlib>.',
    },
    {
      'question': 'Which function is called automatically when object is destroyed?',
      'answer': 'destructor',
      'hint': 'It starts with ~',
    },
    {
      'question': 'How do you define an array of 5 floats?',
      'answer': 'float arr[5];',
      'hint': 'Use brackets and type.',
    },
    {
      'question': 'What is the value of true + true in C++?',
      'answer': '2',
      'hint': 'true is 1, so 1+1=2',
    },
    {
      'question': 'What does `std::endl` do?',
      'answer': 'prints newline and flushes output',
      'hint': 'It ends the line.',
    },
    {
      'question': 'How do you raise 2 to the power 3 in C++?',
      'answer': 'pow(2, 3)',
      'hint': 'From <cmath> header.',
    },
    {
      'question': 'What operator is used for bitwise AND?',
      'answer': '&',
      'hint': 'Just one ampersand.',
    },
    {
      'question': 'What does the "new" keyword do?',
      'answer': 'allocates memory',
      'hint': 'Used with pointers.',
    },
    {
      'question': 'Which header file is needed for std::string?',
      'answer': '<string>',
      'hint': 'It matches the type name.',
    },
    {
      'question': 'What is the default return type of main()?',
      'answer': 'int',
      'hint': 'C++ requires int.',
    },
    {
      'question': 'What is the keyword to handle exceptions?',
      'answer': 'try',
      'hint': 'Comes before catch.',
    },
    {
      'question': 'How do you catch an exception?',
      'answer': 'catch(...)',
      'hint': 'It uses parentheses.',
    },
    {
      'question': 'What does `throw` do?',
      'answer': 'raises an exception',
      'hint': 'Use it inside a try block.',
    },
    {
      'question': 'How do you print a newline using escape sequence?',
      'answer': '\\n',
      'hint': 'Starts with backslash.',
    },
    {
      'question': 'Which header file gives access to std::map?',
      'answer': '<map>',
      'hint': 'Just the container name in angle brackets.',
    },
    {
      'question': 'How do you declare a function that returns nothing?',
      'answer': 'void',
      'hint': 'The return type is literally "empty".',
    },
    {
      'question': 'What is the syntax to define a constructor in a class named Car?',
      'answer': 'Car()',
      'hint': 'Same name as class, no return type.',
    },
    {
      'question': 'What operator is used to compare two values for equality?',
      'answer': '==',
      'hint': 'It’s a double equal sign.',
    },
    {
      'question': 'Which keyword is used to define a constant member function?',
      'answer': 'const',
      'hint': 'It is added after the function parentheses.',
    },
    {
      'question': 'What keyword makes a base class method overrideable?',
      'answer': 'virtual',
      'hint': 'It’s used in polymorphism.',
    },
    {
      'question': 'What is the symbol to dereference a pointer?',
      'answer': '*',
      'hint': 'Same as multiplication, different use.',
    },
    {
      'question': 'Which standard function sorts elements in a container?',
      'answer': 'sort()',
      'hint': 'Defined in <algorithm>.',
    },
    {
      'question': 'How do you begin a class definition?',
      'answer': 'class MyClass {',
      'hint': 'Use the keyword and a name.',
    },
    {
      'question': 'Which function reads an entire line of input?',
      'answer': 'std::getline()',
      'hint': 'It combines cin and getline.',
    },
    {
      'question': 'What data type holds true/false values?',
      'answer': 'bool',
      'hint': 'Short for "boolean".',
    },
    {
      'question': 'What is the default value of a global int variable?',
      'answer': '0',
      'hint': 'It’s zero if global.',
    },
    {
      'question': 'What keyword is used to define an enumeration?',
      'answer': 'enum',
      'hint': 'Short and starts with "e".',
    },
    {
      'question': 'Which header is needed to use std::set?',
      'answer': '<set>',
      'hint': 'It matches the container name.',
    },
    {
      'question': 'How do you get the size of an array in memory?',
      'answer': 'sizeof(arr)',
      'hint': 'Used to get memory size in bytes.',
    },
    {
      'question': 'How do you open a file for writing?',
      'answer': 'std::ofstream fout("file.txt");',
      'hint': 'Use ofstream and pass file name.',
    },
    {
      'question': 'How do you open a file for reading?',
      'answer': 'std::ifstream fin("file.txt");',
      'hint': 'Use ifstream with filename.',
    },
    {
      'question': 'How do you define a macro for PI?',
      'answer': '#define PI 3.14',
      'hint': 'Starts with a hashtag.',
    },
    {
      'question': 'Which header provides random number functions?',
      'answer': '<cstdlib>',
      'hint': 'Used for rand(), srand().',
    },
    {
      'question': 'What function returns current time?',
      'answer': 'time(0)',
      'hint': 'Used with srand().',
    },
    {
      'question': 'How do you return a value from a function?',
      'answer': 'return',
      'hint': 'Ends the function.',
    },
    {
      'question': 'How do you access class members from an object?',
      'answer': '.',
      'hint': 'Use a dot.',
    },
    {
      'question': 'How do you access a base class method in derived class?',
      'answer': 'Base::method()',
      'hint': 'Use scope resolution.',
    },
    {
      'question': 'What symbol is used for scope resolution?',
      'answer': '::',
      'hint': 'Two colons.',
    },
    {
      'question': 'What does a destructor name start with?',
      'answer': '~',
      'hint': 'It’s a tilde.',
    },
    {
      'question': 'How do you dynamically allocate a single int?',
      'answer': 'new int;',
      'hint': 'Use new keyword.',
    },
    {
      'question': 'What is the return type of main function?',
      'answer': 'int',
      'hint': 'Standard in all C++ programs.',
    },
    {
      'question': 'What is the size of an int on most systems?',
      'answer': '4',
      'hint': 'Usually 4 bytes.',
    },
    {
      'question': 'How do you terminate a string literal?',
      'answer': '\\0',
      'hint': 'It’s the null character.',
    },
    {
      'question': 'What is the name of the C++ standard input stream?',
      'answer': 'std::cin',
      'hint': 'Used to take input.',
    },
    {
      'question': 'What function writes to error stream?',
      'answer': 'std::cerr',
      'hint': 'Similar to cout, but for errors.',
    },
    {
      'question': 'How do you concatenate strings?',
      'answer': '+',
      'hint': 'Use plus sign.',
    },
    {
      'question': 'What loop is best for menu-driven programs?',
      'answer': 'do-while',
      'hint': 'Guarantees at least one execution.',
    },
    {
      'question': 'Which keyword allocates memory at runtime?',
      'answer': 'new',
      'hint': 'It pairs with delete.',
    },
    {
      'question': 'Which keyword deallocates memory?',
      'answer': 'delete',
      'hint': 'Used with new.',
    },
    {
      'question': 'How do you check if a number is even?',
      'answer': 'x % 2 == 0',
      'hint': 'Use modulus.',
    },
    {
      'question': 'Which loop continues until condition becomes false?',
      'answer': 'while',
      'hint': 'It checks before running.',
    },
    {
      'question': 'Which loop is best to run known number of times?',
      'answer': 'for',
      'hint': 'Has three parts.',
    },
    {
      'question': 'How do you comment out a line of code?',
      'answer': '//',
      'hint': 'Double slash.',
    },
    {
      'question': 'Which operator checks for inequality?',
      'answer': '!=',
      'hint': 'Exclamation and equal.',
    },
    {
      'question': 'What does std::fixed do?',
      'answer': 'sets fixed-point notation',
      'hint': 'Used for floats.',
    },
    {
      'question': 'Which function changes output precision?',
      'answer': 'std::setprecision()',
      'hint': 'Found in <iomanip>.',
    },
    {
      'question': 'What is the output of: std::cout << 3 / 2;',
      'answer': '1',
      'hint': 'Integer division truncates.',
    },
    {
      'question': 'What is the output of: std::cout << 3.0 / 2;',
      'answer': '1.5',
      'hint': 'Decimal division.',
    },
    {
      'question': 'Which operator gets the address of a variable?',
      'answer': '&',
      'hint': 'Ampersand before variable.',
    },
    {
      'question': 'Which header contains mathematical functions?',
      'answer': '<cmath>',
      'hint': 'Used for pow(), sqrt().',
    },
    {
      'question': 'What does std::flush do?',
      'answer': 'flushes output buffer',
      'hint': 'Clears pending output.',
    },
    {
      'question': 'How do you stop execution of a program manually?',
      'answer': 'exit(0);',
      'hint': 'Call this from <cstdlib>.',
    },
    {
      'question': 'How do you declare a float literal explicitly?',
      'answer': '3.14f',
      'hint': 'Use f at the end.',
    },
    {
      'question': 'Which data type is used for long integers?',
      'answer': 'long',
      'hint': '5-letter word.',
    },
    {
      'question': 'What is the output type of sizeof()?',
      'answer': 'size_t',
      'hint': 'Unsigned integral type.',
    },
    {
      'question': 'How do you pass a variable by reference?',
      'answer': 'int& x',
      'hint': 'Use ampersand in function param.',
    },
    {
      'question': 'What keyword is used for inheritance?',
      'answer': 'public',
      'hint': 'Used with colon (class A : public B)',
    },
    {
      'question': 'What is the file extension for C++ source files?',
      'answer': '.cpp',
      'hint': 'Three letters, starts with dot.',
    },
    {
      'question': 'Which keyword prevents further subclassing?',
      'answer': 'final',
      'hint': 'Used in modern C++ to block inheritance.',
    },
    {
      'question': 'What function gets the length of a string?',
      'answer': 'length()',
      'hint': 'Returns the number of characters.',
    },
    {
      'question': 'What operator is used to combine multiple conditions?',
      'answer': '&&',
      'hint': 'Logical AND.',
    },
    {
      'question': 'How do you define a multidimensional array?',
      'answer': 'int arr[3][3];',
      'hint': 'Use two sets of brackets.',
    },
    {
      'question': 'Which STL container stores key-value pairs?',
      'answer': 'map',
      'hint': 'Associative container.',
    },
    {
      'question': 'What is the size of a boolean in memory?',
      'answer': '1',
      'hint': 'One byte.',
    },
    {
      'question': 'What is the correct syntax for a do-while loop?',
      'answer': 'do { } while(condition);',
      'hint': 'Loop comes before check.',
    },
    {
      'question': 'What is the keyword for defining a structure?',
      'answer': 'struct',
      'hint': 'Used before class for simpler types.',
    },
    {
      'question': 'What is std::cin used for?',
      'answer': 'input',
      'hint': 'Standard input stream.',
    },
    {
      'question': 'Which keyword is used to handle errors?',
      'answer': 'catch',
      'hint': 'It comes after try.',
    },
    {
      'question': 'Which operator combines output streams?',
      'answer': '<<',
      'hint': 'Also called insertion operator.',
    },
    {
      'question': 'What is the output of std::cout << (5 == 5);',
      'answer': '1',
      'hint': 'True is 1 in C++.',
    },
    // 👉 Paste your list of puzzles here
  ];

  late List<Map<String, String>> _puzzles;
  int _currentIndex = 0;
  final TextEditingController _answerController = TextEditingController();
  String? _feedbackMessage;
  int _score = 0;

  Timer? _timer;
  int _maxTime = 20;
  int _remainingTime = 20;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _puzzles = _getRandomPuzzles(10);
    _startTimer();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await _notifications.initialize(initializationSettings);
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'code_maze_channel',
      'CodeMaze Alerts',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

    await _notifications.show(
      0,
      '🎯 Challenge Complete!',
      'You solved today\'s puzzle — great job!',
      platformDetails,
    );
  }

  List<Map<String, String>> _getRandomPuzzles(int count) {
    final random = Random();
    final shuffled = List<Map<String, String>>.from(_allPuzzles)..shuffle(random);
    return shuffled.take(count).toList();
  }

  void _startTimer() {
    _timer?.cancel();
    _remainingTime = _maxTime;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime <= 0) {
        timer.cancel();
        _goToNextPuzzle();
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  void _checkAnswer() {
    final userAnswer = _answerController.text.trim().toLowerCase();
    final correctAnswer = _puzzles[_currentIndex]['answer']!.toLowerCase();

    setState(() {
      if (userAnswer == correctAnswer) {
        _feedbackMessage = 'Correct! 🎉';
        _score++;
        _savePuzzleProgress();
        _goToNextPuzzle();
      } else {
        _feedbackMessage = 'Incorrect, try again or use hint.';
      }
    });
  }

  void _goToNextPuzzle() {
    _answerController.clear();
    if (_currentIndex < _puzzles.length - 1) {
      _currentIndex++;
      _startTimer();
    } else {
      _timer?.cancel();
      _showNotification();
      _showFinalScore();
    }
  }

  void _showFinalScore() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Game Over'),
        content: Text('Your score: $_score / ${_puzzles.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 0;
                _score = 0;
                _answerController.clear();
                _feedbackMessage = null;
                _puzzles = _getRandomPuzzles(10);
                _startTimer();
              });
            },
            child: const Text('Play Again'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showHint() {
    final hint = _puzzles[_currentIndex]['hint'] ?? 'No hint available.';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(hint)));
  }

  @override
  void dispose() {
    _answerController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _savePuzzleProgress() async {
    final prefs = await SharedPreferences.getInstance();
    int totalSolved = prefs.getInt('puzzlesSolved') ?? 0;
    prefs.setInt('puzzlesSolved', totalSolved + 1);

    final today = DateTime.now().toString().split(' ')[0];
    final key = 'dailyPuzzleLog_$today';
    final dailyList = prefs.getStringList(key) ?? [];
    dailyList.add('solved');
    prefs.setStringList(key, dailyList);
  }

  @override
  Widget build(BuildContext context) {
    final puzzle = _puzzles[_currentIndex];
    final progress = _remainingTime / _maxTime;

    return Scaffold(
      appBar: AppBar(title: const Text('Code Puzzle Challenge')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: progress,
              minHeight: 4,
              backgroundColor: Colors.purple.withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
            ),
            const SizedBox(height: 12),
            Text('Puzzle ${_currentIndex + 1} of ${_puzzles.length}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text(puzzle['question']!, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            TextField(
              controller: _answerController,
              decoration: const InputDecoration(
                labelText: 'Your Answer',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(onPressed: _checkAnswer, child: const Text('Submit')),
                const SizedBox(width: 12),
                ElevatedButton(onPressed: _showHint, child: const Text('Hint')),
              ],
            ),
            if (_feedbackMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                _feedbackMessage!,
                style: TextStyle(
                  color: _feedbackMessage == 'Correct! 🎉' ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
            const Spacer(),
            Text('Score: $_score',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
