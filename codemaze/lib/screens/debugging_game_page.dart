import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DebuggingGamePage extends StatefulWidget {
  const DebuggingGamePage({Key? key}) : super(key: key);

  @override
  State<DebuggingGamePage> createState() => _DebuggingGamePageState();
}

class _DebuggingGamePageState extends State<DebuggingGamePage> {
  final List<Map<String, String>> _allDebugChallenges = [
    {
      'code': '''
int main() {
  int x = 10
  std::cout << x << std::endl;
  return 0;
}
''',
      'bug': 'Missing semicolon after int x = 10',
      'fix': 'Add semicolon at the end of int x = 10;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << "Hello World" << std::endl
  return 0;
}
''',
      'bug': 'Missing semicolon after std::cout line',
      'fix': 'Add semicolon at the end of std::cout << "Hello World" << std::endl;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int a = 5;
  if(a = 10) {
    std::cout << "Equal";
  }
  return 0;
}
''',
      'bug': 'Assignment (=) used instead of comparison (==) in if condition',
      'fix': 'Replace a = 10 with a == 10 in the if statement',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << "Welcome" << std::endl;
  return
}
''',
      'bug': 'Missing semicolon after return statement',
      'fix': 'Add semicolon after return;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int x;
  std::cout << x;
  return 0;
}
''',
      'bug': 'Variable x is used without initialization',
      'fix': 'Initialize variable x before using: int x = 0;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int a = 10, b = 0;
  std::cout << a / b;
  return 0;
}
''',
      'bug': 'Division by zero',
      'fix': 'Ensure denominator b is not zero before division',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int arr[3] = {1, 2, 3};
  std::cout << arr[3];
  return 0;
}
''',
      'bug': 'Accessing array out of bounds',
      'fix': 'Use valid index: last valid index is arr[2]',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::string name;
  std::cin >> name;
  std::getline(std::cin, name);
  std::cout << name;
  return 0;
}
''',
      'bug': 'std::getline is skipped due to leftover newline in input buffer',
      'fix': 'Add std::cin.ignore() before std::getline()',
    },
    {
      'code': '''
#include <iostream>

void print() {
  std::cout << x;
}

int main() {
  int x = 5;
  print();
  return 0;
}
''',
      'bug': 'Variable x is not accessible in function print',
      'fix': 'Pass x as a parameter to print function: void print(int x)',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int* ptr = nullptr;
  std::cout << *ptr;
  return 0;
}
''',
      'bug': 'Dereferencing a null pointer',
      'fix': 'Check if pointer is not null before dereferencing',
    },
    {
      'code': '''
#include <iostream>

int main() {
  for(int i = 0; i <= 5; i++)
    int sum += i;
  std::cout << sum;
  return 0;
}
''',
      'bug': 'Variable sum is not declared and scope issue in for loop',
      'fix': 'Declare sum before loop: int sum = 0;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << "The value is: " << std::endl << 100
  return 0;
}
''',
      'bug': 'Missing semicolon after printing 100',
      'fix': 'Add semicolon after std::endl << 100;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int value = "100";
  std::cout << value;
  return 0;
}
''',
      'bug': 'Assigning a string literal to an int variable',
      'fix': 'Replace "100" with 100 (remove quotes)',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int a = 5, b = 2;
  float result = a / b;
  std::cout << result;
  return 0;
}
''',
      'bug': 'Integer division causes loss of decimal precision',
      'fix': 'Use float conversion: float result = (float)a / b;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int a = 0;
  if (a = 1)
    std::cout << "True";
  return 0;
}
''',
      'bug': 'Using assignment (=) instead of comparison (==) in condition',
      'fix': 'Replace a = 1 with a == 1 in if statement',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::string str = Hello;
  std::cout << str;
  return 0;
}
''',
      'bug': 'Missing double quotes around string literal',
      'fix': 'Wrap Hello in quotes: std::string str = "Hello";',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int x;
  std::cout << "x = " << x;
  return 0;
}
''',
      'bug': 'Using variable x without initializing',
      'fix': 'Initialize x before using: int x = 0;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int a = 10, b = 0;
  if (b != 0 && a / b)
    std::cout << "Valid";
  return 0;
}
''',
      'bug': 'Short-circuit condition will still evaluate a / b if not written correctly',
      'fix': 'Check b != 0 before division: if (b != 0 && a / b > 0)',
    },
    {
      'code': '''
