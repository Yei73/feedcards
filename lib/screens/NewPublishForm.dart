import 'package:flutter/material.dart';
import 'package:feedcards/services/firebase_service.dart'; // Asegúrate de importar tu servicio de Firebase

class NewPublishForm extends StatefulWidget {
  final String? documentId; // Recibe el ID de la publicación para editar

  const NewPublishForm({Key? key, this.documentId}) : super(key: key);

  @override
  _NewPublishFormState createState() => _NewPublishFormState();
}

class _NewPublishFormState extends State<NewPublishForm> {
  final _formKey = GlobalKey<FormState>();
  String publisher = '';
  String description = '';
  String publishimage = '';
  bool isLoading = false; // Para mostrar el estado de carga

  @override
  void initState() {
    super.initState();
    if (widget.documentId != null) {
      // Si estamos en modo edición, cargamos los datos de Firebase
      loadPublishData(widget.documentId!);
    }
  }

  // Función para cargar los datos de la publicación en modo edición
  void loadPublishData(String documentId) async {
    setState(() {
      isLoading = true; // Mostrar indicador de carga
    });

    try {
      // Obtener los datos de Firebase usando el documentId
      final doc = await getPublishById(documentId);
      if (doc.exists) {
        setState(() {
          publisher = doc['publisher'] ?? '';
          description = doc['description'] ?? '';
          publishimage = doc['publishimage'] ?? '';
        });
      }
    } catch (e) {
      print("Error al cargar los datos: $e");
    } finally {
      setState(() {
        isLoading = false; // Ocultar indicador de carga
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.documentId != null
            ? 'Editar Publicación'
            : 'Nueva Publicación'),
      ),
      body: isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Mostrar indicador de carga si estamos cargando datos
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: publisher,
                      decoration: const InputDecoration(
                          labelText: 'Nombre', prefixIcon: Icon(Icons.person)),
                      onSaved: (value) {
                        publisher = value ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese un nombre';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: description,
                      decoration: InputDecoration(
                          labelText: 'Descripción',
                          prefixIcon: Icon(Icons.text_fields)),
                      onSaved: (value) {
                        description = value ?? '';
                      },
                    ),
                    TextFormField(
                      initialValue: publishimage,
                      decoration: InputDecoration(
                          labelText: 'URL de la Imagen',
                          prefixIcon: Icon(Icons.image)),
                      onSaved: (value) {
                        publishimage = value ?? '';
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          if (widget.documentId != null) {
                            // Si estamos editando, actualizamos la publicación existente
                            updatePublish(widget.documentId!, {
                              'publisher': publisher,
                              'description': description,
                              'publishimage': publishimage,
                            });
                          } else {
                            // Si no hay documentId, estamos creando una nueva publicación
                            addPublish({
                              'publisher': publisher,
                              'description': description,
                              'publishimage': publishimage,
                            });
                          }

                          Navigator.pop(context,
                              true); // Volver a la pantalla anterior y devolver "true" para actualizar la lista
                        }
                      },
                      child: Text(
                          widget.documentId != null ? 'Actualizar' : 'Guardar'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
