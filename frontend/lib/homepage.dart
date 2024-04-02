import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Welcome to Minimalistic Web Page',
                style: TextStyle(fontSize: 24.0),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'This is a simple Flutter web page',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Click Me'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
