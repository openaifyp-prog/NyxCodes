import '../models/puzzle.dart';

final List<Puzzle> puzzleList = [
  Puzzle(
    id: 1,
    category: 'Introduction',
    title: 'Hello World Output',
    description: 'Write a program that prints "Hello, World!" to the console.',
    hint: 'Use std::cout and include <iostream> header.',
    solution: '''
#include <iostream>
int main() {
    std::cout << "Hello, World!" << std::endl;
    return 0;
}
''',
    correctAnswers: ['Hello, World!', 'Hello World', 'hello, world!', 'hello world'],
    difficulty: 'Easy',
  ),
  Puzzle(
    id: 2,
    category: 'Variables',
    title: 'Variable Declaration',
    description: 'Declare an integer variable named "count" and assign it the value 10.',
    hint: 'Use int type and assignment operator.',
    solution: '''
int count = 10;
''',
    correctAnswers: ['int count = 10;', 'count = 10;', 'int count=10;'],
    difficulty: 'Easy',
  ),
  Puzzle(
    id: 3,
    category: 'Loops',
    title: 'For Loop Output',
    description: 'Write a for loop that prints numbers from 0 to 4 inclusive.',
    hint: 'Use for(int i = 0; i < 5; i++) and std::cout.',
    solution: '''
#include <iostream>
int main() {
    for(int i = 0; i < 5; i++) {
        std::cout << i << std::endl;
    }
    return 0;
}
''',
    correctAnswers: ['0 1 2 3 4', '0\n1\n2\n3\n4\n'],
    difficulty: 'Medium',
  ),
  Puzzle(
    id: 4,
    category: 'Functions',
    title: 'Simple Function',
    description: 'Write a function named greet that prints "Hello!" to the console.',
    hint: 'Use void return type and std::cout.',
    solution: '''
#include <iostream>
void greet() {
    std::cout << "Hello!" << std::endl;
}
int main() {
    greet();
    return 0;
}
''',
    correctAnswers: ['Hello!', 'Hello!\n'],
    difficulty: 'Medium',
  ),
  Puzzle(
    id: 5,
    category: 'Control Flow',
    title: 'If Statement',
    description: 'Write an if statement that prints "Positive" if an integer x is greater than 0.',
    hint: 'Use if(x > 0) and std::cout.',
    solution: '''
#include <iostream>
int main() {
    int x = 5;
    if(x > 0) {
        std::cout << "Positive" << std::endl;
    }
    return 0;
}
''',
    correctAnswers: ['Positive', 'Positive\n'],
    difficulty: 'Easy',
  ),
  Puzzle(
    id: 6,
    category: 'Functions',
    title: 'Function Parameters',
    description: 'Write a function that takes two integers and returns their product.',
    hint: 'Use parameters and return keyword.',
    solution: '''
int multiply(int a, int b) {
    return a * b;
}
''',
    correctAnswers: ['product', 'a*b', 'a * b', 'multiply(a, b)'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 7,
    category: 'Object-Oriented Programming',
    title: 'Class Declaration',
    description: 'Declare a class named Car with a string attribute brand.',
    hint: 'Use class keyword and public access.',
    solution: '''
class Car {
public:
    std::string brand;
};
''',
    correctAnswers: ['class Car', 'Car class', 'brand string'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 8,
    category: 'Object-Oriented Programming',
    title: 'Constructor Usage',
    description: 'Write a constructor for Car that sets the brand attribute.',
    hint: 'Use initializer list or assignment inside constructor.',
    solution: '''
class Car {
public:
    std::string brand;
    Car(std::string b) : brand(b) {}
};
''',
    correctAnswers: ['constructor', 'Car(std::string b)', 'brand initialization'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 9,
    category: 'Inheritance',
    title: 'Basic Inheritance',
    description: 'Create a class SportsCar that inherits from Car.',
    hint: 'Use : public Car',
    solution: '''
class SportsCar : public Car {
public:
    int maxSpeed;
};
''',
    correctAnswers: ['inheritance', 'SportsCar : public Car', 'derived class'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 10,
    category: 'Loops',
    title: 'While Loop Behavior',
    description: 'How many times will this loop execute?',
    hint: 'count starts at 0 and increments till less than 3.',
    solution: '''
int count = 0;
while(count < 3) {
    count++;
}
''',
    correctAnswers: ['3', 'three'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 11,
    category: 'Arrays',
    title: 'Array Initialization',
    description: 'Initialize an integer array of size 5 with values 1 to 5.',
    hint: 'Use int arr[5] = {1, 2, 3, 4, 5};',
    solution: '''
int arr[5] = {1, 2, 3, 4, 5};
''',
    correctAnswers: ['int arr[5]', 'array of 5 ints', '{1,2,3,4,5}'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 12,
    category: 'Pointers',
    title: 'Pointer Declaration',
    description: 'Declare a pointer to an integer and assign it the address of an int variable.',
    hint: 'Use * and & operators.',
    solution: '''
int x = 10;
int* ptr = &x;
''',
    correctAnswers: ['int* ptr', '&x', 'pointer to int'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 13,
    category: 'Pointers',
    title: 'Dereferencing Pointer',
    description: 'How to access the value pointed to by a pointer ptr?',
    hint: 'Use *ptr',
    solution: '''
int value = *ptr;
''',
    correctAnswers: ['*ptr', 'dereference', 'value at ptr'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 14,
    category: 'Control Flow',
    title: 'Switch Default Case',
    description: 'What happens if no case matches in a switch statement with a default case?',
    hint: 'default block executes',
    solution: '''
switch (value) {
    case 1:
        break;
    default:
        // code here executes if no case matches
        break;
}
''',
    correctAnswers: ['default case executes', 'default block', 'no match case'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 15,
    category: 'Strings',
    title: 'String Concatenation',
    description: 'Concatenate two std::string objects: firstName and lastName.',
    hint: 'Use + operator',
    solution: '''
std::string fullName = firstName + " " + lastName;
''',
    correctAnswers: ['+', 'concatenation', 'fullName'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 16,
    category: 'Templates',
    title: 'Template Function',
    description: 'Write a function template that returns the maximum of two values.',
    hint: 'Use template<typename T>',
    solution: '''
template <typename T>
T max(T a, T b) {
    return (a > b) ? a : b;
}
''',
    correctAnswers: ['template', 'max function', 'generic function'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 17,
    category: 'Exception Handling',
    title: 'Throw Exception',
    description: 'Throw a runtime_error exception with a message.',
    hint: 'Use throw keyword and stdexcept header.',
    solution: '''
#include <stdexcept>
throw std::runtime_error("Error occurred");
''',
    correctAnswers: ['throw', 'runtime_error', 'exception'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 18,
    category: 'File Handling',
    title: 'Open File for Writing',
    description: 'Open a file named "output.txt" for writing using std::ofstream.',
    hint: 'Include fstream header.',
    solution: '''
#include <fstream>
std::ofstream out("output.txt");
''',
    correctAnswers: ['ofstream', 'open file', 'write file'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 19,
    category: 'Standard Library',
    title: 'Use std::vector',
    description: 'Create a vector of integers and add elements 1, 2, and 3.',
    hint: 'Use push_back method.',
    solution: '''
#include <vector>
std::vector<int> v;
v.push_back(1);
v.push_back(2);
v.push_back(3);
''',
    correctAnswers: ['vector', 'push_back', 'dynamic array'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 20,
    category: 'Memory Management',
    title: 'Delete Pointer',
    description: 'Delete a dynamically allocated int pointer p.',
    hint: 'Use delete keyword.',
    solution: '''
int* p = new int(5);
delete p;
''',
    correctAnswers: ['delete', 'free memory', 'pointer'],
    difficulty: 'Medium',
  ),
  Puzzle(
    id: 21,
    category: 'Memory Management',
    title: 'Smart Pointer Usage',
    description: 'Create a std::unique_ptr to manage an int with value 10.',
    hint: 'Use std::make_unique<int>(10)',
    solution: '''
#include <memory>
auto p = std::make_unique<int>(10);
''',
    correctAnswers: ['unique_ptr', 'make_unique', 'smart pointer'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 22,
    category: 'STL',
    title: 'Using std::map',
    description: 'Create a map to associate string keys with integer values.',
    hint: 'Use std::map<std::string, int>',
    solution: '''
#include <map>
std::map<std::string, int> ages;
ages["Alice"] = 30;
ages["Bob"] = 25;
''',
    correctAnswers: ['map', 'key-value', 'associative container'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 23,
    category: 'STL',
    title: 'Iterators',
    description: 'Use an iterator to print elements of a std::vector<int>.',
    hint: 'Use vector.begin() and vector.end()',
    solution: '''
#include <iostream>
#include <vector>

std::vector<int> v = {1, 2, 3};
for (auto it = v.begin(); it != v.end(); ++it) {
    std::cout << *it << " ";
}
''',
    correctAnswers: ['iterator', 'begin', 'end', '*it'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 24,
    category: 'Templates',
    title: 'Class Template',
    description: 'Define a template class Pair with two members.',
    hint: 'Use template<typename T>',
    solution: '''
template <typename T>
class Pair {
public:
    T first, second;
    Pair(T a, T b) : first(a), second(b) {}
};
''',
    correctAnswers: ['template', 'class Pair', 'generic class'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 25,
    category: 'Multithreading',
    title: 'Thread Creation',
    description: 'Create and start a thread that runs a function sayHello.',
    hint: 'Use std::thread and join()',
    solution: '''
#include <thread>
#include <iostream>

void sayHello() {
    std::cout << "Hello from thread!" << std::endl;
}

int main() {
    std::thread t(sayHello);
    t.join();
}
''',
    correctAnswers: ['thread', 'std::thread', 'join'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 26,
    category: 'Exception Handling',
    title: 'Catch Multiple Exceptions',
    description: 'Write try-catch blocks to catch std::runtime_error and std::exception.',
    hint: 'Use multiple catch clauses',
    solution: '''
try {
    // code that may throw
} catch (const std::runtime_error& e) {
    // handle runtime_error
} catch (const std::exception& e) {
    // handle other exceptions
}
''',
    correctAnswers: ['try', 'catch', 'exception handling'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 27,
    category: 'File Handling',
    title: 'Read File Line by Line',
    description: 'Read a file "input.txt" line by line and print each line.',
    hint: 'Use std::ifstream and std::getline',
    solution: '''
#include <fstream>
#include <iostream>
#include <string>

std::ifstream infile("input.txt");
std::string line;
while (std::getline(infile, line)) {
    std::cout << line << std::endl;
}
''',
    correctAnswers: ['ifstream', 'getline', 'read file'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 28,
    category: 'Standard Library',
    title: 'Using std::set',
    description: 'Create a std::set and insert elements 5, 3, 7.',
    hint: 'Use insert() method',
    solution: '''
#include <set>
std::set<int> s;
s.insert(5);
s.insert(3);
s.insert(7);
''',
    correctAnswers: ['set', 'insert', 'unique sorted'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 29,
    category: 'Pointers',
    title: 'Null Pointer Check',
    description: 'Check if a pointer ptr is null before dereferencing.',
    hint: 'Use if(ptr != nullptr)',
    solution: '''
if (ptr != nullptr) {
    // safe to dereference
    int value = *ptr;
}
''',
    correctAnswers: ['nullptr', 'null check', 'pointer safety'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 30,
    category: 'Control Flow',
    title: 'For Loop with Continue',
    description: 'Write a for loop from 0 to 5 skipping 3 using continue.',
    hint: 'Use continue inside loop',
    solution: '''
for (int i = 0; i <= 5; i++) {
    if (i == 3) continue;
    std::cout << i << " ";
}
''',
    correctAnswers: ['continue', 'skip', 'for loop'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 31,
    category: 'Variables & Data Types',
    title: 'Declare a Boolean',
    description: 'Declare a boolean variable isReady and set it true.',
    hint: 'Use bool keyword',
    solution: '''
bool isReady = true;
''',
    correctAnswers: ['bool', 'boolean', 'isReady'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 32,
    category: 'Functions',
    title: 'Return Statement',
    description: 'Write a function that returns an integer 10.',
    hint: 'Use return keyword',
    solution: '''
int getTen() {
    return 10;
}
''',
    correctAnswers: ['return', 'int', 'function'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 33,
    category: 'Loops',
    title: 'Do-While Loop',
    description: 'Write a do-while loop that prints numbers 1 to 3.',
    hint: 'Use do and while syntax',
    solution: '''
int i = 1;
do {
    std::cout << i << std::endl;
    i++;
} while (i <= 3);
''',
    correctAnswers: ['do', 'while', 'loop'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 34,
    category: 'Standard Library',
    title: 'Use std::string Methods',
    description: 'Use the length() method of std::string.',
    hint: 'Use str.length()',
    solution: '''
std::string str = "CodeMaze";
int len = str.length();
''',
    correctAnswers: ['length', 'std::string', 'string methods'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 35,
    category: 'Advanced Topics',
    title: 'Lambda Capture by Value',
    description: 'Write a lambda that captures variable x by value and prints it.',
    hint: 'Use [x] in lambda capture list',
    solution: '''
int x = 10;
auto printX = [x]() {
    std::cout << x << std::endl;
};
printX();
''',
    correctAnswers: ['lambda', 'capture by value', '[x]'],
    difficulty: 'Hard',
  ),
  Puzzle(
    id: 36,
    category: 'Object-Oriented Programming',
    title: 'Define a Class',
    description: 'Define a class named Animal with a public method speak().',
    hint: 'Use class keyword and public access specifier',
    solution: '''
class Animal {
public:
    void speak() {
        std::cout << "Animal speaks" << std::endl;
    }
};
''',
    correctAnswers: ['class', 'Animal', 'public', 'speak'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 37,
    category: 'Object-Oriented Programming',
    title: 'Inheritance Basics',
    description: 'Create a class Dog that inherits from Animal.',
    hint: 'Use : public Animal',
    solution: '''
class Dog : public Animal {
public:
    void speak() {
        std::cout << "Dog barks" << std::endl;
    }
};
''',
    correctAnswers: ['inheritance', 'public', 'Dog', 'Animal'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 38,
    category: 'Object-Oriented Programming',
    title: 'Virtual Functions',
    description: 'Make speak() a virtual function in base class.',
    hint: 'Use virtual keyword',
    solution: '''
class Animal {
public:
    virtual void speak() {
        std::cout << "Animal speaks" << std::endl;
    }
};
''',
    correctAnswers: ['virtual', 'function', 'base class'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 39,
    category: 'Templates',
    title: 'Function Template',
    description: 'Write a template function to return the maximum of two values.',
    hint: 'Use template<typename T>',
    solution: '''
template <typename T>
T max(T a, T b) {
    return (a > b) ? a : b;
}
''',
    correctAnswers: ['template', 'function', 'max'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 40,
    category: 'Exception Handling',
    title: 'Throw Exception',
    description: 'Throw a std::runtime_error with message "Error occurred".',
    hint: 'Use throw keyword',
    solution: '''
#include <stdexcept>
throw std::runtime_error("Error occurred");
''',
    correctAnswers: ['throw', 'runtime_error', 'exception'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 41,
    category: 'File Handling',
    title: 'Write to a File',
    description: 'Write "Hello File" to a file named output.txt.',
    hint: 'Use std::ofstream',
    solution: '''
#include <fstream>
std::ofstream outfile("output.txt");
outfile << "Hello File";
outfile.close();
''',
    correctAnswers: ['ofstream', 'write', 'file'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 42,
    category: 'STL',
    title: 'Using std::vector Push_back',
    description: 'Add elements 10, 20, 30 to a vector.',
    hint: 'Use push_back method',
    solution: '''
#include <vector>
std::vector<int> v;
v.push_back(10);
v.push_back(20);
v.push_back(30);
''',
    correctAnswers: ['vector', 'push_back'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 43,
    category: 'Pointers',
    title: 'Pointer Arithmetic',
    description: 'Increment a pointer to next integer.',
    hint: 'Use ptr++',
    solution: '''
int arr[] = {1,2,3};
int* ptr = arr;
ptr++;
''',
    correctAnswers: ['pointer', 'arithmetic', 'increment'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 44,
    category: 'Control Flow',
    title: 'While Loop',
    description: 'Write a while loop that prints numbers 1 to 5.',
    hint: 'Use while(condition)',
    solution: '''
int i = 1;
while(i <= 5) {
    std::cout << i << std::endl;
    i++;
}
''',
    correctAnswers: ['while', 'loop'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 45,
    category: 'Functions',
    title: 'Function Overloading',
    description: 'Define two functions named add: one for int, one for double.',
    hint: 'Same name, different parameters',
    solution: '''
int add(int a, int b) { return a + b; }
double add(double a, double b) { return a + b; }
''',
    correctAnswers: ['function overloading', 'add', 'int', 'double'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 46,
    category: 'Loops',
    title: 'Range-based For Loop',
    description: 'Use range-based for to print elements of an int array.',
    hint: 'Use for(auto elem : array)',
    solution: '''
int arr[] = {1, 2, 3};
for (auto elem : arr) {
    std::cout << elem << std::endl;
}
''',
    correctAnswers: ['range-based for', 'loop', 'auto'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 47,
    category: 'Standard Library',
    title: 'std::string Concatenation',
    description: 'Concatenate two strings using + operator.',
    hint: 'Use + operator',
    solution: '''
std::string s1 = "Hello, ";
std::string s2 = "World!";
std::string s3 = s1 + s2;
''',
    correctAnswers: ['string', 'concatenation', '+ operator'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 48,
    category: 'Advanced Topics',
    title: 'Move Constructor',
    description: 'Define a move constructor for a class Buffer.',
    hint: 'Use && and std::move',
    solution: '''
class Buffer {
public:
    Buffer(Buffer&& other) {
        // move data
    }
};
''',
    correctAnswers: ['move constructor', 'std::move', '&&'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 49,
    category: 'Memory Management',
    title: 'Delete Pointer',
    description: 'Delete a dynamically allocated int pointer.',
    hint: 'Use delete keyword',
    solution: '''
int* p = new int(5);
delete p;
''',
    correctAnswers: ['delete', 'pointer', 'memory management'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 50,
    category: 'File Handling',
    title: 'Open File in Binary Mode',
    description: 'Open a file in binary mode for writing.',
    hint: 'Use std::ios::binary',
    solution: '''
std::ofstream file("data.bin", std::ios::binary);
''',
    correctAnswers: ['ofstream', 'binary mode'],
    difficulty: 'Medium',
  ),
  Puzzle(
    id: 51,
    category: 'Control Flow',
    title: 'Ternary Operator',
    description: 'Use the ternary operator to assign a value based on a condition.',
    hint: 'condition ? expr1 : expr2',
    solution: '''
int x = 10;
int y = (x > 5) ? 100 : 200;
''',
    correctAnswers: ['ternary', '?:', 'conditional operator'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 52,
    category: 'STL',
    title: 'Using std::queue',
    description: 'Create a queue and enqueue, dequeue elements.',
    hint: 'Include <queue>',
    solution: '''
#include <queue>
#include <iostream>

std::queue<int> q;
q.push(1);
q.push(2);
q.pop();
std::cout << q.front() << std::endl;
''',
    correctAnswers: ['queue', 'enqueue', 'dequeue'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 53,
    category: 'Templates',
    title: 'Variadic Templates',
    description: 'Write a variadic template function to sum numbers.',
    hint: 'Use template<typename... Args>',
    solution: '''
template<typename T>
T sum(T t) {
  return t;
}

template<typename T, typename... Args>
T sum(T first, Args... args) {
  return first + sum(args...);
}
''',
    correctAnswers: ['variadic template', 'sum', 'template pack'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 54,
    category: 'File Handling',
    title: 'Append to File',
    description: 'Open a file in append mode and write text.',
    hint: 'Use std::ios::app',
    solution: '''
#include <fstream>

std::ofstream outfile("log.txt", std::ios::app);
outfile << "Appending new line" << std::endl;
outfile.close();
''',
    correctAnswers: ['append', 'ofstream', 'ios::app'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 55,
    category: 'Memory Management',
    title: 'Shared Pointer',
    description: 'Create and use a std::shared_ptr.',
    hint: 'Include <memory>',
    solution: '''
#include <memory>
#include <iostream>

std::shared_ptr<int> p1 = std::make_shared<int>(42);
std::cout << *p1 << std::endl;
''',
    correctAnswers: ['shared_ptr', 'make_shared', 'memory management'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 56,
    category: 'Functions',
    title: 'Lambda Capture by Value',
    description: 'Capture local variables by value in a lambda.',
    hint: '[=]',
    solution: '''
int x = 10;
auto f = [=]() { return x + 5; };
''',
    correctAnswers: ['lambda', 'capture', 'by value'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 57,
    category: 'Loops',
    title: 'Do-While Loop',
    description: 'Write a do-while loop to print numbers 1 to 3.',
    hint: 'Use do { } while(condition);',
    solution: '''
int i = 1;
do {
    std::cout << i << std::endl;
    i++;
} while (i <= 3);
''',
    correctAnswers: ['do-while', 'loop', 'print'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 58,
    category: 'Object-Oriented Programming',
    title: 'Virtual Destructor',
    description: 'Why use virtual destructor in base class?',
    hint: 'Ensure derived class destructor is called',
    solution: 'Virtual destructors ensure proper cleanup of derived objects when deleted via base class pointers.',
    correctAnswers: ['virtual destructor', 'cleanup', 'derived class'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 59,
    category: 'STL',
    title: 'Using std::stack',
    description: 'Push and pop elements on a stack.',
    hint: 'Include <stack>',
    solution: '''
#include <stack>
#include <iostream>

std::stack<int> s;
s.push(10);
s.push(20);
s.pop();
std::cout << s.top() << std::endl;
''',
    correctAnswers: ['stack', 'push', 'pop'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 60,
    category: 'Advanced Topics',
    title: 'constexpr Functions',
    description: 'Write a constexpr function to compute factorial.',
    hint: 'Use constexpr keyword',
    solution: '''
constexpr int factorial(int n) {
    return n <= 1 ? 1 : n * factorial(n - 1);
}
''',
    correctAnswers: ['constexpr', 'function', 'factorial'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 61,
    category: 'Variables & Data Types',
    title: 'Enumerations',
    description: 'Define and use an enum for days of the week.',
    hint: 'Use enum keyword',
    solution: '''
enum Day {Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday};
Day today = Monday;
''',
    correctAnswers: ['enum', 'enumeration', 'days'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 62,
    category: 'Control Flow',
    title: 'Goto Statement',
    description: 'Use goto to jump to a label.',
    hint: 'Use label and goto',
    solution: '''
int i = 0;
start:
std::cout << i << std::endl;
i++;
if (i < 3) goto start;
''',
    correctAnswers: ['goto', 'label', 'jump'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 63,
    category: 'Templates',
    title: 'Template Alias',
    description: 'Create a template alias for a vector of a given type.',
    hint: 'Use using keyword',
    solution: '''
template<typename T>
using Vec = std::vector<T>;
''',
    correctAnswers: ['template alias', 'using', 'vector'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 64,
    category: 'Exception Handling',
    title: 'Nested Try-Catch',
    description: 'Write nested try-catch blocks to handle exceptions.',
    hint: 'Use try inside try',
    solution: '''
try {
    try {
        throw std::runtime_error("Error");
    } catch (...) {
        std::cout << "Inner catch" << std::endl;
    }
} catch (...) {
    std::cout << "Outer catch" << std::endl;
}
''',
    correctAnswers: ['try', 'catch', 'exception'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 65,
    category: 'File Handling',
    title: 'Check if File Exists',
    description: 'Check if a file exists before opening it.',
    hint: 'Use std::ifstream and .good()',
    solution: '''
#include <fstream>

std::ifstream file("test.txt");
if (file.good()) {
    // file exists
}
file.close();
''',
    correctAnswers: ['file exists', 'ifstream', 'good'],
    difficulty: 'Medium',
  ),
  Puzzle(
    id: 66,
    category: 'Standard Library',
    title: 'Using std::array',
    description: 'Declare and initialize a fixed-size array.',
    hint: 'Include <array>',
    solution: '''
#include <array>
#include <iostream>

std::array<int, 3> arr = {1, 2, 3};
for (int n : arr) {
    std::cout << n << " ";
}
std::cout << std::endl;
''',
    correctAnswers: ['array', 'std::array', 'fixed size'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 67,
    category: 'Memory Management',
    title: 'Unique Pointer',
    description: 'Create and use a std::unique_ptr.',
    hint: 'Include <memory>',
    solution: '''
#include <memory>
#include <iostream>

std::unique_ptr<int> p = std::make_unique<int>(10);
std::cout << *p << std::endl;
''',
    correctAnswers: ['unique_ptr', 'make_unique', 'memory management'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 68,
    category: 'Functions',
    title: 'Default Parameters',
    description: 'Use default parameter values in functions.',
    hint: 'Specify default values in function declaration',
    solution: '''
#include <iostream>

void greet(std::string name = "User") {
    std::cout << "Hello, " << name << "!" << std::endl;
}

int main() {
    greet();
    greet("Alice");
}
''',
    correctAnswers: ['default parameters', 'function', 'default argument'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 69,
    category: 'Loops',
    title: 'Range-based For Loop',
    description: 'Use range-based for loop to iterate over an array.',
    hint: 'Use for(type var : collection)',
    solution: '''
#include <iostream>

int arr[] = {1, 2, 3, 4, 5};
for (int num : arr) {
    std::cout << num << " ";
}
std::cout << std::endl;
''',
    correctAnswers: ['range-based for', 'for each', 'loop'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 70,
    category: 'Object-Oriented Programming',
    title: 'Operator Overloading',
    description: 'Overload the + operator for a complex number class.',
    hint: 'Use operator+ function',
    solution: '''
#include <iostream>

class Complex {
public:
    double real, imag;
    Complex(double r, double i) : real(r), imag(i) {}
    Complex operator+(const Complex& other) {
        return Complex(real + other.real, imag + other.imag);
    }
    void display() {
        std::cout << real << " + " << imag << "i" << std::endl;
    }
};

int main() {
    Complex c1(1.0, 2.0), c2(3.0, 4.0);
    Complex c3 = c1 + c2;
    c3.display();
}
''',
    correctAnswers: ['operator overloading', 'operator+', 'complex'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 71,
    category: 'Advanced Topics',
    title: 'Type Aliases',
    description: 'Create an alias for long type names using using keyword.',
    hint: 'using alias = type;',
    solution: '''
using uint = unsigned int;
uint x = 10;
''',
    correctAnswers: ['type alias', 'using', 'alias'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 72,
    category: 'Templates',
    title: 'Class Template Specialization',
    description: 'Specialize a class template for type int.',
    hint: 'Use template<> specialization syntax',
    solution: '''
template<typename T>
class MyClass {
public:
    void display() {
        std::cout << "Generic template" << std::endl;
    }
};

template<>
class MyClass<int> {
public:
    void display() {
        std::cout << "Specialized for int" << std::endl;
    }
};

int main() {
    MyClass<double> obj1;
    obj1.display();
    MyClass<int> obj2;
    obj2.display();
}
''',
    correctAnswers: ['template specialization', 'class template', 'specialization'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 73,
    category: 'Exception Handling',
    title: 'Throwing Exceptions',
    description: 'Throw a runtime_error exception.',
    hint: 'Use throw keyword',
    solution: '''
#include <stdexcept>

void test(int val) {
    if (val < 0)
        throw std::runtime_error("Negative value");
}
''',
    correctAnswers: ['throw', 'exception', 'runtime_error'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 74,
    category: 'File Handling',
    title: 'Read File Line by Line',
    description: 'Read a text file line by line using ifstream.',
    hint: 'Use std::getline',
    solution: '''
#include <fstream>
#include <iostream>
#include <string>

int main() {
    std::ifstream file("test.txt");
    std::string line;
    while (std::getline(file, line)) {
        std::cout << line << std::endl;
    }
    file.close();
}
''',
    correctAnswers: ['getline', 'ifstream', 'read file'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 75,
    category: 'Standard Library',
    title: 'Using std::find',
    description: 'Find an element in a vector using std::find.',
    hint: 'Include <algorithm>',
    solution: '''
#include <vector>
#include <algorithm>
#include <iostream>

int main() {
    std::vector<int> v = {1, 2, 3, 4};
    auto it = std::find(v.begin(), v.end(), 3);
    if (it != v.end()) {
        std::cout << "Found 3" << std::endl;
    }
}
''',
    correctAnswers: ['find', 'algorithm', 'vector'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 76,
    category: 'Memory Management',
    title: 'Weak Pointer',
    description: 'Create and use a std::weak_ptr to avoid cyclic references.',
    hint: 'Include <memory>',
    solution: '''
#include <memory>
#include <iostream>

std::shared_ptr<int> sp = std::make_shared<int>(10);
std::weak_ptr<int> wp = sp;
if (auto spt = wp.lock()) {
    std::cout << *spt << std::endl;
}
''',
    correctAnswers: ['weak_ptr', 'shared_ptr', 'memory'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 77,
    category: 'Functions',
    title: 'Recursive Function',
    description: 'Write a recursive function to compute Fibonacci numbers.',
    hint: 'Function calls itself',
    solution: '''
int fibonacci(int n) {
    if (n <= 1) return n;
    return fibonacci(n-1) + fibonacci(n-2);
}
''',
    correctAnswers: ['recursive', 'fibonacci', 'function'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 78,
    category: 'Loops',
    title: 'Break Statement',
    description: 'Use break to exit a loop early.',
    hint: 'Use break inside loop',
    solution: '''
for (int i = 0; i < 10; i++) {
    if (i == 5)
        break;
    std::cout << i << std::endl;
}
''',
    correctAnswers: ['break', 'loop', 'exit'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 79,
    category: 'Object-Oriented Programming',
    title: 'Abstract Classes',
    description: 'Define an abstract class with a pure virtual function.',
    hint: 'Use =0 in function declaration',
    solution: '''
class Shape {
public:
    virtual void draw() = 0; // pure virtual function
};

class Circle : public Shape {
public:
    void draw() override {
        std::cout << "Drawing circle" << std::endl;
    }
};
''',
    correctAnswers: ['abstract class', 'pure virtual', 'override'],
    difficulty: 'Hard',
  ),
  Puzzle(
    id: 80,
    category: 'Advanced Topics',
    title: 'Mutex Locking',
    description: 'Use std::mutex to synchronize threads.',
    hint: 'Include <mutex>',
    solution: '''
#include <iostream>
#include <thread>
#include <mutex>

std::mutex mtx;
int counter = 0;

void increment() {
    for (int i = 0; i < 1000; ++i) {
        std::lock_guard<std::mutex> lock(mtx);
        ++counter;
    }
}

int main() {
    std::thread t1(increment);
    std::thread t2(increment);
    t1.join();
    t2.join();
    std::cout << "Counter: " << counter << std::endl;
}
''',
    correctAnswers: ['mutex', 'lock_guard', 'thread synchronization'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 81,
    category: 'Memory Management',
    title: 'Dynamic Array Allocation',
    description: 'Allocate and free a dynamic array.',
    hint: 'Use new and delete[]',
    solution: '''
#include <iostream>

int main() {
    int* arr = new int[5]{1,2,3,4,5};
    for (int i = 0; i < 5; ++i) {
        std::cout << arr[i] << " ";
    }
    std::cout << std::endl;
    delete[] arr;
}
''',
    correctAnswers: ['dynamic allocation', 'new', 'delete'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 82,
    category: 'Templates',
    title: 'Variadic Templates',
    description: 'Use variadic templates for functions.',
    hint: 'Use template<typename... Args>',
    solution: '''
#include <iostream>

template<typename T>
void print(T t) {
    std::cout << t << std::endl;
}

template<typename T, typename... Args>
void print(T t, Args... args) {
    std::cout << t << ", ";
    print(args...);
}

int main() {
    print(1, 2.5, "Hello");
}
''',
    correctAnswers: ['variadic templates', 'template', 'pack expansion'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 83,
    category: 'Functions',
    title: 'Lambda Capture by Reference',
    description: 'Capture variable by reference in lambda.',
    hint: 'Use [&var]',
    solution: '''
#include <iostream>

int main() {
    int x = 10;
    auto printX = [&x]() { std::cout << x << std::endl; };
    x = 20;
    printX();
}
''',
    correctAnswers: ['lambda', 'capture by reference', '[]'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 84,
    category: 'Control Flow',
    title: 'Continue Statement',
    description: 'Use continue to skip an iteration in a loop.',
    hint: 'Use continue inside loop',
    solution: '''
#include <iostream>

int main() {
    for (int i = 0; i < 5; ++i) {
        if (i == 2)
            continue;
        std::cout << i << std::endl;
    }
}
''',
    correctAnswers: ['continue', 'loop', 'skip'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 85,
    category: 'Standard Library',
    title: 'std::unordered_map',
    description: 'Use unordered_map for fast key-value lookup.',
    hint: 'Include <unordered_map>',
    solution: '''
#include <iostream>
#include <unordered_map>

int main() {
    std::unordered_map<std::string, int> map = {{"apple", 1}, {"banana", 2}};
    std::cout << map["apple"] << std::endl;
}
''',
    correctAnswers: ['unordered_map', 'hash map', 'key-value'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 86,
    category: 'Loops',
    title: 'Do-While Loop',
    description: 'Use do-while loop for at least one execution.',
    hint: 'do { ... } while(condition);',
    solution: '''
#include <iostream>

int main() {
    int i = 0;
    do {
        std::cout << i << std::endl;
        ++i;
    } while (i < 3);
}
''',
    correctAnswers: ['do-while', 'loop', 'iteration'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 87,
    category: 'Object-Oriented Programming',
    title: 'Virtual Destructors',
    description: 'Use virtual destructor in base class.',
    hint: 'virtual ~ClassName() {}',
    solution: '''
#include <iostream>

class Base {
public:
    virtual ~Base() {
        std::cout << "Base destructor\n";
    }
};

class Derived : public Base {
public:
    ~Derived() {
        std::cout << "Derived destructor\n";
    }
};

int main() {
    Base* b = new Derived();
    delete b;
}
''',
    correctAnswers: ['virtual destructor', 'polymorphism', 'cleanup'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 88,
    category: 'Templates',
    title: 'Template Non-Type Parameters',
    description: 'Use non-type template parameters.',
    hint: 'template<int N>',
    solution: '''
#include <iostream>

template<int N>
void print() {
    std::cout << "Value: " << N << std::endl;
}

int main() {
    print<5>();
}
''',
    correctAnswers: ['non-type parameter', 'template', 'compile time'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 89,
    category: 'Exception Handling',
    title: 'Custom Exception Class',
    description: 'Create and throw a custom exception.',
    hint: 'Inherit from std::exception',
    solution: '''
#include <iostream>
#include <exception>

class MyException : public std::exception {
public:
    const char* what() const noexcept override {
        return "My custom exception";
    }
};

int main() {
    try {
        throw MyException();
    } catch(const std::exception& e) {
        std::cout << e.what() << std::endl;
    }
}
''',
    correctAnswers: ['custom exception', 'std::exception', 'throw'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 90,
    category: 'File Handling',
    title: 'Check File Existence',
    description: 'Check if a file exists using std::ifstream.',
    hint: 'Use ifstream and is_open()',
    solution: '''
#include <fstream>
#include <iostream>

int main() {
    std::ifstream file("test.txt");
    if (file.is_open()) {
        std::cout << "File exists" << std::endl;
    } else {
        std::cout << "File not found" << std::endl;
    }
}
''',
    correctAnswers: ['ifstream', 'is_open', 'file check'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 91,
    category: 'Standard Library',
    title: 'std::stack',
    description: 'Use std::stack for LIFO data structure.',
    hint: 'Include <stack>',
    solution: '''
#include <stack>
#include <iostream>

int main() {
    std::stack<int> s;
    s.push(10);
    s.push(20);
    std::cout << s.top() << std::endl;
}
''',
    correctAnswers: ['stack', 'LIFO', 'push'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 92,
    category: 'Functions',
    title: 'Function Pointer',
    description: 'Use pointers to functions.',
    hint: 'ReturnType (*name)(Params)',
    solution: '''
#include <iostream>

void greet() {
    std::cout << "Hello" << std::endl;
}

int main() {
    void (*funcPtr)() = greet;
    funcPtr();
}
''',
    correctAnswers: ['function pointer', 'pointer', 'callback'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 93,
    category: 'Loops',
    title: 'Nested Loops',
    description: 'Write nested for loops to print a pattern.',
    hint: 'Loop inside loop',
    solution: '''
#include <iostream>

int main() {
    for (int i = 1; i <= 3; ++i) {
        for (int j = 1; j <= i; ++j) {
            std::cout << "*";
        }
        std::cout << std::endl;
    }
}
''',
    correctAnswers: ['nested loop', 'for', 'pattern'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 94,
    category: 'Object-Oriented Programming',
    title: 'Multiple Inheritance',
    description: 'Create a class with multiple inheritance.',
    hint: 'class Derived : public Base1, public Base2',
    solution: '''
#include <iostream>

class Base1 {
public:
    void foo() { std::cout << "Base1\n"; }
};

class Base2 {
public:
    void bar() { std::cout << "Base2\n"; }
};

class Derived : public Base1, public Base2 {};

int main() {
    Derived d;
    d.foo();
    d.bar();
}
''',
    correctAnswers: ['multiple inheritance', 'base class', 'derived class'],
    difficulty: 'Hard',
  ),
  Puzzle(
    id: 95,
    category: 'Memory Management',
    title: 'Unique Pointer',
    description: 'Use std::unique_ptr for automatic memory management.',
    hint: 'Include <memory>',
    solution: '''
#include <iostream>
#include <memory>

int main() {
    std::unique_ptr<int> ptr = std::make_unique<int>(42);
    std::cout << *ptr << std::endl;
}
''',
    correctAnswers: ['unique_ptr', 'smart pointer', 'automatic memory'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 96,
    category: 'Standard Library',
    title: 'std::queue',
    description: 'Use std::queue for FIFO data structure.',
    hint: 'Include <queue>',
    solution: '''
#include <queue>
#include <iostream>

int main() {
    std::queue<int> q;
    q.push(1);
    q.push(2);
    std::cout << q.front() << std::endl;
}
''',
    correctAnswers: ['queue', 'FIFO', 'push'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 97,
    category: 'Control Flow',
    title: 'Break Statement',
    description: 'Use break to exit loops early.',
    hint: 'Use break inside loop',
    solution: '''
#include <iostream>

int main() {
    for (int i = 0; i < 5; ++i) {
        if (i == 3)
            break;
        std::cout << i << std::endl;
    }
}
''',
    correctAnswers: ['break', 'loop', 'exit'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 98,
    category: 'Exception Handling',
    title: 'Multiple Catch Blocks',
    description: 'Catch different exceptions with multiple catch blocks.',
    hint: 'Use catch(...)',
    solution: '''
#include <iostream>
#include <stdexcept>

int main() {
    try {
        throw std::runtime_error("Error!");
    } catch (const std::logic_error& e) {
        std::cout << "Logic error" << std::endl;
    } catch (const std::runtime_error& e) {
        std::cout << e.what() << std::endl;
    }
}
''',
    correctAnswers: ['catch', 'multiple', 'exception'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 99,
    category: 'Functions',
    title: 'Default Arguments',
    description: 'Use default values for function parameters.',
    hint: 'void foo(int x = 10)',
    solution: '''
#include <iostream>

void printNumber(int x = 10) {
    std::cout << x << std::endl;
}

int main() {
    printNumber();
    printNumber(5);
}
''',
    correctAnswers: ['default arguments', 'function', 'parameters'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 100,
    category: 'Templates',
    title: 'Template Specialization',
    description: 'Specialize a template for a specific type.',
    hint: 'template<>',
    solution: '''
#include <iostream>

template<typename T>
void print(T val) {
    std::cout << "Generic: " << val << std::endl;
}

template<>
void print<int>(int val) {
    std::cout << "Int specialization: " << val << std::endl;
}

int main() {
    print(5);
    print("Hello");
}
''',
    correctAnswers: ['template specialization', 'template<>', 'function template'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 101,
    category: 'File Handling',
    title: 'Read Entire File',
    description: 'Read entire file content into a string.',
    hint: 'Use std::getline in a loop',
    solution: '''
#include <iostream>
#include <fstream>
#include <sstream>

int main() {
    std::ifstream file("test.txt");
    std::stringstream buffer;
    buffer << file.rdbuf();
    std::cout << buffer.str() << std::endl;
}
''',
    correctAnswers: ['file reading', 'ifstream', 'stringstream'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 102,
    category: 'Advanced Topics',
    title: 'constexpr Functions',
    description: 'Create compile-time evaluated functions.',
    hint: 'Use constexpr keyword',
    solution: '''
#include <iostream>

constexpr int square(int x) {
    return x * x;
}

int main() {
    constexpr int result = square(5);
    std::cout << result << std::endl;
}
''',
    correctAnswers: ['constexpr', 'compile-time', 'function'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 103,
    category: 'Object-Oriented Programming',
    title: 'Abstract Classes',
    description: 'Define an abstract class with pure virtual functions.',
    hint: 'Use = 0',
    solution: '''
#include <iostream>

class Shape {
public:
    virtual void draw() = 0;
};

class Circle : public Shape {
public:
    void draw() override {
        std::cout << "Drawing Circle" << std::endl;
    }
};

int main() {
    Circle c;
    c.draw();
}
''',
    correctAnswers: ['abstract class', 'pure virtual', 'interface'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 104,
    category: 'Standard Library',
    title: 'std::algorithm - find_if',
    description: 'Find element with condition using std::find_if.',
    hint: 'Include <algorithm>',
    solution: '''
#include <iostream>
#include <vector>
#include <algorithm>

int main() {
    std::vector<int> v = {1, 2, 3, 4, 5};
    auto it = std::find_if(v.begin(), v.end(), [](int x) { return x > 3; });
    if (it != v.end())
        std::cout << *it << std::endl;
}
''',
    correctAnswers: ['find_if', 'algorithm', 'lambda'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 105,
    category: 'Loops',
    title: 'Range-based for Loop',
    description: 'Use range-based for loop to iterate containers.',
    hint: 'for (auto &x : container)',
    solution: '''
#include <iostream>
#include <vector>

int main() {
    std::vector<int> v = {1, 2, 3};
    for (auto &x : v) {
        std::cout << x << " ";
    }
}
''',
    correctAnswers: ['range-based for', 'for', 'loop'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 106,
    category: 'Functions',
    title: 'Recursive Functions',
    description: 'Write a recursive function to calculate factorial.',
    hint: 'Function calls itself',
    solution: '''
#include <iostream>

int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

int main() {
    std::cout << factorial(5) << std::endl;
}
''',
    correctAnswers: ['recursive', 'factorial', 'function'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 107,
    category: 'Exception Handling',
    title: 'Re-throw Exception',
    description: 'Catch and re-throw an exception.',
    hint: 'Use throw inside catch block',
    solution: '''
#include <iostream>
#include <stdexcept>

void f() {
    try {
        throw std::runtime_error("Error");
    } catch (...) {
        std::cout << "Caught, rethrowing" << std::endl;
        throw;
    }
}

int main() {
    try {
        f();
    } catch (const std::exception &e) {
        std::cout << e.what() << std::endl;
    }
}
''',
    correctAnswers: ['rethrow', 'throw', 'exception'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 108,
    category: 'Templates',
    title: 'Template Aliases',
    description: 'Use template alias for simpler syntax.',
    hint: 'using alias = template',
    solution: '''
#include <iostream>
#include <vector>

template <typename T>
using Vec = std::vector<T>;

int main() {
    Vec<int> v = {1, 2, 3};
    for (auto n : v) std::cout << n << " ";
}
''',
    correctAnswers: ['template alias', 'using', 'vector'],
    difficulty: 'Medium',
  ),
  Puzzle(
    id: 109,
    category: 'Memory Management',
    title: 'Unique Pointer',
    description: 'Use std::unique_ptr for exclusive ownership.',
    hint: 'Include <memory>',
    solution: '''
#include <iostream>
#include <memory>

int main() {
    std::unique_ptr<int> ptr = std::make_unique<int>(42);
    std::cout << *ptr << std::endl;
}
''',
    correctAnswers: ['unique_ptr', 'smart pointer', 'memory management'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 110,
    category: 'Functions',
    title: 'Recursive Function',
    description: 'Implement recursive functions in C++.',
    hint: 'Function calls itself',
    solution: '''
#include <iostream>

int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

int main() {
    std::cout << factorial(5) << std::endl;
}
''',
    correctAnswers: ['recursion', 'factorial', 'function calls itself'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 111,
    category: 'STL',
    title: 'std::unordered_map',
    description: 'Use std::unordered_map for hash map functionality.',
    hint: 'Include <unordered_map>',
    solution: '''
#include <iostream>
#include <unordered_map>

int main() {
    std::unordered_map<std::string, int> map;
    map["one"] = 1;
    map["two"] = 2;
    std::cout << map["one"] << std::endl;
}
''',
    correctAnswers: ['unordered_map', 'hash map', 'key value'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 112,
    category: 'Control Flow',
    title: 'Ternary Operator',
    description: 'Use the ternary operator for concise conditional expressions.',
    hint: 'condition ? expr1 : expr2',
    solution: '''
#include <iostream>

int main() {
    int x = 10;
    std::cout << (x > 5 ? "Greater" : "Smaller") << std::endl;
}
''',
    correctAnswers: ['ternary operator', 'conditional', '? :'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 113,
    category: 'Standard Library',
    title: 'std::bitset',
    description: 'Use std::bitset for bit manipulation.',
    hint: 'Include <bitset>',
    solution: '''
#include <iostream>
#include <bitset>

int main() {
    std::bitset<8> bits(42);
    std::cout << bits << std::endl;
}
''',
    correctAnswers: ['bitset', 'bits', 'bit manipulation'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 114,
    category: 'Exception Handling',
    title: 'Throwing Custom Exceptions',
    description: 'Create and throw your own exceptions.',
    hint: 'Derive from std::exception',
    solution: '''
#include <iostream>
#include <exception>

class MyException : public std::exception {
public:
    const char* what() const noexcept override {
        return "My custom exception";
    }
};

int main() {
    try {
        throw MyException();
    } catch (const std::exception& e) {
        std::cout << e.what() << std::endl;
    }
}
''',
    correctAnswers: ['custom exception', 'throw', 'catch'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 115,
    category: 'Loops',
    title: 'Continue Statement',
    description: 'Skip an iteration in a loop using continue.',
    hint: 'Use continue inside loop',
    solution: '''
#include <iostream>

int main() {
    for (int i = 0; i < 5; ++i) {
        if (i == 2) continue;
        std::cout << i << std::endl;
    }
}
''',
    correctAnswers: ['continue', 'skip iteration', 'loop control'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 116,
    category: 'Object-Oriented Programming',
    title: 'Multiple Inheritance',
    description: 'Inherit from multiple base classes.',
    hint: 'class Derived : public Base1, public Base2',
    solution: '''
#include <iostream>

class Base1 {
public:
    void foo() { std::cout << "Base1" << std::endl; }
};

class Base2 {
public:
    void bar() { std::cout << "Base2" << std::endl; }
};

class Derived : public Base1, public Base2 {};

int main() {
    Derived d;
    d.foo();
    d.bar();
}
''',
    correctAnswers: ['multiple inheritance', 'base classes', 'derived class'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 117,
    category: 'Templates',
    title: 'Variadic Templates',
    description: 'Templates with variable number of parameters.',
    hint: 'template<typename... Args>',
    solution: '''
#include <iostream>

template<typename... Args>
void printAll(Args... args) {
    (std::cout << ... << args) << std::endl;
}

int main() {
    printAll(1, " hello ", 3.14);
}
''',
    correctAnswers: ['variadic templates', 'fold expression', 'template'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 118,
    category: 'Memory Management',
    title: 'Weak Pointer',
    description: 'Use std::weak_ptr to break reference cycles.',
    hint: 'Include <memory>',
    solution: '''
#include <iostream>
#include <memory>

int main() {
    std::shared_ptr<int> sp = std::make_shared<int>(10);
    std::weak_ptr<int> wp = sp;

    if (!wp.expired()) {
        std::cout << *wp.lock() << std::endl;
    }
}
''',
    correctAnswers: ['weak_ptr', 'shared_ptr', 'memory management'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 119,
    category: 'Standard Library',
    title: 'std::function',
    description: 'Use std::function to store functions or lambdas.',
    hint: 'Include <functional>',
    solution: '''
#include <iostream>
#include <functional>

int add(int a, int b) { return a + b; }

int main() {
    std::function<int(int, int)> func = add;
    std::cout << func(3, 4) << std::endl;
}
''',
    correctAnswers: ['std::function', 'function pointer', 'lambda'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 120,
    category: 'Advanced Topics',
    title: 'Move Constructor',
    description: 'Implement a move constructor.',
    hint: 'Use && and std::move',
    solution: '''
#include <iostream>
#include <utility>

class Buffer {
public:
    int* data;
    size_t size;
    Buffer(size_t s) : size(s), data(new int[s]) {}

    Buffer(Buffer&& other) noexcept : data(nullptr), size(0) {
        data = other.data;
        size = other.size;
        other.data = nullptr;
        other.size = 0;
    }

    ~Buffer() { delete[] data; }
};

int main() {
    Buffer buf1(5);
    Buffer buf2 = std::move(buf1);
    std::cout << "Moved" << std::endl;
}
''',
    correctAnswers: ['move constructor', 'std::move', 'rvalue reference'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 121,
    category: 'File Handling',
    title: 'File Stream Read',
    description: 'Read from a file using ifstream.',
    hint: 'Include <fstream>',
    solution: '''
#include <iostream>
#include <fstream>

int main() {
    std::ifstream infile("test.txt");
    std::string line;
    while (std::getline(infile, line)) {
        std::cout << line << std::endl;
    }
}
''',
    correctAnswers: ['ifstream', 'file reading', 'fstream'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 122,
    category: 'Control Flow',
    title: 'Goto and Label',
    description: 'Use goto and label for jumping.',
    hint: 'Use label and goto statement',
    solution: '''
#include <iostream>

int main() {
    int i = 0;
start:
    std::cout << i << std::endl;
    i++;
    if (i < 5) goto start;
}
''',
    correctAnswers: ['goto', 'label', 'jump'],
    difficulty: 'Hard',
  ),
  Puzzle(
    id: 123,
    category: 'Loops',
    title: 'Range-based For Loop',
    description: 'Use range-based for loops to iterate containers.',
    hint: 'for (auto &element : container)',
    solution: '''
#include <iostream>
#include <vector>

int main() {
    std::vector<int> vec = {1, 2, 3, 4};
    for (auto &num : vec) {
        std::cout << num << std::endl;
    }
}
''',
    correctAnswers: ['range-based for', 'for each', 'loop'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 124,
    category: 'Functions',
    title: 'Default Parameters',
    description: 'Use default parameters in function declarations.',
    hint: 'Specify default values in function signature',
    solution: '''
#include <iostream>

void greet(std::string name = "Guest") {
    std::cout << "Hello, " << name << std::endl;
}

int main() {
    greet();
    greet("Alice");
}
''',
    correctAnswers: ['default parameter', 'function', 'optional argument'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 125,
    category: 'Object-Oriented Programming',
    title: 'Access Specifiers',
    description: 'Understand public, private, and protected members.',
    hint: 'Use keywords public, private, protected',
    solution: '''
#include <iostream>

class MyClass {
public:
    int publicVar;
private:
    int privateVar;
protected:
    int protectedVar;
};

int main() {
    MyClass obj;
    obj.publicVar = 10;
    std::cout << obj.publicVar << std::endl;
}
''',
    correctAnswers: ['access specifier', 'public', 'private', 'protected'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 126,
    category: 'Templates',
    title: 'Class Template Specialization',
    description: 'Specialize templates for specific types.',
    hint: 'template<> specialization',
    solution: '''
#include <iostream>

template<typename T>
class Printer {
public:
    void print() { std::cout << "Generic template" << std::endl; }
};

template<>
class Printer<int> {
public:
    void print() { std::cout << "Specialized for int" << std::endl; }
};

int main() {
    Printer<double> p1;
    Printer<int> p2;
    p1.print();
    p2.print();
}
''',
    correctAnswers: ['template specialization', 'class template', 'specialize'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 127,
    category: 'STL',
    title: 'std::deque',
    description: 'Use deque for fast insertion/removal at both ends.',
    hint: 'Include <deque>',
    solution: '''
#include <iostream>
#include <deque>

int main() {
    std::deque<int> d = {1, 2, 3};
    d.push_front(0);
    d.push_back(4);
    for (int n : d) std::cout << n << " ";
}
''',
    correctAnswers: ['deque', 'double-ended queue', 'container'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 128,
    category: 'Exception Handling',
    title: 'Nested Try-Catch',
    description: 'Use nested try-catch blocks for granular error handling.',
    hint: 'Try inside catch block',
    solution: '''
#include <iostream>

int main() {
    try {
        try {
            throw std::runtime_error("Inner exception");
        } catch (...) {
            std::cout << "Caught inner exception" << std::endl;
            throw;
        }
    } catch (const std::exception& e) {
        std::cout << "Caught outer exception: " << e.what() << std::endl;
    }
}
''',
    correctAnswers: ['nested try catch', 'exception handling', 'error'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 129,
    category: 'Memory Management',
    title: 'Memory Pool',
    description: 'Implement simple memory pool allocation.',
    hint: 'Preallocate memory blocks',
    solution: '''
// Conceptual example; implementation may vary.
''',
    correctAnswers: ['memory pool', 'custom allocator', 'memory management'],
    difficulty: 'Advanced',
  ),

  Puzzle(
    id: 130,
    category: 'Control Flow',
    title: 'Goto Statement',
    description: 'Use goto to jump to labels.',
    hint: 'Use label and goto',
    solution: '''
#include <iostream>

int main() {
    int i = 0;
start:
    std::cout << i << std::endl;
    i++;
    if (i < 3) goto start;
}
''',
    correctAnswers: ['goto', 'label', 'jump'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 131,
    category: 'Functions',
    title: 'Lambda Capture',
    description: 'Capture variables in lambdas.',
    hint: 'Use [=], [&], or specific variables',
    solution: '''
#include <iostream>

int main() {
    int x = 10;
    auto printX = [x]() { std::cout << x << std::endl; };
    printX();
}
''',
    correctAnswers: ['lambda', 'capture', 'anonymous function'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 132,
    category: 'STL',
    title: 'std::stack',
    description: 'Use stack container adapter.',
    hint: 'Include <stack>',
    solution: '''
#include <iostream>
#include <stack>

int main() {
    std::stack<int> s;
    s.push(1);
    s.push(2);
    while (!s.empty()) {
        std::cout << s.top() << std::endl;
        s.pop();
    }
}
''',
    correctAnswers: ['stack', 'LIFO', 'container adapter'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 133,
    category: 'File Handling',
    title: 'File Append',
    description: 'Append data to a file.',
    hint: 'Use ios::app',
    solution: '''
#include <iostream>
#include <fstream>

int main() {
    std::ofstream file("log.txt", std::ios::app);
    file << "New log entry\\n";
}
''',
    correctAnswers: ['append', 'file', 'ofstream'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 134,
    category: 'Loops',
    title: 'Do-While Loop',
    description: 'Use do-while loops for guaranteed single execution.',
    hint: 'do {} while()',
    solution: '''
#include <iostream>

int main() {
    int i = 0;
    do {
        std::cout << i << std::endl;
        i++;
    } while (i < 3);
}
''',
    correctAnswers: ['do while', 'loop', 'iteration'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 135,
    category: 'Object-Oriented Programming',
    title: 'Virtual Destructor',
    description: 'Use virtual destructors in base classes.',
    hint: 'virtual ~ClassName()',
    solution: '''
#include <iostream>

class Base {
public:
    virtual ~Base() { std::cout << "Base destroyed" << std::endl; }
};

class Derived : public Base {
public:
    ~Derived() { std::cout << "Derived destroyed" << std::endl; }
};

int main() {
    Base* b = new Derived();
    delete b;
}
''',
    correctAnswers: ['virtual destructor', 'destructor', 'polymorphism'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 136,
    category: 'Standard Library',
    title: 'std::array',
    description: 'Use std::array for fixed-size arrays.',
    hint: 'Include <array>',
    solution: '''
#include <iostream>
#include <array>

int main() {
    std::array<int, 3> arr = {1, 2, 3};
    for (int n : arr) std::cout << n << std::endl;
}
''',
    correctAnswers: ['std::array', 'fixed size', 'array'],
    difficulty: 'Easy',
  ),
  Puzzle(
    id: 137,
    category: 'Templates',
    title: 'Variadic Templates',
    description: 'Create functions or classes that accept any number of template parameters.',
    hint: 'Use template<typename... Args>',
    solution: '''
#include <iostream>

template<typename... Args>
void print(Args... args) {
    (std::cout << ... << args) << std::endl;
}

int main() {
    print(1, " ", 3.14, " ", 'A');
}
''',
    correctAnswers: ['variadic templates', 'template pack', 'parameter pack'],
    difficulty: 'Advanced',
  ),

  Puzzle(
    id: 138,
    category: 'Exception Handling',
    title: 'Exception Specification',
    description: 'Specify which exceptions a function might throw.',
    hint: 'Use noexcept or throw()',
    solution: '''
#include <iostream>
void func() noexcept {
    std::cout << "No exceptions" << std::endl;
}

int main() {
    func();
}
''',
    correctAnswers: ['noexcept', 'exception specification'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 139,
    category: 'Memory Management',
    title: 'Placement New',
    description: 'Construct object at a pre-allocated memory address.',
    hint: 'Use new (address) Type()',
    solution: '''
#include <iostream>
#include <new>

int main() {
    char buffer[sizeof(int)];
    int* p = new(buffer) int(42);
    std::cout << *p << std::endl;
    p->~int();
}
''',
    correctAnswers: ['placement new', 'custom allocator'],
    difficulty: 'Advanced',
  ),

  Puzzle(
    id: 140,
    category: 'Control Flow',
    title: 'Ternary Operator',
    description: 'Use ternary operator for conditional expressions.',
    hint: 'condition ? expr1 : expr2',
    solution: '''
#include <iostream>

int main() {
    int x = 10;
    std::cout << (x > 5 ? "Greater" : "Smaller") << std::endl;
}
''',
    correctAnswers: ['ternary', 'conditional operator'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 141,
    category: 'Functions',
    title: 'Overloaded Functions',
    description: 'Define multiple functions with same name but different parameters.',
    hint: 'Change function signature',
    solution: '''
#include <iostream>

void print(int x) { std::cout << "Int: " << x << std::endl; }
void print(double x) { std::cout << "Double: " << x << std::endl; }

int main() {
    print(10);
    print(3.14);
}
''',
    correctAnswers: ['function overloading', 'overload'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 142,
    category: 'STL',
    title: 'std::queue',
    description: 'FIFO container adapter.',
    hint: 'Include <queue>',
    solution: '''
#include <iostream>
#include <queue>

int main() {
    std::queue<int> q;
    q.push(1);
    q.push(2);
    while(!q.empty()) {
        std::cout << q.front() << std::endl;
        q.pop();
    }
}
''',
    correctAnswers: ['queue', 'FIFO'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 143,
    category: 'File Handling',
    title: 'File Seek',
    description: 'Move read/write position in a file.',
    hint: 'Use seekg and seekp',
    solution: '''
#include <iostream>
#include <fstream>

int main() {
    std::fstream file("test.txt", std::ios::in | std::ios::out);
    file.seekp(5);
    file << "Hello";
    file.close();
}
''',
    correctAnswers: ['seek', 'file pointer'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 144,
    category: 'Loops',
    title: 'Nested Loops',
    description: 'Use loops inside loops.',
    hint: 'Loop inside loop body',
    solution: '''
#include <iostream>

int main() {
    for(int i = 0; i < 3; i++) {
        for(int j = 0; j < 2; j++) {
            std::cout << i << "," << j << std::endl;
        }
    }
}
''',
    correctAnswers: ['nested loops', 'loop inside loop'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 145,
    category: 'Object-Oriented Programming',
    title: 'Abstract Classes',
    description: 'Define classes with pure virtual functions.',
    hint: 'Use = 0 for pure virtual',
    solution: '''
#include <iostream>

class Abstract {
public:
    virtual void foo() = 0;
};

class Concrete : public Abstract {
public:
    void foo() override { std::cout << "Implemented" << std::endl; }
};

int main() {
    Concrete c;
    c.foo();
}
''',
    correctAnswers: ['abstract class', 'pure virtual'],
    difficulty: 'Hard',
  ),

  Puzzle(
    id: 146,
    category: 'Templates',
    title: 'Template Metaprogramming',
    description: 'Compute values at compile time using templates.',
    hint: 'Use recursive templates',
    solution: '''
#include <iostream>

template<int N>
struct Factorial {
    static const int value = N * Factorial<N-1>::value;
};

template<>
struct Factorial<0> {
    static const int value = 1;
};

int main() {
    std::cout << Factorial<5>::value << std::endl;
}
''',
    correctAnswers: ['template metaprogramming', 'compile time'],
    difficulty: 'Advanced',
  ),

  Puzzle(
    id: 147,
    category: 'Exception Handling',
    title: 'Re-throwing Exceptions',
    description: 'Throw exception again from catch block.',
    hint: 'Use throw; inside catch',
    solution: '''
#include <iostream>
#include <stdexcept>

int main() {
    try {
        throw std::runtime_error("Error");
    } catch (...) {
        std::cout << "Caught, rethrowing" << std::endl;
        throw;
    }
}
''',
    correctAnswers: ['rethrow', 'throw inside catch'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 148,
    category: 'Memory Management',
    title: 'Shared Pointer',
    description: 'Shared ownership smart pointer.',
    hint: 'Use std::shared_ptr',
    solution: '''
#include <iostream>
#include <memory>

int main() {
    std::shared_ptr<int> p1 = std::make_shared<int>(42);
    std::shared_ptr<int> p2 = p1;
    std::cout << *p1 << " " << *p2 << std::endl;
}
''',
    correctAnswers: ['shared_ptr', 'smart pointer'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 149,
    category: 'Control Flow',
    title: 'Break Statement',
    description: 'Exit loops early.',
    hint: 'Use break;',
    solution: '''
#include <iostream>

int main() {
    for(int i = 0; i < 5; i++) {
        if(i == 3) break;
        std::cout << i << std::endl;
    }
}
''',
    correctAnswers: ['break', 'exit loop'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 150,
    category: 'Functions',
    title: 'Recursion',
    description: 'Function calling itself.',
    hint: 'Call function inside itself',
    solution: '''
#include <iostream>

int factorial(int n) {
    if(n <= 1) return 1;
    else return n * factorial(n - 1);
}

int main() {
    std::cout << factorial(5) << std::endl;
}
''',
    correctAnswers: ['recursion', 'recursive function'],
    difficulty: 'Medium',
  ),
  Puzzle(
    id: 151,
    category: 'Variables & Data Types',
    title: 'Variable Declaration',
    description: 'Declare variables with appropriate types.',
    hint: 'Use type name followed by variable name',
    solution: '''
#include <iostream>

int main() {
    int age = 30;
    double salary = 75000.50;
    char grade = 'A';
    bool isEmployed = true;

    std::cout << "Age: " << age << "\\nSalary: " << salary << "\\nGrade: " << grade << "\\nEmployed: " << isEmployed << std::endl;
}
''',
    correctAnswers: ['variable declaration', 'declare variables'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 152,
    category: 'Variables & Data Types',
    title: 'Constants',
    description: 'Define variables whose values do not change.',
    hint: 'Use const keyword',
    solution: '''
#include <iostream>

int main() {
    const double PI = 3.14159;
    const int DAYS_IN_WEEK = 7;

    std::cout << "Pi: " << PI << "\\nDays in week: " << DAYS_IN_WEEK << std::endl;
}
''',
    correctAnswers: ['constant', 'const', 'immutable variable'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 153,
    category: 'Variables & Data Types',
    title: 'Type Conversion',
    description: 'Convert variables from one type to another.',
    hint: 'Use static_cast or C-style cast',
    solution: '''
#include <iostream>

int main() {
    double pi = 3.14159;
    int intPi = static_cast<int>(pi);
    std::cout << "Int Pi: " << intPi << std::endl;
}
''',
    correctAnswers: ['type conversion', 'casting', 'static_cast'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 154,
    category: 'Variables & Data Types',
    title: 'Auto Keyword',
    description: 'Let compiler deduce variable type automatically.',
    hint: 'Use auto keyword',
    solution: '''
#include <iostream>

int main() {
    auto x = 5;
    auto y = 3.14;
    std::cout << "x: " << x << ", y: " << y << std::endl;
}
''',
    correctAnswers: ['auto keyword', 'type inference'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 155,
    category: 'Variables & Data Types',
    title: 'Static Variables',
    description: 'Variables that retain value between function calls.',
    hint: 'Use static keyword inside function',
    solution: '''
#include <iostream>

void counter() {
    static int count = 0;
    count++;
    std::cout << "Count: " << count << std::endl;
}

int main() {
    counter();
    counter();
    counter();
}
''',
    correctAnswers: ['static variable', 'static'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 156,
    category: 'Variables & Data Types',
    title: 'Reference Variables',
    description: 'Alias for another variable.',
    hint: 'Use & to declare reference',
    solution: '''
#include <iostream>

int main() {
    int x = 10;
    int& ref = x;
    ref = 20;
    std::cout << "x: " << x << std::endl;
}
''',
    correctAnswers: ['reference', 'reference variable', 'alias'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 157,
    category: 'Variables & Data Types',
    title: 'Global Variables',
    description: 'Variables declared outside any function.',
    hint: 'Declare outside main and functions',
    solution: '''
#include <iostream>

int globalVar = 100;

int main() {
    std::cout << "Global: " << globalVar << std::endl;
}
''',
    correctAnswers: ['global variable', 'global scope'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 158,
    category: 'Variables & Data Types',
    title: 'Local Variables',
    description: 'Variables declared inside functions.',
    hint: 'Declared inside function body',
    solution: '''
#include <iostream>

int main() {
    int localVar = 50;
    std::cout << "Local: " << localVar << std::endl;
}
''',
    correctAnswers: ['local variable', 'local scope'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 159,
    category: 'Variables & Data Types',
    title: 'Variable Initialization',
    description: 'Assign initial value when declaring variables.',
    hint: 'Use = operator during declaration',
    solution: '''
#include <iostream>

int main() {
    int a = 10;
    double b = 3.14;
    char c = 'Z';

    std::cout << a << " " << b << " " << c << std::endl;
}
''',
    correctAnswers: ['initialization', 'initialize variables'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 160,
    category: 'Variables & Data Types',
    title: 'Uninitialized Variables',
    description: 'Variables declared but not assigned a value.',
    hint: 'May contain garbage values',
    solution: '''
#include <iostream>

int main() {
    int x; // uninitialized
    std::cout << "Uninitialized x: " << x << std::endl;
}
''',
    correctAnswers: ['uninitialized', 'garbage value'],
    difficulty: 'Medium',
  ),
  Puzzle(
    id: 161,
    category: 'Arrays',
    title: 'Declare an Array',
    description: 'Declare an integer array with size 5.',
    hint: 'Use type name followed by variable name and size in brackets.',
    solution: '''
#include <iostream>

int main() {
    int numbers[5];
    return 0;
}
''',
    correctAnswers: ['declare array', 'int array', 'integer array'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 162,
    category: 'Arrays',
    title: 'Initialize Array Elements',
    description: 'Declare and initialize an array with values 1, 2, 3, 4, 5.',
    hint: 'Use curly braces {} with values.',
    solution: '''
#include <iostream>

int main() {
    int numbers[5] = {1, 2, 3, 4, 5};
    return 0;
}
''',
    correctAnswers: ['initialize array', 'array initialization'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 163,
    category: 'Arrays',
    title: 'Access Array Elements',
    description: 'Print the third element of the array.',
    hint: 'Arrays are zero-indexed.',
    solution: '''
#include <iostream>

int main() {
    int numbers[5] = {10, 20, 30, 40, 50};
    std::cout << numbers[2] << std::endl;
    return 0;
}
''',
    correctAnswers: ['access array', 'array indexing', 'third element'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 164,
    category: 'Arrays',
    title: 'Modify Array Element',
    description: 'Change the second element of the array to 99.',
    hint: 'Use index assignment.',
    solution: '''
#include <iostream>

int main() {
    int numbers[3] = {5, 6, 7};
    numbers[1] = 99;
    std::cout << numbers[1] << std::endl;
    return 0;
}
''',
    correctAnswers: ['modify array', 'update element', 'change value'],
    difficulty: 'Easy',
  ),

  Puzzle(
    id: 165,
    category: 'Arrays',
    title: 'Array Length',
    description: 'Calculate the number of elements in the array.',
    hint: 'Use sizeof operator.',
    solution: '''
#include <iostream>

int main() {
    int numbers[5] = {1, 2, 3, 4, 5};
    int length = sizeof(numbers) / sizeof(numbers[0]);
    std::cout << "Length: " << length << std::endl;
    return 0;
}
''',
    correctAnswers: ['array length', 'size of array'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 166,
    category: 'Arrays',
    title: 'Iterate over Array',
    description: 'Use a for loop to print all elements of an array.',
    hint: 'Use loop with array length.',
    solution: '''
#include <iostream>

int main() {
    int numbers[4] = {10, 20, 30, 40};
    for(int i = 0; i < 4; i++) {
        std::cout << numbers[i] << std::endl;
    }
    return 0;
}
''',
    correctAnswers: ['iterate array', 'for loop array', 'loop over array'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 167,
    category: 'Arrays',
    title: 'Multidimensional Arrays',
    description: 'Declare a 2D array of size 3x3.',
    hint: 'Use two sets of brackets.',
    solution: '''
#include <iostream>

int main() {
    int matrix[3][3];
    return 0;
}
''',
    correctAnswers: ['2d array', 'multidimensional array', 'matrix'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 168,
    category: 'Arrays',
    title: 'Initialize 2D Array',
    description: 'Initialize a 2D array with values.',
    hint: 'Use nested curly braces.',
    solution: '''
#include <iostream>

int main() {
    int matrix[2][2] = {{1, 2}, {3, 4}};
    return 0;
}
''',
    correctAnswers: ['initialize 2d array', '2d array initialization'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 169,
    category: 'Arrays',
    title: 'Access 2D Array Element',
    description: 'Print element at second row, first column.',
    hint: 'Use row and column indices.',
    solution: '''
#include <iostream>

int main() {
    int matrix[2][3] = {{1,2,3}, {4,5,6}};
    std::cout << matrix[1][0] << std::endl;
    return 0;
}
''',
    correctAnswers: ['access 2d array', '2d array indexing'],
    difficulty: 'Medium',
  ),

  Puzzle(
    id: 170,
    category: 'Arrays',
    title: 'Array Out of Bounds',
    description: 'What happens if you access index out of array size?',
    hint: 'Undefined behavior.',
    solution: '''
// Accessing out of bounds is undefined and may cause errors or unexpected output.
''',
    correctAnswers: ['undefined behavior', 'out of bounds', 'error'],
    difficulty: 'Hard',
  ),

  // Add more puzzles here as needed, following the same pattern...
];
