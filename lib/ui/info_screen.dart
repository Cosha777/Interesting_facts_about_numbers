import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) => Navigator.pop(context),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white24,
              border: Border.all(),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text, style: const TextStyle(color: Colors.white70)),
            ),
          ),
        ),
      ),
    );
  }
}
