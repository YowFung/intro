import 'package:flutter/material.dart';
import 'advanced_demo.dart';
import 'general_demo.dart';
import 'nested_demo.dart';

void main() {
  return runApp(MaterialApp(
    title: 'Intro Demo',
    routes: {
      "home": (context) => const MyHomePage(),
      "general": (context) => const GeneralDemoPage(),
      "nested": (context) => const NestedDemoPage(),
      "advanced": (context) => const AdvancedDemoPage(),
    },
    initialRoute: "home",
  ));
}

class MyHomePage extends StatelessWidget {

  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Intro Demo Home Page")),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "general"),
              child: const Text("General Usage"),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "nested"),
              child: const Text("Nested Usage"),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "advanced"),
              child: const Text("Advanced Usage"),
            ),
          ],
        ),
      ),
    );
  }
}
