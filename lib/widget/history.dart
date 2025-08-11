import 'package:expression_evaluator/models/expressionModels.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  const History({super.key, required this.history});
  final Data history;
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final dateFormate = DateFormat('yyyy-MM-dd HH:mm:ss');
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 15),
      elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
                children: [
          ListTile(
            title:
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text("${widget.history.expression} = ${widget.history.result}",
                  textAlign: TextAlign.center,
                  ),
                ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.alarm),
              SizedBox(width: 10,),
              Text(dateFormate.format(widget.history.time),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color:Theme.of(context).colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.bold,
              ),
              ),
            ],
          ),
                ],
              ),
        ));
  }
}
