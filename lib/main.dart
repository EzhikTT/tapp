import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tapp/models/booking.dart';
import 'package:tapp/screens/booking.dart';
import 'package:tapp/screens/calendar.dart';
import 'package:tapp/screens/list.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BookingModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Map<int, Color> color = {
    50: Colors.black,
    100: Colors.black,
    200: Colors.black,
    300: Colors.black,
    400: Colors.black,
    500: Colors.black,
    600: Colors.black,
    700: Colors.black,
    800: Colors.black,
    900: Colors.black,
  };

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Бронирование места в офисе',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF000000, color),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MainScreen(),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => MainScreen(),
        '/calendar': (BuildContext context) => CalendarScreen(),
        '/booking': (BuildContext context) => BookingScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Бронирование места в офисе'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: '')
        ],
        currentIndex: _currentTab,
        onTap: (int index) => setState(() {
          _currentTab = index;
        }),
      ),
      body: ListScreen(),
    );
  }
}
