import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Business Card Creator'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pushNamed('ConfigPage'),
          child: const Text('Start'),
        ),
      ),
    );
  }
}
