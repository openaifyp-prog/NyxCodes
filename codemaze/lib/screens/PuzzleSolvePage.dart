import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizGamePage extends StatefulWidget {
  const QuizGamePage({super.key});

  @override
  State<QuizGamePage> createState() => _QuizGamePageState();
}

class _QuizGamePageState extends State<QuizGamePage> {
  final List<Map<String, dynamic>> _allQuizzes = [
    {
      'question': 'What symbol is used for single line comments in C++?',
      'options': ['//', '/* */', '#', '\$'],
      'answer': '//',
    },
    {
      'question': 'Which keyword is used to define a constant variable in C++?',
      'options': ['const', 'var', 'let', 'final'],
      'answer': 'const',
    },
    {
      'question': 'What does "std::cout" do in C++?',
      'options': ['Reads input', 'Writes output', 'Declares variable', 'Starts program'],
      'answer': 'Writes output',
    },
    {
      'question': 'Which of the following is a correct identifier in C++?',
      'options': ['1var', 'var_1', 'var-1', 'var 1'],
      'answer': 'var_1',
    },
    {
      'question': 'What is the size of an `int` in most 64-bit compilers?',
      'options': ['2 bytes', '4 bytes', '8 bytes', 'Depends on the system'],
      'answer': '4 bytes',
    },
    {
      'question': 'Which of the following loops is guaranteed to execute at least once?',
      'options': ['for loop', 'while loop', 'do-while loop', 'foreach loop'],
      'answer': 'do-while loop',
    },
    {
      'question': 'Which header file is required to use `std::cout`?',
      'options': ['<iostream>', '<stdio.h>', '<conio.h>', '<stdlib.h>'],
      'answer': '<iostream>',
    },
    {
      'question': 'What is the correct way to declare a pointer in C++?',
      'options': ['int* ptr;', 'int ptr;', 'pointer<int> ptr;', 'int ptr*;'],
      'answer': 'int* ptr;',
    },
    {
      'question': 'Which access specifier makes a class member accessible only within its own class?',
      'options': ['public', 'protected', 'private', 'internal'],
      'answer': 'private',
    },
    {
      'question': 'What is the output of: `std::cout << 5 / 2;`',
      'options': ['2.5', '2', '2.0', 'Error'],
      'answer': '2',
    },
    {
      'question': 'Which operator is used to access members of a class through a pointer?',
      'options': ['.', '->', ':', '*'],
      'answer': '->',
    },
    {
      'question': 'What does `new` keyword do in C++?',
      'options': ['Declares a function', 'Creates a variable', 'Allocates memory', 'Initializes a class'],
      'answer': 'Allocates memory',
    },
    {
      'question': 'Which of the following is not a data type in C++?',
      'options': ['float', 'double', 'real', 'int'],
      'answer': 'real',
    },
    {
      'question': 'What is the default access specifier for members of a class in C++?',
      'options': ['public', 'private', 'protected', 'internal'],
      'answer': 'private',
    },
    {
      'question': 'Which keyword is used to inherit a class in C++?',
      'options': ['inherits', 'extends', 'public', 'class'],
      'answer': 'public',
    },
    {
      'question': 'Which data type is used to store a single character in C++?',
      'options': ['char', 'string', 'int', 'byte'],
      'answer': 'char',
    },
    {
      'question': 'What does `cin` do in C++?',
      'options': ['Displays output', 'Takes input', 'Performs calculation', 'Creates object'],
      'answer': 'Takes input',
    },
    {
      'question': 'What is the correct syntax for a for loop in C++?',
      'options': ['for i=1 to 10', 'foreach(int i in 10)', 'for(int i = 0; i < 10; i++)', 'loop i = 1 to 10'],
      'answer': 'for(int i = 0; i < 10; i++)',
    },
    {
      'question': 'Which header file is used for string functions?',
      'options': ['<string>', '<cstring>', '<strlib>', '<stdio.h>'],
      'answer': '<cstring>',
    },
    {
      'question': 'What is the result of: `5 % 2` in C++?',
      'options': ['2.5', '0', '1', '2'],
      'answer': '1',
    },
    {
      'question': 'Which function is used to find the length of a string?',
      'options': ['length()', 'strlen()', 'sizeof()', 'count()'],
      'answer': 'strlen()',
    },
    {
      'question': 'Which symbol is used to declare a pointer?',
      'options': ['&', '*', '@', '%'],
      'answer': '*',
    },
    {
      'question': 'Which C++ feature allows defining functions with the same name but different parameters?',
      'options': ['Inheritance', 'Encapsulation', 'Polymorphism', 'Overloading'],
      'answer': 'Overloading',
    },
    {
      'question': 'Which keyword is used to define a class in C++?',
      'options': ['object', 'class', 'define', 'struct'],
      'answer': 'class',
    },
    {
      'question': 'Which concept restricts direct access to class members?',
      'options': ['Abstraction', 'Encapsulation', 'Inheritance', 'Overloading'],
      'answer': 'Encapsulation',
    },
    {
      'question': 'Which of the following is NOT a C++ loop construct?',
      'options': ['for', 'while', 'repeat-until', 'do-while'],
      'answer': 'repeat-until',
    },
    {
      'question': 'Which of the following can be overloaded in C++?',
      'options': ['Operators', 'Constructors', 'Functions', 'All of the above'],
      'answer': 'All of the above',
    },
    {
      'question': 'Which keyword is used to define a function that cannot be overridden?',
      'options': ['const', 'sealed', 'final', 'virtual'],
      'answer': 'final',
    },
    {
      'question': 'What will `sizeof(char)` return?',
      'options': ['1', '2', '4', 'Depends on OS'],
      'answer': '1',
    },
    {
      'question': 'Which operator is used to allocate memory dynamically?',
      'options': ['malloc', 'alloc', 'new', 'create'],
      'answer': 'new',
    },
    {
      'question': 'Which symbol is used to include a header file?',
      'options': ['#', '@', '&', '%'],
      'answer': '#',
    },
    {
      'question': 'Which of the following is used to release dynamic memory in C++?',
      'options': ['delete', 'free', 'remove', 'dispose'],
      'answer': 'delete',
    },
    {
      'question': 'What is the use of the `return` statement?',
      'options': ['Terminate program', 'Return value from function', 'Pause execution', 'Loop again'],
      'answer': 'Return value from function',
    },
    {
      'question': 'What is the correct syntax to declare an array of 10 integers?',
      'options': ['int arr(10);', 'array<int> arr[10];', 'int arr[10];', 'arr<int> = 10;'],
      'answer': 'int arr[10];',
    },
    {
      'question': 'Which keyword creates a constant reference that cannot be changed?',
      'options': ['ref', 'immutable', 'const', 'readonly'],
      'answer': 'const',
    },
    {
      'question': 'Which data type would be most suitable to store 3.14159?',
      'options': ['int', 'float', 'char', 'bool'],
      'answer': 'float',
    },
    {
      'question': 'Which keyword is used to exit a loop immediately?',
      'options': ['stop', 'exit', 'break', 'return'],
      'answer': 'break',
    },
    {
      'question': 'Which operator is used for logical AND in C++?',
      'options': ['&&', '&', 'and', '%%'],
      'answer': '&&',
    },
    {
      'question': 'What is the output of: `std::cout << 10 / 3;`?',
      'options': ['3', '3.3', '3.3333', 'Error'],
      'answer': '3',
    },
    {
      'question': 'Which of the following is NOT a valid C++ data type?',
      'options': ['int', 'real', 'float', 'char'],
      'answer': 'real',
    },
    {
      'question': 'Which operator is used to compare two values?',
      'options': ['=', '==', '!=', '<>'],
      'answer': '==',
    },
    {
      'question': 'Which character ends a statement in C++?',
      'options': ['.', ';', ':', '!'],
      'answer': ';',
    },
    {
      'question': 'Which keyword is used to create an object in C++?',
      'options': ['new', 'object', 'class', 'None of these'],
      'answer': 'None of these',
    },
    {
      'question': 'Which loop checks the condition after executing the loop body?',
      'options': ['for', 'while', 'do-while', 'None'],
      'answer': 'do-while',
    },
    {
      'question': 'Which function is used to convert string to integer?',
      'options': ['stoi()', 'int()', 'convert()', 'parseInt()'],
      'answer': 'stoi()',
    },
    {
      'question': 'Which keyword is used to define an inline function?',
      'options': ['inline', 'define', 'macro', 'static'],
      'answer': 'inline',
    },
    {
      'question': 'Which of the following is a reference operator in C++?',
      'options': ['*', '&', '%', r'$'],
      'answer': '&',
    },
    {
      'question': 'How do you start the main function in C++?',
      'options': ['start()', 'begin()', 'main()', 'function main()'],
      'answer': 'main()',
    },
    {
      'question': 'Which of these is used for comments in C++?',
      'options': ['#', '//', '\\\\', '--'],
      'answer': '//',
    },
    {
      'question': 'What is the file extension of a C++ source file?',
      'options': ['.txt', '.java', '.cpp', '.exe'],
      'answer': '.cpp',
    },
    {
      'question': 'Which of the following indicates a boolean value?',
      'options': ['bool', 'boolean', 'bit', 'tinyint'],
      'answer': 'bool',
    },
    {
      'question': 'What does `sizeof()` return?',
      'options': ['Number of elements', 'Memory size', 'String length', 'Position'],
      'answer': 'Memory size',
    },
    {
      'question': 'Which of the following is a valid loop keyword?',
      'options': ['loop', 'goto', 'next', 'while'],
      'answer': 'while',
    },
    {
      'question': 'Which keyword is used to stop a loop prematurely?',
      'options': ['exit', 'stop', 'break', 'end'],
      'answer': 'break',
    },
    {
      'question': 'Which of the following is not part of OOP?',
      'options': ['Encapsulation', 'Inheritance', 'Compilation', 'Polymorphism'],
      'answer': 'Compilation',
    },
    {
      'question': 'What does `this` keyword refer to?',
      'options': ['Current object', 'Previous object', 'Parent class', 'Global object'],
      'answer': 'Current object',
    },
    {
      'question': 'What is an abstract class?',
      'options': ['A class with all members private', 'A class with at least one pure virtual function', 'A class that cannot have constructor', 'A template class'],
      'answer': 'A class with at least one pure virtual function',
    },
    {
      'question': 'Which keyword is used to define a base class function in child class?',
      'options': ['virtual', 'protected', 'override', 'final'],
      'answer': 'override',
    },
    {
      'question': 'How is memory released in C++?',
      'options': ['free()', 'release()', 'delete', 'dispose()'],
      'answer': 'delete',
    },
    {
      'question': 'Which of the following is used to define a block of code?',
      'options': ['()', '{}', '<>', '[]'],
      'answer': '{}',
    },
    {
      'question': 'What is the use of `try` block in C++?',
      'options': ['To declare variables', 'To catch errors', 'To try loops', 'To run main'],
      'answer': 'To catch errors',
    },
    {
      'question': 'Which of the following is NOT a storage class in C++?',
      'options': ['static', 'register', 'volatile', 'extern'],
      'answer': 'volatile',
    },
    {
      'question': 'Which function must be present in all C++ programs?',
      'options': ['start()', 'main()', 'run()', 'program()'],
      'answer': 'main()',
    },
    {
      'question': 'Which of these initiates a class constructor?',
      'options': ['~ClassName()', 'ClassName()', 'new ClassName()', 'init()'],
      'answer': 'ClassName()',
    },
    {
      'question': 'What is a correct destructor declaration?',
      'options': ['~MyClass()', 'MyClass()', 'delete MyClass()', 'destroy MyClass()'],
      'answer': '~MyClass()',
    },
    {
      'question': 'What will `int x = 5.5;` result in?',
      'options': ['Error', '6', '5', '5.5'],
      'answer': '5',
    },
    {
      'question': 'Which header file contains math functions like `sqrt()`?',
      'options': ['<maths.h>', '<cmath>', '<math>', '<mymath.h>'],
      'answer': '<cmath>',
    },
    {
      'question': 'What does `->` operator mean in C++?',
      'options': ['Pointer to member', 'Return value', 'Class access', 'Bitwise arrow'],
      'answer': 'Pointer to member',
    },
    {
      'question': 'Which of the following is used for dynamic memory allocation?',
      'options': ['create', 'allocate', 'new', 'assign'],
      'answer': 'new',
    },
    {
      'question': 'How is `public` inheritance written?',
      'options': ['class A inherits B', 'class A : public B', 'class A <- B', 'class A. B'],
      'answer': 'class A : public B',
    },
    {
      'question': 'Which of the following is used to define a template?',
      'options': ['template<>', 'template<T>', 'template<class T>', 'template[]'],
      'answer': 'template<class T>',
    },
    {
      'question': 'Which of these is NOT a valid pointer operation?',
      'options': ['Increment', 'Decrement', 'Addition', 'Multiplication'],
      'answer': 'Multiplication',
    },
    {
      'question': 'Which of the following is true about C++?',
      'options': ['It is an interpreted language', 'It supports OOP', 'It runs only on Linux', 'It cannot handle exceptions'],
      'answer': 'It supports OOP',
    },
    {
      'question': 'What does `const` keyword mean?',
      'options': ['Variable can be reassigned', 'Variable can be modified', 'Value is fixed', 'Type is constant'],
      'answer': 'Value is fixed',
    },
    {
      'question': 'Which access specifier allows class members to be accessed outside the class?',
      'options': ['public', 'private', 'protected', 'internal'],
      'answer': 'public',
    },
    {
      'question': 'Which of the following keywords is used to define an enumeration?',
      'options': ['enum', 'enumerate', 'enumtype', 'list'],
      'answer': 'enum',
    },
    {
      'question': 'What does `NULL` represent in C++?',
      'options': ['Zero integer', 'End of loop', 'Invalid number', 'Null pointer'],
      'answer': 'Null pointer',
    },
    {
      'question': 'Which operator is overloaded for output?',
      'options': ['<<', '>>', '==', '='],
      'answer': '<<',
    },
    {
      'question': 'Which of these can be used to implement polymorphism?',
      'options': ['Function Overloading', 'Operator Overloading', 'Virtual Functions', 'All of the above'],
      'answer': 'All of the above',
    },
    {
      'question': 'What is `std` in C++?',
      'options': ['A variable', 'A function', 'A namespace', 'A macro'],
      'answer': 'A namespace',
    },
    {
      'question': 'Which keyword is used for exception handling in C++?',
      'options': ['error', 'catch', 'exception', 'trycatch'],
      'answer': 'catch',
    },
    {
      'question': 'What does the `continue` keyword do in a loop?',
      'options': ['Stops loop', 'Skips iteration', 'Restarts loop', 'Ends program'],
      'answer': 'Skips iteration',
    },
    {
      'question': 'What is a constructor?',
      'options': ['A function that initializes objects', 'A function that deletes memory', 'A function that prints output', 'None of the above'],
      'answer': 'A function that initializes objects',
    },
    {
      'question': 'Which of the following is the correct way to declare a constant?',
      'options': ['final x = 10;', 'const int x = 10;', 'constant int x;', 'immutable x = 10;'],
      'answer': 'const int x = 10;',
    },
    {
      'question': 'Which of the following denotes a pointer to pointer?',
      'options': ['**ptr', '*ptr*', '&*ptr', '** ptr'],
      'answer': '**ptr',
    },
    {
      'question': 'Which keyword is used to prevent a class from being inherited?',
      'options': ['final', 'sealed', 'static', 'const'],
      'answer': 'final',
    },
    {
      'question': 'What is the output of `std::cout << true;` in C++?',
      'options': ['true', '1', 'yes', 'on'],
      'answer': '1',
    },
    {
      'question': 'Which of the following is a ternary operator in C++?',
      'options': ['::', '?:', '&&', '++'],
      'answer': '?:',
    },
    {
      'question': 'Which symbol is used for scope resolution in C++?',
      'options': ['::', '.', '->', ':='],
      'answer': '::',
    },
    {
      'question': 'Which header file is needed for `std::vector`?',
      'options': ['<vector>', '<list>', '<array>', '<map>'],
      'answer': '<vector>',
    },
    {
      'question': 'Which C++ container allows fast insertion at both ends?',
      'options': ['vector', 'list', 'deque', 'map'],
      'answer': 'deque',
    },
    {
      'question': 'What does STL stand for?',
      'options': ['Standard Template Language', 'Simple Type Language', 'Standard Tools Library', 'Standard Template Library'],
      'answer': 'Standard Template Library',
    },
    {
      'question': 'Which header defines the `std::map` container?',
      'options': ['<map>', '<unordered_map>', '<vector>', '<set>'],
      'answer': '<map>',
    },
    {
      'question': 'What is the default return type of main function in C++?',
      'options': ['void', 'int', 'float', 'string'],
      'answer': 'int',
    },
    {
      'question': 'Which method is used to insert an element in a set?',
      'options': ['add()', 'append()', 'insert()', 'put()'],
      'answer': 'insert()',
    },
    {
      'question': 'Which loop is best used when the number of iterations is known?',
      'options': ['while', 'do-while', 'for', 'infinite'],
      'answer': 'for',
    },
    {
      'question': 'Which keyword defines a macro in C++?',
      'options': ['macro', 'define', '#define', 'const'],
      'answer': '#define',
    },
    {
      'question': 'What is the maximum value for a `short` on most systems?',
      'options': ['32767', '65535', '2147483647', '127'],
      'answer': '32767',
    },
    {
      'question': 'Which container does not allow duplicate elements?',
      'options': ['vector', 'set', 'multiset', 'list'],
      'answer': 'set',
    },
    {
      'question': 'Which operator is used to allocate arrays dynamically?',
      'options': ['malloc', 'calloc', 'new[]', 'create'],
      'answer': 'new[]',
    },
    {
      'question': 'Which method is used to check if a file is open?',
      'options': ['file.exists()', 'file.status()', 'file.opened()', 'file.is_open()'],
      'answer': 'file.is_open()',
    },
    {
      'question': 'What is the extension of C++ header files?',
      'options': ['.cpp', '.cxx', '.hpp', '.hxx'],
      'answer': '.hpp',
    },
    {
      'question': 'Which keyword is used to handle exceptions?',
      'options': ['catch', 'throw', 'try', 'All of the above'],
      'answer': 'All of the above',
    },
    {
      'question': 'What happens when you divide an integer by zero in C++?',
      'options': ['Returns 0', 'Throws error', 'Compile error', 'Undefined behavior'],
      'answer': 'Undefined behavior',
    },
    {
      'question': 'What is a segmentation fault?',
      'options': ['Compile-time error', 'Incorrect type cast', 'Accessing invalid memory', 'Syntax error'],
      'answer': 'Accessing invalid memory',
    },
    {
      'question': 'Which file stream is used for writing into files?',
      'options': ['ifstream', 'fstream', 'ofstream', 'filewriter'],
      'answer': 'ofstream',
    },
    {
      'question': 'Which of the following is a fundamental data type?',
      'options': ['string', 'float', 'class', 'object'],
      'answer': 'float',
    },
    {
      'question': 'Which function converts a number to string in C++?',
      'options': ['to_string()', 'str()', 'stringify()', 'convert()'],
      'answer': 'to_string()',
    },
    {
      'question': 'Which of the following is an associative container?',
      'options': ['vector', 'set', 'array', 'deque'],
      'answer': 'set',
    },
    {
      'question': 'Which symbol denotes comments for documentation in C++?',
      'options': ['/** */', '///', '//', '###'],
      'answer': '///',
    },
    {
      'question': 'Which of the following creates a string object?',
      'options': ['char str[] = "hello";', 'string str = "hello";', 'text str = "hello";', 'string = hello;'],
      'answer': 'string str = "hello";',
    },
    {
      'question': 'What is the output of: `sizeof(double)` on most systems?',
      'options': ['2', '4', '8', '16'],
      'answer': '8',
    },
    {
      'question': 'Which function ends a program immediately?',
      'options': ['break()', 'end()', 'exit()', 'close()'],
      'answer': 'exit()',
    },
    {
      'question': 'Which of the following is a valid function declaration?',
      'options': ['int function;', 'int function()', 'function() int;', 'int function = ()'],
      'answer': 'int function()',
    },
    {
      'question': 'Which operator is overloaded for input?',
      'options': ['>>', '<<', '==', '>='],
      'answer': '>>',
    },
    {
      'question': 'What is the use of `friend` keyword?',
      'options': ['Declares friendly class', 'Access private data from outside', 'Prevents inheritance', 'Overloads operators'],
      'answer': 'Access private data from outside',
    },
    {
      'question': 'Which function returns the number of characters in a string?',
      'options': ['length()', 'size()', 'count()', 'Both length() and size()'],
      'answer': 'Both length() and size()',
    },
    {
      'question': 'Which of the following is a relational operator?',
      'options': ['==', '!=', '<=', 'All of the above'],
      'answer': 'All of the above',
    },
    {
      'question': 'Which of the following denotes a constant reference?',
      'options': ['const &', '&const', '*const', '#ref'],
      'answer': 'const &',
    },
    {
      'question': 'Which STL container uses key-value pairs?',
      'options': ['vector', 'deque', 'map', 'list'],
      'answer': 'map',
    },
    {
      'question': 'What will be the output of `std::cout << 3 + 2 * 2;`?',
      'options': ['10', '7', '8', '9'],
      'answer': '7',
    },
    {
      'question': 'What is the purpose of `static` keyword in functions?',
      'options': ['Make function public', 'Limit scope to file', 'Enable recursion', 'Prevent deletion'],
      'answer': 'Limit scope to file',
    },
    {
      'question': 'Which of these is a preprocessor directive?',
      'options': ['#include', '#define', '#if', 'All of the above'],
      'answer': 'All of the above',
    },
    {
      'question': 'Which data structure uses LIFO order?',
      'options': ['Queue', 'Array', 'Stack', 'List'],
      'answer': 'Stack',
    },
    {
      'question': 'Which function is used to sort elements in C++ STL?',
      'options': ['order()', 'sort()', 'arrange()', 'reorder()'],
      'answer': 'sort()',
    },
    {
      'question': 'Which method closes an open file?',
      'options': ['shutdown()', 'close()', 'exit()', 'end()'],
      'answer': 'close()',
    },
    {
      'question': 'What is a correct way to declare a 2D array in C++?',
      'options': ['int arr(3,3);', 'int arr[3][3];', 'int[3][3] arr;', 'array[3][3] int;'],
      'answer': 'int arr[3][3];',
    },
    {
      'question': 'Which of the following is used to check a condition?',
      'options': ['if', 'do', 'loop', 'switch'],
      'answer': 'if',
    },
    {
      'question': 'Which of these can be used to stop `switch` execution?',
      'options': ['end', 'stop', 'break', 'close'],
      'answer': 'break',
    },
    {
      'question': 'What does the `default` keyword do in a switch statement?',
      'options': ['Skips condition', 'Matches any case', 'Handles unmatched cases', 'Exits loop'],
      'answer': 'Handles unmatched cases',
    },
    {
      'question': 'What is the purpose of `static_cast` in C++?',
      'options': ['Type conversion', 'Function definition', 'Memory allocation', 'Variable scope'],
      'answer': 'Type conversion',
    },
    {
      'question': 'Which casting is used to convert one class type to another?',
      'options': ['reinterpret_cast', 'dynamic_cast', 'type_cast', 'auto_cast'],
      'answer': 'dynamic_cast',
    },
    {
      'question': 'What is the purpose of `virtual` keyword in C++?',
      'options': ['To define a macro', 'To define an interface', 'To allow function overriding', 'To create thread'],
      'answer': 'To allow function overriding',
    },
    {
      'question': 'What will be the output of `5 << 1`?',
      'options': ['10', '2', '6', '0'],
      'answer': '10',
    },
    {
      'question': 'What does `getline()` do?',
      'options': ['Reads one word', 'Reads entire line', 'Reads number only', 'Skips line'],
      'answer': 'Reads entire line',
    },
    {
      'question': 'Which of these is used for function overloading?',
      'options': ['Same name, different parameters', 'Different names', 'Same name and same parameters', 'Same name, same return'],
      'answer': 'Same name, different parameters',
    },
    {
      'question': 'Which operator is used to find remainder?',
      'options': ['/', '\\', '%', '^'],
      'answer': '%',
    },
    {
      'question': 'Which keyword specifies inheritance from multiple classes?',
      'options': ['multi', 'inherits', 'multiple', 'Use comma between class names'],
      'answer': 'Use comma between class names',
    },
    {
      'question': 'Which of these is a unary operator?',
      'options': ['+', '-', '++', '*'],
      'answer': '++',
    },
    {
      'question': 'What will `int a = 10 / 3;` store in `a`?',
      'options': ['3.33', '3', '0', 'Error'],
      'answer': '3',
    },
    {
      'question': 'Which function is used to reverse a string in C++ STL?',
      'options': ['reverse()', 'strrev()', 'flip()', 'invert()'],
      'answer': 'reverse()',
    },
    {
      'question': 'Which keyword is used to define a namespace?',
      'options': ['ns', 'namespace', 'space', 'group'],
      'answer': 'namespace',
    },
    {
      'question': 'Which of these is used for memory deallocation of arrays?',
      'options': ['delete', 'free', 'delete[]', 'remove'],
      'answer': 'delete[]',
    },
    {
      'question': 'What is the output of `true && false`?',
      'options': ['true', 'false', '1', 'Error'],
      'answer': 'false',
    },
    {
      'question': 'What does `std::endl` do?',
      'options': ['Ends program', 'Prints output', 'Prints newline and flushes buffer', 'Flushes memory'],
      'answer': 'Prints newline and flushes buffer',
    },
    {
      'question': 'What is the default value of a global int variable in C++?',
      'options': ['Undefined', '0', '1', 'Depends on compiler'],
      'answer': '0',
    },
    {
      'question': 'Which of the following is used for input in C++?',
      'options': ['std::cin', 'std::cout', 'input()', 'getline'],
      'answer': 'std::cin',
    },
    {
      'question': 'Which STL container allows duplicate keys?',
      'options': ['map', 'unordered_map', 'multimap', 'set'],
      'answer': 'multimap',
    },
    {
      'question': 'Which keyword is used to return a value from a function?',
      'options': ['exit', 'break', 'return', 'end'],
      'answer': 'return',
    },
    {
      'question': 'What is the return type of `main()` in C++?',
      'options': ['void', 'int', 'char', 'main'],
      'answer': 'int',
    },
    {
      'question': 'Which operator cannot be overloaded?',
      'options': ['+', '=', '?:', '[]'],
      'answer': '?:',
    },
    {
      'question': 'What happens if you forget `break` in a switch?',
      'options': ['Compilation error', 'Default runs', 'Fall-through to next case', 'Returns to main'],
      'answer': 'Fall-through to next case',
    },
    {
      'question': 'What is the purpose of `extern` keyword?',
      'options': ['To define local variable', 'To declare global variable', 'To use from other file', 'To create pointer'],
      'answer': 'To use from other file',
    },
    {
      'question': 'Which type of function cannot be inherited?',
      'options': ['public', 'protected', 'private', 'virtual'],
      'answer': 'private',
    },
    {
      'question': 'Which of the following denotes pass-by-reference?',
      'options': ['*', '&', '&&', '#'],
      'answer': '&',
    },
    {
      'question': 'What does the `typeid` operator return?',
      'options': ['Object type', 'Size of object', 'Name of variable', 'Null'],
      'answer': 'Object type',
    },
    {
      'question': 'Which container keeps elements sorted by default?',
      'options': ['vector', 'list', 'set', 'deque'],
      'answer': 'set',
    },
    {
      'question': 'What is the primary purpose of a constructor?',
      'options': ['To initialize objects', 'To destroy objects', 'To allocate memory', 'To overload operators'],
      'answer': 'To initialize objects',
    },
    {
      'question': 'Which of these is a valid way to declare a reference variable?',
      'options': ['int &x = y;', 'int x& = y;', '&int x = y;', 'ref int x = y;'],
      'answer': 'int &x = y;',
    },
    {
      'question': 'Which keyword is used to declare an abstract class?',
      'options': ['abstract', 'virtual', 'interface', 'None of the above'],
      'answer': 'None of the above',
    },
    {
      'question': 'Which of the following is used to open a file in read mode?',
      'options': ['ios::out', 'ios::in', 'ios::app', 'ios::binary'],
      'answer': 'ios::in',
    },
    {
      'question': 'What is a friend function in C++?',
      'options': ['Function declared inside class', 'Function outside but has access to private members', 'Function inside struct only', 'Function only for static members'],
      'answer': 'Function outside but has access to private members',
    },
    {
      'question': 'Which of these supports polymorphism?',
      'options': ['Constructor', 'Overloaded function', 'Virtual function', 'All of the above'],
      'answer': 'All of the above',
    },
    {
      'question': 'What is the result of `10 >> 1`?',
      'options': ['5', '20', '8', '0'],
      'answer': '5',
    },
    {
      'question': 'What does the keyword `volatile` indicate?',
      'options': ['Variable is read-only', 'Variable may change unexpectedly', 'Variable is global', 'Variable is unused'],
      'answer': 'Variable may change unexpectedly',
    },
    {
      'question': 'Which of the following is a bitwise operator?',
      'options': ['&&', '||', '&', '=='],
      'answer': '&',
    },
    {
      'question': 'What is the output of: `std::cout << sizeof(bool);`?',
      'options': ['4', '2', '1', '8'],
      'answer': '1',
    },
    {
      'question': 'Which keyword is used to define constants in C++?',
      'options': ['define', 'const', 'static', 'final'],
      'answer': 'const',
    },
    {
      'question': 'Which method is automatically called when an object is deleted?',
      'options': ['destroy()', 'delete()', 'destructor', 'None of these'],
      'answer': 'destructor',
    },
    {
      'question': 'Which of the following denotes function templates?',
      'options': ['template<class T>', 'template type', 'generic<T>', 'typedef'],
      'answer': 'template<class T>',
    },
    {
      'question': 'Which of the following types is typically 8 bytes?',
      'options': ['char', 'int', 'double', 'short'],
      'answer': 'double',
    },
    {
      'question': 'What is the file extension for compiled C++ code?',
      'options': ['.cpp', '.exe', '.obj', '.cxx'],
      'answer': '.exe',
    },
    {
      'question': 'Which operator cannot be used with pointers?',
      'options': ['*', '->', '++', '%'],
      'answer': '%',
    },
    {
      'question': 'Which of the following returns the ASCII value of a character?',
      'options': ['asc()', 'char()', 'int()', 'ord()'],
      'answer': 'int()',
    },
    {
      'question': 'Which feature of OOP allows using the same function name with different arguments?',
      'options': ['Encapsulation', 'Abstraction', 'Polymorphism', 'Inheritance'],
      'answer': 'Polymorphism',
    },
    {
      'question': 'Which keyword prevents further overriding of a virtual function?',
      'options': ['static', 'final', 'sealed', 'locked'],
      'answer': 'final',
    },
    {
      'question': 'Which keyword is used to exit a function early?',
      'options': ['exit', 'break', 'return', 'stop'],
      'answer': 'return',
    },
    {
      'question': 'Which header file contains file operations in C++?',
      'options': ['<file.h>', '<fstream>', '<input.h>', '<stdio>'],
      'answer': '<fstream>',
    },
    {
      'question': 'Which class is used for writing files in C++?',
      'options': ['ifstream', 'fstream', 'ofstream', 'reader'],
      'answer': 'ofstream',
    },
    {
      'question': 'Which of the following is not a loop control statement?',
      'options': ['break', 'continue', 'goto', 'return'],
      'answer': 'return',
    },
    {
      'question': 'Which of the following statements about destructors is true?',
      'options': ['They return int', 'They can be overloaded', 'They have same name as class with ~', 'They can take arguments'],
      'answer': 'They have same name as class with ~',
    },
    {
      'question': 'Which of these is not an access specifier?',
      'options': ['public', 'private', 'protected', 'sealed'],
      'answer': 'sealed',
    },
    {
      'question': 'Which keyword is used to create a structure in C++?',
      'options': ['class', 'struct', 'record', 'group'],
      'answer': 'struct',
    },
    {
      'question': 'Which of these containers is best for implementing LRU cache?',
      'options': ['set', 'vector', 'list', 'deque'],
      'answer': 'deque',
    },
    {
      'question': 'Which algorithm is used to search elements in sorted containers?',
      'options': ['find()', 'linear_search()', 'binary_search()', 'locate()'],
      'answer': 'binary_search()',
    },
    {
      'question': 'Which STL container maintains insertion order?',
      'options': ['set', 'unordered_set', 'list', 'map'],
      'answer': 'list',
    },
    {
      'question': 'Which C++11 feature allows range-based for loop?',
      'options': ['lambda', 'auto', 'foreach', 'range-for'],
      'answer': 'range-for',
    },
    {
      'question': 'What is the correct way to comment multiple lines in C++?',
      'options': ['//', '/* */', '##', '#!'],
      'answer': '/* */',
    },

    // Add more questions here...
    // 📌 Replace this comment with your quiz list (question, options, answer)
    /*
    Example:
    {
      "question": "What is the correct way to start a main function in C++?",
      "options": ["main()", "int main()", "void main()", "start()"],
      "answer": "int main()"
    },
    */
  ];

