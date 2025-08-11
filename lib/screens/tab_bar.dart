import 'package:expression_evaluator/widget/about.dart';
import 'package:expression_evaluator/widget/expression.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget{
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }

}
class _TabsScreenState extends State<TabsScreen> {
  Widget content=Expression();
  var barTitle="Evaluator";
  var _index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(barTitle,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        ),
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.black12,
      ),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
            if (_index == 0) {
              content = Expression();
              barTitle = "Evaluator";
            } else {
              content = About();
              barTitle = "About";
            }
          });
        },
        elevation: 10,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        iconSize: 40,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Evaluator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}