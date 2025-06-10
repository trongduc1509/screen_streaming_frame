import 'dart:isolate';
import 'package:flutter/material.dart';

int computeFibonacci(int calNum) {
  int fibonacci(int n) {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
  }

  return fibonacci(calNum);
}

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<int> _indices = [];
  bool _isProcessing = false;
  String _result = 'Waiting for result...';

  @override
  void initState() {
    super.initState();
    // List is initially empty, do not start any computation here
  }

  Future<int> _computeFibonacciIsolate(int n) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_fibonacciIsolateEntry, [receivePort.sendPort, n]);
    final result = await receivePort.first;
    receivePort.close();
    return result as int;
  }

  static void _fibonacciIsolateEntry(List<dynamic> args) {
    final SendPort sendPort = args[0];
    final int n = args[1];
    int fibonacci(int n) {
      if (n <= 1) return n;
      return fibonacci(n - 1) + fibonacci(n - 2);
    }

    final result = fibonacci(n);
    sendPort.send(result);
  }

  void _resetState() {
    setState(() {
      _indices.clear();
      _result = 'Waiting for result...';
    });
  }

  void _startFibonacci40() async {
    final result = await _computeFibonacciIsolate(40);
    setState(() {
      _result = "Fibonacci result: $result";
    });
  }

  void _startFibonacciSequence() async {
    setState(() {
      _indices.clear();
      _isProcessing = true;
      //_result = 'Calculating...';
    });
    for (int i = 0; i <= 40; i++) {
      await _computeFibonacciIsolate(i);
      setState(() {
        _indices.add(i); // or you can store fib if you want
      });
      await Future.delayed(Duration(milliseconds: 50)); // for smoother UI
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
    setState(() {
      _isProcessing = false;
      // _result = 'Done!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Isolate + UI Example")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(_result, style: TextStyle(fontSize: 20)),
          ),
          ElevatedButton(
            onPressed: _isProcessing
                ? null
                : () {
                    _resetState();
                    _startFibonacciSequence();
                    _startFibonacci40();
                  },
            child: Text('Test Isolate'),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _indices.length,
              itemBuilder: (_, index) => ListTile(
                title: Text("Item ${_indices[index]}"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