#include <iostream>

int main() {
  for (int i = 0; i < 5; i++);
    std::cout << i;
  return 0;
}
''',
      'bug': 'Semicolon ends the for loop prematurely',
      'fix': 'Remove semicolon after for loop declaration',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int x = 5;
  int& ref;
  ref = x;
  std::cout << ref;
  return 0;
}
''',
      'bug': 'Reference must be initialized at declaration',
      'fix': 'Initialize reference during declaration: int& ref = x;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int numbers[5];
  numbers[5] = 10;
  std::cout << numbers[5];
  return 0;
}
''',
      'bug': 'Accessing array out of bounds (index 5 is invalid)',
      'fix': 'Use valid index within 0 to 4 for a 5-element array',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int a = 10;
  if (a > 5)
    std::cout << "Big"
  else
    std::cout << "Small";
  return 0;
}
''',
      'bug': 'Missing semicolon after std::cout << "Big"',
      'fix': 'Add semicolon after std::cout << "Big";',
    },
    {
      'code': '''
#include <iostream>

void display() {
  std::cout << "Display";
}

int main() {
  display;
  return 0;
}
''',
      'bug': 'Function display not called (missing parentheses)',
      'fix': 'Call function using display();',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << "Enter number: ";
  int x;
  std::cin >> x
  std::cout << "You entered: " << x;
  return 0;
}
''',
      'bug': 'Missing semicolon after std::cin >> x',
      'fix': 'Add semicolon after std::cin >> x;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  float a = 5.5;
  int b = a;
  std::cout << b;
  return 0;
}
''',
      'bug': 'Implicit float to int conversion causes truncation',
      'fix': 'Use explicit cast: int b = static_cast<int>(a);',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int x = 5;
  x++;
  std::cout << x << std::endl;
  ++;
  return 0;
}
''',
      'bug': 'Invalid standalone increment operator',
      'fix': 'Remove ++; line or apply it to a variable',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::string s;
  s = std::cin.getline();
  std::cout << s;
  return 0;
}
''',
      'bug': 'Incorrect usage of getline with std::cin',
      'fix': 'Use std::getline(std::cin, s);',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int num = 0;
  while (num < 5);
    std::cout << num++;
  return 0;
}
''',
      'bug': 'Semicolon terminates while loop before body',
      'fix': 'Remove semicolon after while (num < 5)',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int a = 10, b = 0;
  std::cout << "Result: " << a / b << std::endl;
  return 0;
}
''',
      'bug': 'Division by zero at runtime',
      'fix': 'Check if b is zero before division',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << "Value: " << std::to_string(123);
  return 0;
}
''',
      'bug': 'Missing #include <string> for std::to_string',
      'fix': 'Add #include <string> at the top',
    },
    {
      'code': '''
#include <iostream>

int main() {
  char c = 'Hello';
  std::cout << c;
  return 0;
}
''',
      'bug': 'Single quotes used for multi-character string',
      'fix': 'Use double quotes for strings or single character with single quotes',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << "Welcome" << std::endl
  return 0;
}
''',
      'bug': 'Missing semicolon after std::endl',
      'fix': 'Add semicolon after std::endl;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << "The answer is: " << 42
  return 0;
}
''',
      'bug': 'Missing semicolon after the output statement',
      'fix': 'Add semicolon after std::cout line',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int a = 5, b = 3;
  std::cout << "Sum: " << a + b << std::endl
  return 0;
}
''',
      'bug': 'Missing semicolon after std::endl',
      'fix': 'Add semicolon at the end of std::cout line',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int x = 0;
  if x == 0 {
    std::cout << "Zero";
  }
  return 0;
}
''',
      'bug': 'Missing parentheses around if condition',
      'fix': 'Add parentheses: if (x == 0)',
    },
    {
      'code': '''
