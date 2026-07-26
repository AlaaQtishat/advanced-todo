import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/constants/app_themes.dart';
import 'package:todo/core/providers/task_provider.dart';
import 'package:todo/core/providers/theme_provider.dart';
import 'package:todo/screens/todo_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (context) => TaskProvider()
            ..loadTasks(), //this is same as: var taskProvider = TaskProvider(); taskProvider.loadTasks(); return taskProvider;
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      home: TodoScreen(),
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeProvider.currentTheme,
    );
  }
}
