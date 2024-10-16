import 'package:feedcards/screens/NewPublishForm.dart';
import 'package:feedcards/widgets/listcard.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Cards'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListCard(),
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewPublishForm()), // Abrir el formulario
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
    );
  }
}