  late List<Map<String, dynamic>> _quizzes;
  int _currentIndex = 0;
  int _score = 0;
  String? _selectedAnswer;
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    _quizzes = _getRandomQuizzes(10);
  }

  List<Map<String, dynamic>> _getRandomQuizzes(int count) {
    final random = Random();
    final shuffled = List<Map<String, dynamic>>.from(_allQuizzes)..shuffle(random);
    return shuffled.take(count).toList();
  }

  void _submitAnswer() async {
    if (_answered || _selectedAnswer == null) return;

    setState(() {
      _answered = true;
    });

    final correct = _quizzes[_currentIndex]['answer'];
    if (_selectedAnswer == correct) {
      _score++;
      final prefs = await SharedPreferences.getInstance();
      final prev = prefs.getInt('quizzesPassed') ?? 0;
      prefs.setInt('quizzesPassed', prev + 1);
    }

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _answered = false;
        _selectedAnswer = null;

        if (_currentIndex < _quizzes.length - 1) {
          _currentIndex++;
        } else {
          _showFinalScore();
        }
      });
    });
  }

  void _showFinalScore() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Quiz Complete!'),
        content: Text('Your score: $_score / ${_quizzes.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 0;
                _score = 0;
                _quizzes = _getRandomQuizzes(10);
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

  @override
  Widget build(BuildContext context) {
    final quiz = _quizzes[_currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Game')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Question ${_currentIndex + 1} of ${_quizzes.length}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text(quiz['question'], style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ...List.generate(quiz['options'].length, (index) {
              final option = quiz['options'][index];
              final isCorrect = option == quiz['answer'];
              final isSelected = _selectedAnswer == option;

              Color? tileColor;
              if (_answered && isSelected) {
                tileColor = isCorrect ? Colors.green : Colors.red;
              }

              return Card(
                color: tileColor,
                child: RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: _selectedAnswer,
                  onChanged: _answered ? null : (value) {
                    setState(() => _selectedAnswer = value);
                  },
                ),
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitAnswer,
              child: const Text('Submit'),
            ),
            const Spacer(),
            Text('Score: $_score',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