#include <iostream>

int main() {
  for (int i = 0; i < 3; i++)
    std::cout << i << std::endl;
    std::cout << "Done";
  return 0;
}
''',
      'bug': '"Done" will always print due to lack of braces',
      'fix': 'Wrap both lines in braces if they should both repeat',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << "Hello\\nWorld";
  return 0;
}
''',
      'bug': 'Wrong escape sequence for newline',
      'fix': 'Use double backslash: \\\\n becomes \\n',
    },
    {
      'code': '''
#include <iostream>

int main() {
  char c = 'AB';
  std::cout << c;
  return 0;
}
''',
      'bug': 'Too many characters in single quotes',
      'fix': 'Use one character only: char c = \'A\';',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int* ptr;
  *ptr = 100;
  std::cout << *ptr;
  return 0;
}
''',
      'bug': 'Dereferencing an uninitialized pointer',
      'fix': 'Initialize pointer before use: int x = 100; int* ptr = &x;',
    },
    {
      'code': '''
#include <iostream>

void show(int x = );

int main() {
  show();
  return 0;
}

void show(int x) {
  std::cout << x;
}
''',
      'bug': 'Default parameter missing value',
      'fix': 'Set a default value: int x = 0;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int a = 2.5;
  std::cout << a;
  return 0;
}
''',
      'bug': 'Implicit conversion from float to int',
      'fix': 'Use float type: float a = 2.5;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << std::fixed << std::setprecision(2) << 3.14159;
  return 0;
}
''',
      'bug': 'Missing #include <iomanip> for manipulators',
      'fix': 'Add #include <iomanip> at the top',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int data[3] = {1, 2, 3};
  for (int i = 0; i <= 3; i++) {
    std::cout << data[i];
  }
  return 0;
}
''',
      'bug': 'Out-of-bounds array access at index 3',
      'fix': 'Change loop to i < 3;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int result = pow(2, 3);
  std::cout << result;
  return 0;
}
''',
      'bug': 'Missing #include <cmath> for pow() function',
      'fix': 'Add #include <cmath>',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int x = 5;
  std::cout << x << endl;
  return 0;
}
''',
      'bug': 'Missing std:: before endl',
      'fix': 'Use std::endl instead of endl',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int x = 1;
  if (x > 0);
    std::cout << "Positive";
  return 0;
}
''',
      'bug': 'Semicolon ends the if prematurely',
      'fix': 'Remove semicolon after if condition',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::string s = 'Hello';
  std::cout << s;
  return 0;
}
''',
      'bug': 'Using single quotes for string literal',
      'fix': 'Use double quotes: "Hello"',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int x = -5;
  if (abs(x) > 0)
    std::cout << "Non-zero";
  return 0;
}
''',
      'bug': 'Missing #include <cstdlib> for abs()',
      'fix': 'Add #include <cstdlib> at the top',
    },
    {
      'code': '''
#include <iostream>

int main() {
  float pi = 3.14159;
  std::cout << "Pi: " << std::setprecision(2) << pi;
  return 0;
}
''',
      'bug': 'Precision only works with std::fixed set',
      'fix': 'Add std::fixed before std::setprecision',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << "Total = " << 5 + ;
  return 0;
}
''',
      'bug': 'Incomplete arithmetic expression',
      'fix': 'Complete the expression, e.g., 5 + 3;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  char arr[5];
  std::cin >> arr;
  arr[5] = 'X';
  std::cout << arr;
  return 0;
}
''',
      'bug': 'Out-of-bounds write at arr[5]',
      'fix': 'Use indices 0 to 4 for a size-5 array',
    },
    {
      'code': '''
#include <iostream>

void sayHello() {
  std::cout << "Hello";
}

