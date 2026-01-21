// lib/providers/lesson_content_provider.dart

import 'package:flutter/foundation.dart';
import '../models/lesson.dart';

class LessonContentProvider extends ChangeNotifier {
  final List<Lesson> _lessons = [
    // Sample lessons, you can add all your lessons here

    Lesson(
      category: 'Introduction',
      title: 'What is C++',
      shortDescription: 'Overview of the C++ programming language.',
      detailedExplanation: '''
C++ is a powerful general-purpose programming language developed by Bjarne Stroustrup as an extension of the C language. It supports various programming paradigms such as procedural, object-oriented, and generic programming.

This lesson covers C++’s history, key features, and typical use cases including system/software development, games, and real-time systems.

Understanding these foundations helps appreciate C++’s versatility and performance advantages.
''',
      exampleCode: '''
#include <iostream>
int main() {
    std::cout << "Hello, C++!" << std::endl;
    return 0;
}
''',
      expectedOutput: 'Hello, C++!',
    ),

    Lesson(
      category: 'Variables & Data Types',
      title: 'Basic Variables and Data Types',
      shortDescription: 'Understanding variables and fundamental types.',
      detailedExplanation: '''
Variables store data values in a program. C++ provides several built-in data types such as int, float, double, char, and bool to represent different kinds of data.

This lesson explains variable declaration, initialization, and basic usage along with type sizes and value ranges.

You will learn how to create variables and use them effectively.
''',
      exampleCode: '''
#include <iostream>
int main() {
    int age = 25;
    double height = 175.5;
    char grade = 'A';

    std::cout << "Age: " << age << "\\nHeight: " << height << "\\nGrade: " << grade << std::endl;
    return 0;
}
''',
      expectedOutput: '''
Age: 25
Height: 175.5
Grade: A
''',
    ),
// 3
    // Extend inside the _lessons list:

// 3
    Lesson(
      category: 'Variables & Data Types',
      title: 'Constants and Literals',
      shortDescription: 'Using constant values and literals in C++.',
      detailedExplanation: '''
Constants are variables whose values cannot be changed after initialization. They provide safety and clarity in code.

This lesson teaches you how to declare constants using the const keyword and introduces literals — fixed values embedded in code such as numbers and characters.

Understanding constants improves code reliability and readability.
''',
      exampleCode: '''
#include <iostream>
int main() {
    const double PI = 3.14159;
    std::cout << "Pi is approximately " << PI << std::endl;
    return 0;
}
''',
      expectedOutput: 'Pi is approximately 3.14159',
    ),

// 4
    Lesson(
      category: 'Control Flow',
      title: 'If Statements',
      shortDescription: 'Conditional branching with if and else.',
      detailedExplanation: '''
Control flow statements allow your program to make decisions. The if statement executes code based on a condition, while else provides alternative execution paths.

This lesson covers syntax, nested conditions, and best practices for clear, efficient branching.

You will gain the ability to write dynamic programs responding to different inputs.
''',
      exampleCode: '''
#include <iostream>
int main() {
    int score = 85;
    if(score >= 90) {
        std::cout << "Grade: A" << std::endl;
    } else if(score >= 80) {
        std::cout << "Grade: B" << std::endl;
    } else {
        std::cout << "Grade: C or below" << std::endl;
    }
    return 0;
}
''',
      expectedOutput: 'Grade: B',
    ),

// 5
    Lesson(
      category: 'Control Flow',
      title: 'Switch Statements',
      shortDescription: 'Multiple branch control with switch.',
      detailedExplanation: '''
The switch statement provides a clearer way to select one of many code blocks to execute based on a variable’s value.

This lesson explains switch syntax, case labels, break statements, and default cases.

You will learn when to use switch for better readability and performance.
''',
      exampleCode: '''
#include <iostream>
int main() {
    int day = 3;
    switch(day) {
        case 1: std::cout << "Monday"; break;
        case 2: std::cout << "Tuesday"; break;
        case 3: std::cout << "Wednesday"; break;
        default: std::cout << "Another day"; break;
    }
    return 0;
}
''',
      expectedOutput: 'Wednesday',
    ),

// 6
    Lesson(
      category: 'Loops',
      title: 'For Loop',
      shortDescription: 'Looping with for.',
      detailedExplanation: '''
The for loop executes a block of code repeatedly with a counter variable. It is used when the number of iterations is known.

This lesson shows the syntax of for loops and how to use them for iteration.

You will learn how to write loops that efficiently perform repeated tasks.
''',
      exampleCode: '''
#include <iostream>
int main() {
    for(int i = 0; i < 5; i++) {
        std::cout << "Number: " << i << std::endl;
    }
    return 0;
}
''',
      expectedOutput: '''
Number: 0
Number: 1
Number: 2
Number: 3
Number: 4
''',
    ),

// 7
    Lesson(
      category: 'Loops',
      title: 'While Loop',
      shortDescription: 'Looping with while.',
      detailedExplanation: '''
While loops execute as long as the condition remains true. They are suitable when the number of iterations is not known in advance.

This lesson explains the syntax and common uses of while loops.

You will be able to write loops that continue based on dynamic conditions.
''',
      exampleCode: '''
#include <iostream>
int main() {
    int count = 0;
    while(count < 3) {
        std::cout << "Count is " << count << std::endl;
        count++;
    }
    return 0;
}
''',
      expectedOutput: '''
Count is 0
Count is 1
Count is 2
''',
    ),

// 8
    Lesson(
      category: 'Functions',
      title: 'Defining and Calling Functions',
      shortDescription: 'Basics of functions in C++.',
      detailedExplanation: '''
Functions help organize code into reusable blocks. Defining functions involves specifying return types, names, and parameters.

This lesson teaches you how to create and call functions, improving code modularity.

Understanding functions is fundamental for writing structured programs.
''',
      exampleCode: '''
#include <iostream>
void greet() {
    std::cout << "Hello from a function!" << std::endl;
}
int main() {
    greet();
    return 0;
}
''',
      expectedOutput: 'Hello from a function!',
    ),

// 9
    Lesson(
      category: 'Functions',
      title: 'Function Parameters and Return Values',
      shortDescription: 'Passing data to and from functions.',
      detailedExplanation: '''
Functions can accept parameters and return values to communicate data.

This lesson covers how to declare parameters, pass arguments, and use return statements.

Mastering this lets you write flexible and reusable functions.
''',
      exampleCode: '''
#include <iostream>
int add(int a, int b) {
    return a + b;
}
int main() {
    std::cout << "Sum: " << add(5, 7) << std::endl;
    return 0;
}
''',
      expectedOutput: 'Sum: 12',
    ),
// 10
    Lesson(
      category: 'Object-Oriented Programming',
      title: 'Introduction to Classes and Objects',
      shortDescription: 'Basics of classes and creating objects.',
      detailedExplanation: '''
C++ is an object-oriented language that supports classes and objects. A class is a blueprint for objects that defines attributes and behaviors.

This lesson introduces the syntax to declare classes and instantiate objects, encapsulating data and functions together.

Understanding classes is key to designing modular and maintainable programs.
''',
      exampleCode: '''
#include <iostream>
class Car {
public:
    std::string brand;
    void honk() {
        std::cout << "Beep beep!" << std::endl;
    }
};

int main() {
    Car myCar;
    myCar.brand = "Toyota";
    std::cout << myCar.brand << std::endl;
    myCar.honk();
    return 0;
}
''',
      expectedOutput: '''
Toyota
Beep beep!
''',
    ),

// 11
    Lesson(
      category: 'Object-Oriented Programming',
      title: 'Constructors and Destructors',
      shortDescription: 'Initialize and cleanup objects.',
      detailedExplanation: '''
Constructors are special class functions called when objects are created, used for initialization. Destructors are called when objects are destroyed, used for cleanup.

This lesson explains how to declare constructors and destructors, and their roles in object lifecycle.

Proper use of these ensures robust object management.
''',
      exampleCode: '''
#include <iostream>
class Car {
public:
    std::string brand;
    Car(std::string b) {
        brand = b;
        std::cout << "Car created: " << brand << std::endl;
    }
    ~Car() {
        std::cout << "Car destroyed: " << brand << std::endl;
    }
};

int main() {
    Car myCar("Honda");
    return 0;
}
''',
      expectedOutput: '''
Car created: Honda
Car destroyed: Honda
''',
    ),

// 12
    Lesson(
      category: 'Object-Oriented Programming',
      title: 'Inheritance',
      shortDescription: 'Deriving classes and extending functionality.',
      detailedExplanation: '''
Inheritance allows a class (derived) to inherit attributes and methods from another (base). It enables code reuse and polymorphism.

This lesson covers syntax for inheritance, access specifiers, and how derived classes extend or override base class behavior.

Inheritance models real-world relationships in code.
''',
      exampleCode: '''
#include <iostream>
class Vehicle {
public:
    void move() {
        std::cout << "Vehicle is moving" << std::endl;
    }
};

class Car : public Vehicle {
public:
    void honk() {
        std::cout << "Car honks: Beep!" << std::endl;
    }
};

int main() {
    Car myCar;
    myCar.move();
    myCar.honk();
    return 0;
}
''',
      expectedOutput: '''
Vehicle is moving
Car honks: Beep!
''',
    ),

// 13
    Lesson(
      category: 'Object-Oriented Programming',
      title: 'Polymorphism and Virtual Functions',
      shortDescription: 'Dynamic method dispatch.',
      detailedExplanation: '''
Polymorphism allows methods to behave differently based on the object type at runtime. Virtual functions enable this dynamic dispatch.

This lesson explains virtual keyword, method overriding, and how polymorphism supports flexible and extensible designs.

Mastering polymorphism is essential for advanced OOP.
''',
      exampleCode: '''
#include <iostream>
class Animal {
public:
    virtual void sound() {
        std::cout << "Some sound" << std::endl;
    }
};

class Dog : public Animal {
public:
    void sound() override {
        std::cout << "Bark" << std::endl;
    }
};

int main() {
    Animal* a = new Dog();
    a->sound();
    delete a;
    return 0;
}
''',
      expectedOutput: 'Bark',
    ),

// 14
    Lesson(
      category: 'Templates',
      title: 'Function Templates',
      shortDescription: 'Generic functions for different types.',
      detailedExplanation: '''
Templates allow writing generic code that works with any data type. Function templates define functions parameterized by type.

This lesson shows how to declare and use function templates for code reuse.

Templates improve flexibility and reduce code duplication.
''',
      exampleCode: '''
#include <iostream>
template <typename T>
T max(T a, T b) {
    return (a > b) ? a : b;
}

int main() {
    std::cout << max(3, 7) << std::endl;
    std::cout << max(3.5, 2.5) << std::endl;
    return 0;
}
''',
      expectedOutput: '''
7
3.5
''',
    ),

// 15
    Lesson(
      category: 'Exception Handling',
      title: 'Try, Catch, and Throw',
      shortDescription: 'Handling errors gracefully.',
      detailedExplanation: '''
Exceptions provide a way to react to exceptional circumstances (like errors) during program execution.

This lesson teaches how to throw exceptions, catch them, and write robust error-handling code.

Proper exception handling improves program reliability.
''',
      exampleCode: '''
#include <iostream>
#include <stdexcept>

int divide(int a, int b) {
    if (b == 0) throw std::runtime_error("Division by zero");
    return a / b;
}

int main() {
    try {
        std::cout << divide(10, 0) << std::endl;
    } catch (const std::exception& e) {
        std::cout << "Error: " << e.what() << std::endl;
    }
    return 0;
}
''',
      expectedOutput: 'Error: Division by zero',
    ),

// 16
    Lesson(
      category: 'File Handling',
      title: 'Reading and Writing Files',
      shortDescription: 'Basic file input/output in C++.',
      detailedExplanation: '''
File handling is essential for persistent data storage. C++ provides fstream library to read and write files.

This lesson explains how to open files, read from them, write to them, and close them properly.

Understanding file I/O is critical for many applications.
''',
      exampleCode: '''
#include <iostream>
#include <fstream>

int main() {
    std::ofstream outfile("example.txt");
    outfile << "Hello, file!" << std::endl;
    outfile.close();

    std::ifstream infile("example.txt");
    std::string line;
    while (std::getline(infile, line)) {
        std::cout << line << std::endl;
    }
    infile.close();
    return 0;
}
''',
      expectedOutput: 'Hello, file!',
    ),

// 17
    Lesson(
      category: 'Standard Library',
      title: 'Using std::vector',
      shortDescription: 'Dynamic array with vectors.',
      detailedExplanation: '''
std::vector is a dynamic array container that can resize automatically.

This lesson covers how to declare, add, access, and iterate vectors.

Vectors are preferred over raw arrays for safety and flexibility.
''',
      exampleCode: '''
#include <iostream>
#include <vector>

int main() {
    std::vector<int> nums = {1, 2, 3};
    nums.push_back(4);
    for(int n : nums) {
        std::cout << n << " ";
    }
    std::cout << std::endl;
    return 0;
}
''',
      expectedOutput: '1 2 3 4 ',
    ),
// 18
    Lesson(
      category: 'Standard Library',
      title: 'Using std::string',
      shortDescription: 'String handling in C++.',
      detailedExplanation: '''
std::string provides a safer, easier way to handle text than C-style strings.

This lesson explains how to create, modify, and manipulate strings.

Strings are fundamental in almost all applications.
''',
      exampleCode: '''
#include <iostream>
#include <string>

int main() {
    std::string name = "CodeMaze";
    std::cout << "Welcome to " << name << std::endl;
    return 0;
}
''',
      expectedOutput: 'Welcome to CodeMaze',
    ),

// 19
    Lesson(
      category: 'Advanced Topics',
      title: 'Lambda Expressions',
      shortDescription: 'Anonymous inline functions.',
      detailedExplanation: '''
Lambdas allow you to write anonymous functions inline, useful for callbacks and functional programming.

This lesson introduces lambda syntax and usage.

Lambdas can simplify your code and enable powerful functional patterns.
''',
      exampleCode: '''
#include <iostream>
#include <vector>
#include <algorithm>

int main() {
    std::vector<int> nums = {1, 2, 3, 4, 5};
    nums.erase(std::remove_if(nums.begin(), nums.end(), [](int x){ return x % 2 == 0; }), nums.end());
    for (int n : nums) {
        std::cout << n << " ";
    }
    std::cout << std::endl;
    return 0;
}
''',
      expectedOutput: '1 3 5 ',
    ),

// 20
    Lesson(
      category: 'Advanced Topics',
      title: 'Smart Pointers',
      shortDescription: 'Automatic memory management.',
      detailedExplanation: '''
Smart pointers in C++ automate memory management by handling object lifetimes and deallocation.

This lesson explains unique_ptr, shared_ptr, and weak_ptr with examples.

Using smart pointers reduces memory leaks and dangling pointers.
''',
      exampleCode: '''
#include <iostream>
#include <memory>

int main() {
    std::unique_ptr<int> p1 = std::make_unique<int>(10);
    std::cout << *p1 << std::endl;
    return 0;
}
''',
      expectedOutput: '10',
    ),

// 21
    Lesson(
      category: 'Advanced Topics',
      title: 'Move Semantics',
      shortDescription: 'Efficient object transfer.',
      detailedExplanation: '''
Move semantics optimize performance by transferring resources instead of copying.

This lesson introduces rvalue references and move constructors.

Understanding move semantics is key to writing efficient modern C++.
''',
      exampleCode: '''
#include <iostream>
#include <vector>

int main() {
    std::vector<int> v1 = {1, 2, 3};
    std::vector<int> v2 = std::move(v1);
    std::cout << "v2 size: " << v2.size() << std::endl;
    std::cout << "v1 size after move: " << v1.size() << std::endl;
    return 0;
}
''',
      expectedOutput: '''
v2 size: 3
v1 size after move: 0
''',
    ),

// 22
    Lesson(
      category: 'STL',
      title: 'Using std::map',
      shortDescription: 'Associative container for key-value pairs.',
      detailedExplanation: '''
std::map stores key-value pairs sorted by keys. It provides fast lookup, insertion, and deletion.

This lesson covers declaration, insertion, access, and iteration.

Maps are useful for dictionary-like data structures.
''',
      exampleCode: '''
#include <iostream>
#include <map>

int main() {
    std::map<std::string, int> ages;
    ages["Alice"] = 30;
    ages["Bob"] = 25;
    for (const auto& pair : ages) {
        std::cout << pair.first << ": " << pair.second << std::endl;
    }
    return 0;
}
''',
      expectedOutput: '''
Alice: 30
Bob: 25
''',
    ),

// 23
    Lesson(
      category: 'STL',
      title: 'Using std::set',
      shortDescription: 'Container storing unique sorted elements.',
      detailedExplanation: '''
std::set stores unique elements in sorted order and supports fast lookup.

This lesson shows basic usage, insertion, and traversal.

Sets are good for maintaining collections of unique items.
''',
      exampleCode: '''
#include <iostream>
#include <set>

int main() {
    std::set<int> numbers = {3, 1, 4, 1, 5};
    for (int num : numbers) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    return 0;
}
''',
      expectedOutput: '1 3 4 5 ',
    ),

// 24
    Lesson(
      category: 'Advanced Topics',
      title: 'Multithreading Basics',
      shortDescription: 'Introduction to threads in C++.',
      detailedExplanation: '''
Multithreading allows concurrent execution of code for performance improvement.

This lesson introduces std::thread and basic synchronization concepts.

Multithreading is crucial for high-performance applications.
''',
      exampleCode: '''
#include <iostream>
#include <thread>

void say_hello() {
    std::cout << "Hello from thread!" << std::endl;
}

int main() {
    std::thread t(say_hello);
    t.join();
    return 0;
}
''',
      expectedOutput: 'Hello from thread!',
    ),

// 25
    Lesson(
      category: 'Memory Management',
      title: 'Dynamic Memory Allocation',
      shortDescription: 'Manual allocation and deallocation.',
      detailedExplanation: '''
C++ allows manual memory management using new and delete operators.

This lesson explains how to allocate memory dynamically and avoid leaks.

Proper memory management is essential for stable applications.
''',
      exampleCode: '''
#include <iostream>

int main() {
    int* p = new int(42);
    std::cout << *p << std::endl;
    delete p;
    return 0;
}
''',
      expectedOutput: '42',
    ),
// 26
    Lesson(
      category: 'Memory Management',
      title: 'Dangling Pointers and Memory Leaks',
      shortDescription: 'Common pitfalls in memory management.',
      detailedExplanation: '''
Dangling pointers occur when pointers refer to freed memory. Memory leaks happen when allocated memory is never freed.

This lesson discusses how to detect and prevent these issues.

Understanding these concepts prevents bugs and crashes.
''',
      exampleCode: '''// No runnable code; conceptual lesson.''',
      expectedOutput: '',
    ),

// 27
    Lesson(
      category: 'File Handling',
      title: 'Binary File I/O',
      shortDescription: 'Reading and writing binary data.',
      detailedExplanation: '''
Binary files store data in raw byte format, often used for efficiency.

This lesson shows how to read and write binary files using std::ifstream and std::ofstream.

Binary I/O is useful for custom file formats.
''',
      exampleCode: '''
#include <iostream>
#include <fstream>

int main() {
    std::ofstream out("data.bin", std::ios::binary);
    int num = 12345;
    out.write(reinterpret_cast<char*>(&num), sizeof(num));
    out.close();

    int num_read;
    std::ifstream in("data.bin", std::ios::binary);
    in.read(reinterpret_cast<char*>(&num_read), sizeof(num_read));
    std::cout << "Number read: " << num_read << std::endl;
    in.close();

    return 0;
}
''',
      expectedOutput: 'Number read: 12345',
    ),

// 28
    Lesson(
      category: 'Advanced Topics',
      title: 'Namespaces',
      shortDescription: 'Avoiding name collisions.',
      detailedExplanation: '''
Namespaces prevent naming conflicts by grouping identifiers under a named scope.

This lesson explains declaring and using namespaces.

Namespaces are critical in large projects and libraries.
''',
      exampleCode: '''
#include <iostream>

namespace Math {
    int add(int a, int b) {
        return a + b;
    }
}

int main() {
    std::cout << Math::add(5, 7) << std::endl;
    return 0;
}
''',
      expectedOutput: '12',
    ),

// 29
    Lesson(
      category: 'Templates',
      title: 'Class Templates',
      shortDescription: 'Generic classes in C++.',
      detailedExplanation: '''
Class templates enable defining classes that work with any data type.

This lesson demonstrates how to write and instantiate class templates.

Templates allow highly reusable and type-safe code.
''',
      exampleCode: '''
#include <iostream>

template <typename T>
class Pair {
public:
    T first, second;
    Pair(T a, T b) : first(a), second(b) {}
    void display() {
        std::cout << first << ", " << second << std::endl;
    }
};

int main() {
    Pair<int> p(1, 2);
    p.display();
    Pair<std::string> p2("Hello", "World");
    p2.display();
    return 0;
}
''',
      expectedOutput: '''
1, 2
Hello, World
''',
    ),

// 30
    Lesson(
      category: 'Advanced Topics',
      title: 'Operator Overloading',
      shortDescription: 'Customizing operators for your classes.',
      detailedExplanation: '''
Operator overloading allows you to define custom behavior for operators (+, -, *, etc.) in your classes.

This lesson explains the syntax and best practices to overload operators responsibly.

It makes your classes more intuitive to use.
''',
      exampleCode: '''
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
    return 0;
}
''',
      expectedOutput: '4 + 6i',
    ),
// 31
    Lesson(
      category: 'Advanced Topics',
      title: 'Move Constructors and Assignment',
      shortDescription: 'Efficient object transfer mechanisms.',
      detailedExplanation: '''
Move constructors and move assignment operators allow objects to transfer resources instead of copying.

This lesson discusses how to implement move semantics for better performance.

It is important in resource management and optimization.
''',
      exampleCode: '''
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
    ~Buffer() {
        delete[] data;
    }
};
int main() {
    Buffer buf1(5);
    Buffer buf2 = std::move(buf1);
    std::cout << "Buffer moved successfully." << std::endl;
    return 0;
}
''',
      expectedOutput: 'Buffer moved successfully.',
    ),

// 32
    Lesson(
      category: 'STL',
      title: 'Iterators',
      shortDescription: 'Accessing container elements.',
      detailedExplanation: '''
Iterators provide a way to traverse containers in C++ STL.

This lesson explains how to use iterators with vectors, lists, and other containers.

Iterators are key to generic programming.
''',
      exampleCode: '''
#include <iostream>
#include <vector>

int main() {
    std::vector<int> v = {10, 20, 30};
    for(auto it = v.begin(); it != v.end(); ++it) {
        std::cout << *it << " ";
    }
    std::cout << std::endl;
    return 0;
}
''',
      expectedOutput: '10 20 30 ',
    ),

// 33
    Lesson(
      category: 'Exception Handling',
      title: 'Custom Exceptions',
      shortDescription: 'Defining your own exception classes.',
      detailedExplanation: '''
Custom exceptions provide meaningful error information specific to your application.

This lesson teaches you to create classes derived from std::exception.

Proper use improves error diagnosis and handling.
''',
      exampleCode: '''
#include <iostream>
#include <exception>

class MyException : public std::exception {
public:
    const char* what() const noexcept override {
        return "My custom exception occurred";
    }
};

int main() {
    try {
        throw MyException();
    } catch (const std::exception& e) {
        std::cout << e.what() << std::endl;
    }
    return 0;
}
''',
      expectedOutput: 'My custom exception occurred',
    ),

// 34
    Lesson(
      category: 'File Handling',
      title: 'Random Access Files',
      shortDescription: 'Reading and writing at arbitrary file positions.',
      detailedExplanation: '''
Random access files allow you to read or write data at any position, enabling efficient file operations.

This lesson demonstrates seeking and positioning in files.

It is useful for databases and large files.
''',
      exampleCode: '''
#include <iostream>
#include <fstream>

int main() {
    std::fstream file("data.bin", std::ios::in | std::ios::out | std::ios::binary);
    int num = 12345;
    file.write(reinterpret_cast<char*>(&num), sizeof(num));
    file.seekg(0);
    int read_num = 0;
    file.read(reinterpret_cast<char*>(&read_num), sizeof(read_num));
    std::cout << "Number: " << read_num << std::endl;
    file.close();
    return 0;
}
''',
      expectedOutput: 'Number: 12345',
    ),

// 35
    Lesson(
      category: 'Advanced Topics',
      title: 'Multithreading with Mutex',
      shortDescription: 'Synchronizing threads.',
      detailedExplanation: '''
Mutexes prevent multiple threads from accessing shared resources simultaneously.

This lesson shows how to use std::mutex to avoid race conditions.

Synchronization is crucial for thread safety.
''',
      exampleCode: '''
#include <iostream>
#include <thread>
#include <mutex>

std::mutex mtx;
int counter = 0;

void increment() {
    for(int i = 0; i < 1000; ++i) {
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
    return 0;
}
''',
      expectedOutput: 'Counter: 2000',
    ),
// 36
    Lesson(
      category: 'Advanced Topics',
      title: 'Lambda Captures',
      shortDescription: 'Controlling captured variables in lambdas.',
      detailedExplanation: '''
Lambda expressions can capture variables from the surrounding scope.

This lesson explains capture by value, reference, and mixed captures.

Control over captures enables powerful and flexible code.
''',
      exampleCode: '''
#include <iostream>

int main() {
    int x = 10;
    auto printX = [x]() { std::cout << x << std::endl; };
    printX();
    return 0;
}
''',
      expectedOutput: '10',
    ),

// 37
    Lesson(
      category: 'Standard Library',
      title: 'Algorithms - sort and find',
      shortDescription: 'Common STL algorithms.',
      detailedExplanation: '''
STL algorithms provide powerful operations like sorting and searching.

This lesson covers std::sort and std::find usage with examples.

Using algorithms reduces boilerplate and improves readability.
''',
      exampleCode: '''
#include <iostream>
#include <vector>
#include <algorithm>

int main() {
    std::vector<int> v = {5, 3, 4, 1, 2};
    std::sort(v.begin(), v.end());
    auto it = std::find(v.begin(), v.end(), 3);
    if (it != v.end()) std::cout << "Found 3 at position " << (it - v.begin()) << std::endl;
    return 0;
}
''',
      expectedOutput: 'Found 3 at position 2',
    ),

// 38
    Lesson(
      category: 'Advanced Topics',
      title: 'Move Assignment Operator',
      shortDescription: 'Efficient resource reassignment.',
      detailedExplanation: '''
The move assignment operator transfers ownership of resources between objects.

This lesson explains how to define and use move assignment for efficient code.

It complements move constructors for full move semantics.
''',
      exampleCode: '''
#include <iostream>
#include <utility>

class Buffer {
public:
    int* data;
    size_t size;
    Buffer(size_t s) : size(s), data(new int[s]) {}
    Buffer& operator=(Buffer&& other) noexcept {
        if (this != &other) {
            delete[] data;
            data = other.data;
            size = other.size;
            other.data = nullptr;
            other.size = 0;
        }
        return *this;
    }
    ~Buffer() {
        delete[] data;
    }
};

int main() {
    Buffer buf1(5);
    Buffer buf2(10);
    buf2 = std::move(buf1);
    std::cout << "Move assignment done." << std::endl;
    return 0;
}
''',
      expectedOutput: 'Move assignment done.',
    ),

// 39
    Lesson(
      category: 'Best Practices',
      title: 'RAII (Resource Acquisition Is Initialization)',
      shortDescription: 'Automatic resource management.',
      detailedExplanation: '''
RAII is a design pattern ensuring resource allocation happens during object creation and deallocation during destruction.

This lesson explains RAII and how it helps prevent resource leaks.

It is a cornerstone of safe C++ programming.
''',
      exampleCode: '''
#include <iostream>
#include <fstream>

class FileRAII {
    std::ofstream file;
public:
    FileRAII(const std::string& filename) : file(filename) {}
    ~FileRAII() { file.close(); }
    void write(const std::string& data) { file << data; }
};

int main() {
    FileRAII file("example.txt");
    file.write("RAII in action!");
    std::cout << "Data written safely." << std::endl;
    return 0;
}
''',
      expectedOutput: 'Data written safely.',
    ),

// 40
    Lesson(
      category: 'Templates',
      title: 'Class Templates',
      shortDescription: 'Generic classes in C++.',
      detailedExplanation: '''
Class templates enable defining classes that work with any data type.

This lesson demonstrates how to write and instantiate class templates.

Templates allow highly reusable and type-safe code.
''',
      exampleCode: '''
#include <iostream>

template <typename T>
class Pair {
public:
    T first, second;
    Pair(T a, T b) : first(a), second(b) {}
    void display() {
        std::cout << first << ", " << second << std::endl;
    }
};

int main() {
    Pair<int> p(1, 2);
    p.display();
    Pair<std::string> p2("Hello", "World");
    p2.display();
    return 0;
}
''',
      expectedOutput: '''
1, 2
Hello, World
''',
    ),
// 41
    Lesson(
      category: 'Advanced Topics',
      title: 'Operator Overloading',
      shortDescription: 'Customizing operators for your classes.',
      detailedExplanation: '''
Operator overloading allows you to define custom behavior for operators (+, -, *, etc.) in your classes.

This lesson explains the syntax and best practices to overload operators responsibly.

It makes your classes more intuitive to use.
''',
      exampleCode: '''
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
    return 0;
}
''',
      expectedOutput: '4 + 6i',
    ),

// 42
    Lesson(
      category: 'Advanced Topics',
      title: 'Move Constructors and Assignment',
      shortDescription: 'Efficient object transfer mechanisms.',
      detailedExplanation: '''
Move constructors and move assignment operators allow objects to transfer resources instead of copying.

This lesson discusses how to implement move semantics for better performance.

It is important in resource management and optimization.
''',
      exampleCode: '''
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
    ~Buffer() {
        delete[] data;
    }
};
int main() {
    Buffer buf1(5);
    Buffer buf2 = std::move(buf1);
    std::cout << "Buffer moved successfully." << std::endl;
    return 0;
}
''',
      expectedOutput: 'Buffer moved successfully.',
    ),

// 43
    Lesson(
      category: 'STL',
      title: 'Iterators',
      shortDescription: 'Accessing container elements.',
      detailedExplanation: '''
Iterators provide a way to traverse containers in C++ STL.

This lesson explains how to use iterators with vectors, lists, and other containers.

Iterators are key to generic programming.
''',
      exampleCode: '''
#include <iostream>
#include <vector>

int main() {
    std::vector<int> v = {10, 20, 30};
    for(auto it = v.begin(); it != v.end(); ++it) {
        std::cout << *it << " ";
    }
    std::cout << std::endl;
    return 0;
}
''',
      expectedOutput: '10 20 30 ',
    ),

// 44
    Lesson(
      category: 'Exception Handling',
      title: 'Custom Exceptions',
      shortDescription: 'Defining your own exception classes.',
      detailedExplanation: '''
Custom exceptions provide meaningful error information specific to your application.

This lesson teaches you to create classes derived from std::exception.

Proper use improves error diagnosis and handling.
''',
      exampleCode: '''
#include <iostream>
#include <exception>

class MyException : public std::exception {
public:
    const char* what() const noexcept override {
        return "My custom exception occurred";
    }
};

int main() {
    try {
        throw MyException();
    } catch (const std::exception& e) {
        std::cout << e.what() << std::endl;
    }
    return 0;
}
''',
      expectedOutput: 'My custom exception occurred',
    ),

// 45
    Lesson(
      category: 'File Handling',
      title: 'Random Access Files',
      shortDescription: 'Reading and writing at arbitrary file positions.',
      detailedExplanation: '''
Random access files allow you to read or write data at any position, enabling efficient file operations.

This lesson demonstrates seeking and positioning in files.

It is useful for databases and large files.
''',
      exampleCode: '''
#include <iostream>
#include <fstream>

int main() {
    std::fstream file("data.bin", std::ios::in | std::ios::out | std::ios::binary);
    int num = 12345;
    file.write(reinterpret_cast<char*>(&num), sizeof(num));
    file.seekg(0);
    int read_num = 0;
    file.read(reinterpret_cast<char*>(&read_num), sizeof(read_num));
    std::cout << "Number: " << read_num << std::endl;
    file.close();
    return 0;
}
''',
      expectedOutput: 'Number: 12345',
    ),
// 46
    Lesson(
      category: 'Advanced Topics',
      title: 'Multithreading with Mutex',
      shortDescription: 'Synchronizing threads.',
      detailedExplanation: '''
Mutexes prevent multiple threads from accessing shared resources simultaneously.

This lesson shows how to use std::mutex to avoid race conditions.

Synchronization is crucial for thread safety.
''',
      exampleCode: '''
#include <iostream>
#include <thread>
#include <mutex>

std::mutex mtx;
int counter = 0;

void increment() {
    for(int i = 0; i < 1000; ++i) {
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
    return 0;
}
''',
      expectedOutput: 'Counter: 2000',
    ),

// 47
    Lesson(
      category: 'Advanced Topics',
      title: 'Lambda Captures',
      shortDescription: 'Controlling captured variables in lambdas.',
      detailedExplanation: '''
Lambda expressions can capture variables from the surrounding scope.

This lesson explains capture by value, reference, and mixed captures.

Control over captures enables powerful and flexible code.
''',
      exampleCode: '''
#include <iostream>

int main() {
    int x = 10;
    auto printX = [x]() { std::cout << x << std::endl; };
    printX();
    return 0;
}
''',
      expectedOutput: '10',
    ),

// 48
    Lesson(
      category: 'Standard Library',
      title: 'Algorithms - sort and find',
      shortDescription: 'Common STL algorithms.',
      detailedExplanation: '''
STL algorithms provide powerful operations like sorting and searching.

This lesson covers std::sort and std::find usage with examples.

Using algorithms reduces boilerplate and improves readability.
''',
      exampleCode: '''
#include <iostream>
#include <vector>
#include <algorithm>

int main() {
    std::vector<int> v = {5, 3, 4, 1, 2};
    std::sort(v.begin(), v.end());
    auto it = std::find(v.begin(), v.end(), 3);
    if (it != v.end()) std::cout << "Found 3 at position " << (it - v.begin()) << std::endl;
    return 0;
}
''',
      expectedOutput: 'Found 3 at position 2',
    ),

// 49
    Lesson(
      category: 'Advanced Topics',
      title: 'Move Assignment Operator',
      shortDescription: 'Efficient resource reassignment.',
      detailedExplanation: '''
The move assignment operator transfers ownership of resources between objects.

This lesson explains how to define and use move assignment for efficient code.

It complements move constructors for full move semantics.
''',
      exampleCode: '''
#include <iostream>
#include <utility>

class Buffer {
public:
    int* data;
    size_t size;
    Buffer(size_t s) : size(s), data(new int[s]) {}
    Buffer& operator=(Buffer&& other) noexcept {
        if (this != &other) {
            delete[] data;
            data = other.data;
            size = other.size;
            other.data = nullptr;
            other.size = 0;
        }
        return *this;
    }
    ~Buffer() {
        delete[] data;
    }
};

int main() {
    Buffer buf1(5);
    Buffer buf2(10);
    buf2 = std::move(buf1);
    std::cout << "Move assignment done." << std::endl;
    return 0;
}
''',
      expectedOutput: 'Move assignment done.',
    ),

// 50
    Lesson(
      category: 'Best Practices',
      title: 'RAII (Resource Acquisition Is Initialization)',
      shortDescription: 'Automatic resource management.',
      detailedExplanation: '''
RAII is a design pattern ensuring resource allocation happens during object creation and deallocation during destruction.

This lesson explains RAII and how it helps prevent resource leaks.

It is a cornerstone of safe C++ programming.
''',
      exampleCode: '''
#include <iostream>
#include <fstream>

class FileRAII {
    std::ofstream file;
public:
    FileRAII(const std::string& filename) : file(filename) {}
    ~FileRAII() { file.close(); }
    void write(const std::string& data) { file << data; }
};

int main() {
    FileRAII file("example.txt");
    file.write("RAII in action!");
    std::cout << "Data written safely." << std::endl;
    return 0;
}
''',
      expectedOutput: 'Data written safely.',
    ),
// 51
    Lesson(
      category: 'Best Practices',
      title: 'Const Correctness',
      shortDescription: 'Using const for safer code.',
      detailedExplanation: '''
Const correctness means using the const keyword to declare variables, parameters, and member functions that should not be modified.

This lesson covers how to apply const in function parameters and member functions to prevent unintended changes.

Using const improves code safety and enables compiler optimizations.
''',
      exampleCode: '''
#include <iostream>

void printValue(const int& value) {
    std::cout << "Value: " << value << std::endl;
}

int main() {
    const int x = 10;
    printValue(x);
    return 0;
}
''',
      expectedOutput: 'Value: 10',
    ),

// 52
    Lesson(
      category: 'Best Practices',
      title: 'Avoiding Memory Leaks',
      shortDescription: 'Proper resource management techniques.',
      detailedExplanation: '''
Memory leaks occur when dynamically allocated memory is not properly deallocated.

This lesson discusses common causes of leaks and strategies to avoid them, including smart pointers and RAII.

Preventing leaks ensures your program remains efficient and stable.
''',
      exampleCode: '''
#include <iostream>
#include <memory>

int main() {
    std::unique_ptr<int> p(new int(5));
    std::cout << *p << std::endl;
    return 0;
}
''',
      expectedOutput: '5',
    ),

// 53
    Lesson(
      category: 'Standard Library',
      title: 'Using std::array',
      shortDescription: 'Fixed-size array container.',
      detailedExplanation: '''
std::array is a container that encapsulates fixed size arrays.

This lesson shows how to declare, initialize, and access elements in std::array.

It offers safer alternatives to raw arrays.
''',
      exampleCode: '''
#include <iostream>
#include <array>

int main() {
    std::array<int, 3> arr = {1, 2, 3};
    for (auto& elem : arr) {
        std::cout << elem << " ";
    }
    std::cout << std::endl;
    return 0;
}
''',
      expectedOutput: '1 2 3',
    ),

// 54
    Lesson(
      category: 'Best Practices',
      title: 'Code Documentation',
      shortDescription: 'Writing clear code comments.',
      detailedExplanation: '''
Well-documented code improves maintainability and collaboration.

This lesson teaches techniques for writing meaningful comments and using documentation tools.

Proper documentation speeds up development and debugging.
''',
      exampleCode: '''
// This function adds two integers
int add(int a, int b) {
    return a + b;
}

int main() {
    int sum = add(3, 4);
    std::cout << "Sum is: " << sum << std::endl;
    return 0;
}
''',
      expectedOutput: 'Sum is: 7',
    ),

// 55
    Lesson(
      category: 'Advanced Topics',
      title: 'Move Semantics Deep Dive',
      shortDescription: 'Understanding rvalue references.',
      detailedExplanation: '''
Move semantics optimize resource management by distinguishing between lvalues and rvalues.

This lesson explains rvalue references, move constructors, and how they enhance performance.

It is essential for modern C++ efficiency.
''',
      exampleCode: '''
#include <iostream>
#include <vector>

int main() {
    std::vector<int> v1 = {1, 2, 3};
    std::vector<int> v2 = std::move(v1);
    std::cout << "v2 size: " << v2.size() << std::endl;
    std::cout << "v1 size after move: " << v1.size() << std::endl;
    return 0;
}
''',
      expectedOutput: '''
v2 size: 3
v1 size after move: 0
''',
    ),
// 56
    Lesson(
      category: 'Advanced Topics',
      title: 'Smart Pointer Types',
      shortDescription: 'unique_ptr, shared_ptr, and weak_ptr.',
      detailedExplanation: '''
Smart pointers manage object lifetime automatically to prevent memory leaks.

This lesson explains unique_ptr for exclusive ownership, shared_ptr for shared ownership, and weak_ptr to break reference cycles.

Understanding these helps write safer C++ code.
''',
      exampleCode: '''
#include <iostream>
#include <memory>

int main() {
    std::shared_ptr<int> sp1 = std::make_shared<int>(10);
    std::cout << *sp1 << std::endl;
    return 0;
}
''',
      expectedOutput: '10',
    ),

// 57
    Lesson(
      category: 'Best Practices',
      title: 'Constexpr Functions',
      shortDescription: 'Compile-time constant expressions.',
      detailedExplanation: '''
Constexpr functions can be evaluated at compile time, allowing for better optimization.

This lesson covers how to define constexpr functions and their limitations.

Using constexpr improves performance and enables metaprogramming.
''',
      exampleCode: '''
#include <iostream>

constexpr int square(int x) {
    return x * x;
}

int main() {
    constexpr int result = square(5);
    std::cout << result << std::endl;
    return 0;
}
''',
      expectedOutput: '25',
    ),

// 58
    Lesson(
      category: 'Templates',
      title: 'Class Template Specialization',
      shortDescription: 'Custom behavior for specific types.',
      detailedExplanation: '''
Template specialization allows customizing template implementations for specific types.

This lesson shows how to specialize class templates to handle types differently.

Specialization enhances template flexibility.
''',
      exampleCode: '''
#include <iostream>

template<typename T>
class Printer {
public:
    void print() {
        std::cout << "Generic Printer" << std::endl;
    }
};

template<>
class Printer<int> {
public:
    void print() {
        std::cout << "Integer Printer" << std::endl;
    }
};

int main() {
    Printer<double> p1;
    p1.print();
    Printer<int> p2;
    p2.print();
    return 0;
}
''',
      expectedOutput: '''
Generic Printer
Integer Printer
''',
    ),

// 59
    Lesson(
      category: 'Standard Library',
      title: 'Using std::unordered_map',
      shortDescription: 'Hash table for key-value pairs.',
      detailedExplanation: '''
std::unordered_map offers average constant time complexity for insertions and lookups.

This lesson explains how to use unordered_map for fast access with hash keys.

It is suitable for performance-critical applications.
''',
      exampleCode: '''
#include <iostream>
#include <unordered_map>

int main() {
    std::unordered_map<std::string, int> ages;
    ages["Alice"] = 30;
    ages["Bob"] = 25;
    std::cout << "Alice is " << ages["Alice"] << " years old." << std::endl;
    return 0;
}
''',
      expectedOutput: 'Alice is 30 years old.',
    ),

// 60
    Lesson(
      category: 'Advanced Topics',
      title: 'CRTP (Curiously Recurring Template Pattern)',
      shortDescription: 'Compile-time polymorphism technique.',
      detailedExplanation: '''
CRTP uses template inheritance to achieve polymorphism without runtime overhead.

This lesson demonstrates CRTP for static polymorphism and code reuse.

It is useful in high-performance scenarios.
''',
      exampleCode: '''
#include <iostream>

template <typename Derived>
class Base {
public:
    void interface() {
        static_cast<Derived*>(this)->implementation();
    }
};

class Derived : public Base<Derived> {
public:
    void implementation() {
        std::cout << "Derived implementation" << std::endl;
    }
};

int main() {
    Derived d;
    d.interface();
    return 0;
}
''',
      expectedOutput: 'Derived implementation',
    ),

    // Add more lessons here...

  ];

  Future<void> loadLessons() async {
    // Placeholder for async loading if needed in future
    notifyListeners();
  }

  List<String> getCategories() {
    final categoriesSet = _lessons.map((l) => l.category).toSet();
    return categoriesSet.toList();
  }

  List<Lesson> getLessonsByCategory(String category) {
    return _lessons.where((lesson) => lesson.category == category).toList();
  }

  Lesson? getLessonByTitle(String title) {
    try {
      return _lessons.firstWhere((lesson) => lesson.title == title);
    } catch (_) {
      return null;
    }
  }
  List<String> getAllLessonTitles() {
    return _lessons.map((lesson) => lesson.title).toList();
  }

}
