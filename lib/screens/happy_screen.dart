import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class HappyScreen extends StatefulWidget {
  const HappyScreen({super.key});

  @override
  State<HappyScreen> createState() => _HappyScreenState();
}

class _HappyScreenState extends State<HappyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Happy Happy!'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            FirebaseAnalytics.instance.logEvent(name: 'Happy');
          },
          child: const Text('I am happy!'),
        ),
      ),
    );
  }
}
