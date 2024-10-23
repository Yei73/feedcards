import 'package:feedcards/widgets/bottomscard.dart';
import 'package:feedcards/widgets/descriptioncard.dart';
import 'package:feedcards/widgets/imagecard.dart';
import 'package:feedcards/widgets/titlecard.dart';
import 'package:flutter/material.dart';

class card extends StatelessWidget {
  const card({super.key, required this.data, required this.documentId});

  final Map<String, dynamic> data; // Cambiar a Map<String, dynamic>
  final String documentId; // El ID del documento en Firebase

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      height: 350,
      decoration: const BoxDecoration(color: Colors.white),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Titlecard(
                name: data["publisher"] ?? "Sin nombre",
                documentId: documentId,
              ),
            ),
            descriptioncard(
                description: data["description"] ?? "Sin descripción"),
            imagecard(imagen: data["publishimage"] ?? ""),
            Container(
              child: bottomscard(),
            )
          ],
        ),
      ),
    );
  }
}
