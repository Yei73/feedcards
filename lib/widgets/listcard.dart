import 'package:feedcards/services/firebase_service.dart';
import 'package:feedcards/widgets/card.dart';
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          getPublish(), // Llamada al método que obtiene los datos de Firebase
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child:
                  CircularProgressIndicator()); // Muestra un indicador de carga
        } else if (snapshot.hasError) {
          return const Center(
              child: Text(
                  "Error al cargar los datos")); // Muestra un mensaje de error
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text(
                  "No hay publicaciones disponibles")); // Muestra un mensaje si no hay datos
        }

        List publish = snapshot.data!; // Obtener los datos de la respuesta
        return ListView.builder(
          itemCount: publish.length,
          itemBuilder: (context, index) {
            return card(
                data: publish[
                    index]); // Pasar los datos de Firebase a cada tarjeta
          },
        );
      },
    );
  }
}
