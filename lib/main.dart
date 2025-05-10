import 'package:flutter/material.dart';
import 'package:imagegenerator/feature/prompt/ui/create_prompt_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.grey.shade900, elevation: 0),
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.grey.shade900),
        home: CreatePromptScreen());
  }
}
