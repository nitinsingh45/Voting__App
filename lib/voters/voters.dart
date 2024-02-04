import 'package:flutter/material.dart';

class VotersScreen extends StatelessWidget {
  const VotersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voters Screen'),
        backgroundColor: Colors.green.shade600,
      ),
    );
  }
}