int main() {
  sayhello();
  return 0;
}
''',
      'bug': 'Function call uses wrong case (C++ is case-sensitive)',
      'fix': 'Use correct case: sayHello();',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::string s = "C++";
  std::cout << s[3];
  return 0;
}
''',
      'bug': 'Accessing character outside of string length',
      'fix': 'Ensure index is within bounds: 0 to s.length()-1',
    },
    {
      'code': '''
#include <iostream>

int main() {
  const int x = 10;
  x = 20;
  std::cout << x;
  return 0;
}
''',
      'bug': 'Trying to modify a const variable',
      'fix': 'Remove const if you need to modify x',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int a = 10, b = 0;
  if (b && a / b)
    std::cout << "Safe";
  return 0;
}
''',
      'bug': 'a / b will still evaluate if b != 0 isn’t checked first',
      'fix': 'Check b != 0 first: if (b != 0 && a / b)',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << "Sum is: " << (4 + 5 << std::endl;
  return 0;
}
''',
      'bug': 'Missing closing parenthesis',
      'fix': 'Fix to: "Sum is: " << (4 + 5) << std::endl;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  char ch = "A";
  std::cout << ch;
  return 0;
}
''',
      'bug': 'Incorrect assignment of string to char',
      'fix': 'Use single quotes: char ch = \'A\';',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int age;
  std::cin >> age;
  if (age > 18)
    std::cout << "Adult";
  else
    std::cout << Minor;
  return 0;
}
''',
      'bug': 'Missing quotes around string "Minor"',
      'fix': 'Use: std::cout << "Minor";',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int n;
  std::cin >> n;
  for (int i = 1; i <= n; ++i)
    std::cout << i;
  std::endl;
  return 0;
}
''',
      'bug': 'std::endl is not connected to std::cout',
      'fix': 'Change to std::cout << std::endl;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << "5" + 2;
  return 0;
}
''',
      'bug': 'String + int will result in pointer arithmetic',
      'fix': 'Convert 2 to string: "5" + std::to_string(2);',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::string name = "";
  if (name = "Admin")
    std::cout << "Welcome";
  return 0;
}
''',
      'bug': 'Assignment used instead of comparison',
      'fix': 'Use ==: if (name == "Admin")',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << "Result: ";
  return 0
}
''',
      'bug': 'Missing semicolon after return 0',
      'fix': 'Add semicolon: return 0;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  float result = 10 / 4;
  std::cout << result;
  return 0;
}
''',
      'bug': 'Integer division results in 2.0, not 2.5',
      'fix': 'Use float operands: result = 10.0 / 4;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int* ptr = new int[10];
  // some logic
  return 0;
}
''',
      'bug': 'Memory allocated but not deallocated',
      'fix': 'Add delete[] ptr; before return',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::string name;
  getline(name, std::cin);
  std::cout << name;
  return 0;
}
''',
      'bug': 'getline arguments in wrong order',
      'fix': 'Use std::getline(std::cin, name);',
    },
    {
      'code': '''
#include <iostream>

int main() {
  const int x = 10;
  x += 5;
  std::cout << x;
  return 0;
}
''',
      'bug': 'Modifying a const variable',
      'fix': 'Remove const if modification is needed',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int nums[] = {1, 2, 3};
  for (int i = 0; i <= 3; i++) {
    std::cout << nums[i];
  }
  return 0;
}
''',
      'bug': 'Accessing nums[3], which is out-of-bounds',
      'fix': 'Change condition to i < 3;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  float a = 5, b = 0;
  float result = a / b;
  std::cout << result;
  return 0;
}
''',
      'bug': 'Division by zero, even though float, is dangerous',
      'fix': 'Add check: if(b != 0) before division',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << "Hello World"
  return 0;
}
''',
      'bug': 'Missing semicolon after the output line',
      'fix': 'Add semicolon after "Hello World"',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int a = 10;
  std::cout << "Value of a is: ";
  std::cout << b;
  return 0;
}
''',
      'bug': 'Variable b is undeclared',
      'fix': 'Change b to a or declare b properly',
    },
    {
      'code': '''
