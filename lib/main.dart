import 'package:expression_evaluator/screens/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main()=> runApp(const App());
final theme=ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor:  const Color.fromARGB(255, 131, 57, 0),
    brightness: Brightness.dark,
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);
class App extends StatelessWidget{
  const App({super.key});
  @override
  Widget build(BuildContext context)=> MaterialApp(
    title: "Expression Evaluator",
    debugShowCheckedModeBanner: false,
    theme: theme,
    home:TabsScreen(),
  );
}