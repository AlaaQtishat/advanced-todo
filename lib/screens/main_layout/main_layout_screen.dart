import 'package:flutter/material.dart';
import 'package:todo/screens/tasks_screen/tasks_screen.dart';
import 'package:todo/screens/search_screen/search_screen.dart';
import 'package:todo/screens/stats_screen/stats_screen.dart';
import 'package:todo/screens/more_screen/more_screen.dart';
import 'package:todo/screens/main_layout/widgets/customized_bottom_nav_bar.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  final List<Widget> _screens = [
    const TasksScreen(),
    const SearchScreen(),
    const StatsScreen(),
    const MoreScreen(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: CustomizedBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