#include <iostream>

void func() {
  int x = 10;
}
std::cout << x;
''',
      'bug': 'x is not accessible outside func() scope',
      'fix': 'Move std::cout << x; inside the function or pass x',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int x = 10;
  if (x > 5)
    std::cout << "Yes";
  else
    std::cout << "No"
  return 0;
}
''',
      'bug': 'Missing semicolon after std::cout << "No"',
      'fix': 'Add semicolon after "No"',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int i = 0;
  while (i < 3)
    std::cout << i;
    i++;
  return 0;
}
''',
      'bug': 'i++ is not inside the loop body',
      'fix': 'Use braces around loop body',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << 'Hello';
  return 0;
}
''',
      'bug': 'Using single quotes for string literal',
      'fix': 'Use double quotes: "Hello"',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int val = "100";
  std::cout << val;
  return 0;
}
''',
      'bug': 'Assigning string to int variable',
      'fix': 'Remove quotes or use stoi for conversion',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << 10 << 20 << 30
  return 0;
}
''',
      'bug': 'Missing semicolon after last output statement',
      'fix': 'Add semicolon after std::cout line',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int* p;
  std::cout << *p;
  return 0;
}
''',
      'bug': 'Dereferencing an uninitialized pointer',
      'fix': 'Initialize p before use',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::string word;
  std::cin >> word;
  if (word = "hello")
    std::cout << "Hi!";
  return 0;
}
''',
      'bug': 'Assignment instead of comparison in if',
      'fix': 'Use == instead of =',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int num;
  std::cout << "Enter number: ";
  std::cin << num;
  return 0;
}
''',
      'bug': 'Wrong operator used with cin',
      'fix': 'Use >> instead of << with std::cin',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << 2 * (3 + );
  return 0;
}
''',
      'bug': 'Incomplete expression',
      'fix': 'Complete the arithmetic operation: (3 + value)',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int a = 0;
  if (a == 1);
    std::cout << "One";
  return 0;
}
''',
      'bug': 'Semicolon after if condition breaks logic',
      'fix': 'Remove semicolon after if (a == 1)',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << std::setprecision(2) << 3.14159;
  return 0;
}
''',
      'bug': 'Precision not applied without fixed flag',
      'fix': 'Add std::fixed before std::setprecision',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int arr[3] = {1, 2, 3};
  std::cout << arr[3];
  return 0;
}
''',
      'bug': 'Index 3 is out of bounds',
      'fix': 'Change index to valid range: 0–2',
    },
    {
      'code': '''
#include <iostream>

int main() {
  char ch = "Z";
  std::cout << ch;
  return 0;
}
''',
      'bug': 'String assigned to char',
      'fix': 'Use single quotes for character: char ch = \'Z\';',
    },
    {
      'code': '''
#include <iostream>

void greet(std::string name = ) {
  std::cout << "Hello " << name;
}

int main() {
  greet();
  return 0;
}
''',
      'bug': 'Default parameter missing',
      'fix': 'Add default value: name = "Guest"',
    },
    {
      'code': '''
#include <iostream>

int main() {
  float result = 10 / 4;
  std::cout << result;
  return 0;
}
''',
      'bug': 'Integer division result stored in float',
      'fix': 'Use float operands: 10.0 / 4 or (float)10 / 4',
    },
    {
      'code': '''
#include <iostream>

