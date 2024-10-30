// Importa Firebase Firestore para interactuar con la base de datos
import 'package:cloud_firestore/cloud_firestore.dart';

// Importa archivos de datos, pantallas y servicios que se usan en la aplicación
import 'package:feedcards/Data/data.dart';
import 'package:feedcards/screens/NewPublishForm.dart';
import 'package:feedcards/screens/calendar_screen.dart';
import 'package:feedcards/screens/newtaks_screen.dart';
import 'package:feedcards/screens/profile_screen.dart';
import 'package:feedcards/screens/settings.dart';
import 'package:feedcards/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:feedcards/widgets/listcard.dart';

// Define el widget `HomeScreen` como un `StatefulWidget` para gestionar el estado de la pantalla principal
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// Clase privada `_HomeScreenState` que contiene el estado de `HomeScreen`
class _HomeScreenState extends State<HomeScreen> {
  // Variable para mantener la página actual seleccionada en la barra de navegación
  int _paginaActual = 0;

  // Clave única para el widget `ListCard`, necesaria para refrescar el contenido
  Key _listKey = UniqueKey();

  // Lista de widgets que representan las diferentes pantallas accesibles desde `HomeScreen`
  final List<Widget> _paginas = [
    ListCard(key: UniqueKey()), // Pantalla de inicio con una lista de tarjetas
    ProfileScreen(), // Pantalla de perfil
    CalendarScreen(
        key: CalendarScreen
            .calendarKey), // Pantalla de calendario con una clave global
    Settings_screen(), // Pantalla de configuración
  ];

  // Función que se llama al presionar el botón flotante (FAB)
  void _onFloatingActionButtonPressed() async {
    print(
        "Botón flotante presionado en página $_paginaActual"); // Imprime en la consola para depuración

    // Verifica si la página actual es la de calendario
    if (_paginaActual == 2) {
      // Abre la pantalla `NewTaskScreen` para agregar una nueva tarea
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewTaskScreen(selectedDate: DateTime.now()),
        ),
      );

      // Si se creó una nueva tarea, recarga las tareas en la pantalla de calendario
      if (result == true && CalendarScreen.calendarKey.currentState != null) {
        CalendarScreen.calendarKey.currentState!.reloadTasks();
      }
    } else {
      // Si la página actual no es la de calendario, abre el formulario `NewPublishForm` para crear una nueva publicación
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewPublishForm()),
      );

      // Si se creó una nueva publicación, refresca el widget `ListCard`
      if (result == true) {
        setState(() {
          _listKey =
              UniqueKey(); // Genera una nueva clave única para `ListCard`
        });
      }
    }
  }

  // Método `build` que define la interfaz de usuario del widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Cards'), // Título de la barra de la aplicación
        backgroundColor: Colors.green, // Color de fondo de la barra
        foregroundColor: Colors.white, // Color del texto en la barra
      ),
      body: IndexedStack(
        index: _paginaActual, // Indica qué página está activa
        children: _paginas, // Muestra las páginas en la lista `_paginas`
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: _paginaActual == 2
            ? "calendar_fab"
            : "home_fab", // Define un `heroTag` único para el FAB
        onPressed:
            _onFloatingActionButtonPressed, // Llama a la función al presionar el FAB
        child: const Icon(Icons.add), // Icono del FAB
        backgroundColor: Colors.green, // Color de fondo del FAB
        foregroundColor: Colors.white, // Color del icono del FAB
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            _paginaActual, // Índice de la pestaña actualmente seleccionada
        onTap: (index) {
          setState(() {
            _paginaActual =
                index; // Actualiza la página actual al cambiar de pestaña
          });
        },
        items: const <BottomNavigationBarItem>[
          // Elementos de la barra de navegación en la parte inferior
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Home'), // Opción de inicio
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Perfil'), // Opción de perfil
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Calendario'), // Opción de calendario
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings') // Opción de configuración
        ],
        backgroundColor: const Color.fromARGB(
            255, 255, 252, 252), // Color de fondo de la barra de navegación
        selectedItemColor: Colors.green, // Color del elemento seleccionado
        unselectedItemColor:
            Colors.black, // Color de los elementos no seleccionados
      ),
    );
  }
}
