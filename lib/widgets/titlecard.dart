import 'package:feedcards/screens/NewPublishForm.dart';
import 'package:flutter/material.dart';

class Titlecard extends StatelessWidget {
  const Titlecard({super.key, required this.name, required this.documentId});

  final String name;
  final String documentId; // El ID de la publicación

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment
          .spaceBetween, // Asegura que el icono esté a la derecha
      children: [
        CircleAvatar(
          child: Text("Y"),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color.fromARGB(255, 22, 22, 22),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewPublishForm(
                  documentId:
                      documentId, // Pasa el ID de la publicación a editar
                ),
              ),
            );
          },
          child: CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.edit, color: Colors.black),
          ),
        )
      ],
    );
  }
}