int main() {
  int a = 5;
  int b = 0;
  int res = a / b;
  std::cout << res;
  return 0;
}
''',
      'bug': 'Division by zero error',
      'fix': 'Check b != 0 before performing division',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << "Value: " << 5 + ;
  return 0;
}
''',
      'bug': 'Incomplete arithmetic expression',
      'fix': 'Complete with another value: 5 + 2;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << 3 << 2 << std::endl
  return 0;
}
''',
      'bug': 'Missing semicolon after std::cout line',
      'fix': 'Add semicolon after std::endl;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::string name = Hello;
  std::cout << name;
  return 0;
}
''',
      'bug': 'Missing double quotes around string',
      'fix': 'Use: std::string name = "Hello";',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << 'H' + 'i';
  return 0;
}
''',
      'bug': 'Adding char values gives int result',
      'fix': 'Use std::string: "H" + std::string("i")',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << std::endl << std::flush
  return 0;
}
''',
      'bug': 'Missing semicolon',
      'fix': 'Add semicolon after std::flush;',
    },
    {
      'code': '''
#include <iostream>

int main() {
  std::cout << 5 << "\n";
  return 0;
}
''',
      'bug': 'No actual bug — trick question',
      'fix': 'No fix needed',
    },
    {
      'code': '''
#include <iostream>

int main() {
  char c = 'Z';
  std::cout << "Char: " << c << std::endl
  return 0;
}
''',
      'bug': 'Missing semicolon after std::endl',
      'fix': 'Add semicolon at end of line',
    },

    // Add more debugging challenges here...
    // 👉 Paste your debugging questions here as maps with 'code', 'bug', and 'fix'
  ];

  late List<Map<String, String>> _debugChallenges;
  int _currentIndex = 0;
  String? _userFix;
  String? _feedbackMessage;

  Timer? _timer;
  int _maxTime = 20;
  int _remainingTime = 20;
  int _correctCount = 0;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _debugChallenges = _getRandomChallenges(10);
    _initializeNotifications();
    _startTimer();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'code_maze_channel',
      'CodeMaze Alerts',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      '🎯 Challenge Complete!',
      'You solved today\'s puzzle — great job!',
      notificationDetails,
    );
  }

  List<Map<String, String>> _getRandomChallenges(int count) {
    final random = Random();
    final shuffled = List<Map<String, String>>.from(_allDebugChallenges)..shuffle(random);
    return shuffled.take(count).toList();
  }

  void _startTimer() {
    _timer?.cancel();
    _remainingTime = _maxTime;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime <= 0) {
        timer.cancel();
        _goToNextChallenge();
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  void _checkFix() {
    if (_userFix == null || _userFix!.isEmpty) {
      setState(() {
        _feedbackMessage = 'Please enter your fix.';
      });
      return;
    }

    final correctFix = _debugChallenges[_currentIndex]['fix']!.toLowerCase();
    final userInput = _userFix!.toLowerCase();

    setState(() {
      if (userInput.contains(correctFix)) {
        _feedbackMessage = 'Correct fix! 🎉';
        _correctCount++;
        _goToNextChallenge();
      } else {
        _feedbackMessage = 'Incorrect fix. Try again.';
      }
    });
  }

  void _goToNextChallenge() {
    _userFix = null;
    _feedbackMessage = null;
    if (_currentIndex < _debugChallenges.length - 1) {
      setState(() {
        _currentIndex++;
        _startTimer();
      });
    } else {
      _timer?.cancel();
      _showFinalScore();
    }
  }

  void _showFinalScore() async {
    if (_correctCount >= 5) {
      await _showNotification(); // Trigger real local notification
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Debugging Game Complete'),
        content: Text('Great job! You fixed $_correctCount / ${_debugChallenges.length} bugs.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 0;
                _userFix = null;
                _feedbackMessage = null;
                _correctCount = 0;
                _debugChallenges = _getRandomChallenges(10);
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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final challenge = _debugChallenges[_currentIndex];
    final progress = _remainingTime / _maxTime;

    return Scaffold(
      appBar: AppBar(title: const Text('Debugging Game')),
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
            const Text('Find the bug and provide a fix:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  challenge['code'] ?? '',
                  style: const TextStyle(fontFamily: 'Courier', fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Your Fix',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: (val) => _userFix = val,
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _checkFix, child: const Text('Submit Fix')),
            if (_feedbackMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                _feedbackMessage!,
                style: TextStyle(
                  color: _feedbackMessage == 'Correct fix! 🎉' ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
