import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/cancel_task_list_screen.dart';
import 'package:task_manager/ui/screens/completed_task_list_screen.dart';
import 'package:task_manager/ui/screens/new_task_list_screen.dart';
import 'package:task_manager/ui/screens/progress_task_list_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  static const String name = '/home';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _seletedIndex = 0;
  List<Widget> _screen = const [
    NewTaskListScreen(),
    ProgressTaskListScreen(),
    CompletdTaskListScreen(),
    CancelTaskListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_seletedIndex],
      bottomNavigationBar: NavigationBar(
          selectedIndex: _seletedIndex,
          onDestinationSelected: (int index) {
            _seletedIndex = index;
            setState(() {});
          },
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.new_label_outlined), label: 'new'),
            NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
            NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
            NavigationDestination(
                icon: Icon(Icons.cancel_outlined), label: 'Cancel'),
          ]),
    );
  }
}
