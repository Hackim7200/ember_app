import 'package:ember/features/event/event_screen.dart';

import 'package:flutter/material.dart';
import 'package:ember/features/todo/todo_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [TodoScreen(), EventScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.list),
            label: 'Todo',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Event'),
        ],
      ),
    );
  }
}
