import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedcards/Data/data.dart';
import 'package:feedcards/screens/NewPublishForm.dart';
import 'package:feedcards/screens/calendar_screen.dart';
import 'package:feedcards/screens/profile_screen.dart';
import 'package:feedcards/screens/settings.dart';
import 'package:feedcards/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:feedcards/widgets/listcard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _paginaActual = 0;
  List<Map<String, dynamic>> listData = []; // Declaración de listData

  List<Widget> _paginas = [
    ListCard(),
    ProfileScreen(),
    CalendarScreen(),
    Settings_screen(),
  ];

  // Para manejar la actualización de la lista
  void refreshList() async {
    // Llamar al servicio de Firebase para obtener los datos actualizados
    final updatedList =
        await getPublish(); // Reemplaza con tu función para obtener datos
    setState(() {
      // Actualizar los datos que se muestran en la UI
      listData = updatedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Cards'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: _paginas[_paginaActual], // ListCard(), // La lista de publicaciones
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Abrimos el formulario y esperamos el resultado
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewPublishForm()),
          );

          // Si el resultado es "true", recargar la lista
          if (result == true) {
            refreshList(); // Llama a setState para recargar la lista
          }
        },
        child: const Icon(Icons.add), // Icono del botón flotante
        backgroundColor: Colors.green, // Color del botón
        foregroundColor: Colors.white, // Color del ícono dentro del botón
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _paginaActual = index;
          });
        },
        currentIndex: _paginaActual,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'Calendario'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
        ],
        backgroundColor: const Color.fromARGB(255, 255, 252, 252),
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
