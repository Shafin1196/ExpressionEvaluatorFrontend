import 'dart:convert';
import 'package:expression_evaluator/models/expressionModels.dart';
import 'package:expression_evaluator/services/api.dart';
import 'package:expression_evaluator/widget/history.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Expression extends StatefulWidget {
  const Expression({super.key});

  @override
  State<Expression> createState() {
    return _ExpressionState();
  }
}

class _ExpressionState extends State<Expression> {
  final List<Data> history = [];
  var _controller = TextEditingController();
  var _outPut = "";
  var isLoading = false;
  bool validExpression() {
    final text = _controller.text;
    // Add your validation logic here
    for (var i = 0; i < text.length; i++) {
      if (!RegExp(r'^[0-9+\-*/()^\s]+$').hasMatch(text[i])) {
        return false;
      }
    }
    return true;
  }

  void submitExpression(BuildContext context, String message) async {
    setState(() {
      isLoading = true;
    });
    if (validExpression() && _controller.text.isNotEmpty) {
      _outPut = await ApiService.ans(_controller.text);
      final newData = Data(
          expression: _controller.text, result: _outPut, time: DateTime.now());
      setState(() {
        history.add(newData);
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Result',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${_controller.text} = ${_outPut}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
      await saveHistory();
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              SizedBox(width: 8),
              Text(
                message.isEmpty ? "Invalid Input" : message,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }
  }

  Future<void> saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = history.map((d) => d.toJson()).toList();
    prefs.setString('history', jsonEncode(historyJson));
  }

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyString = prefs.getString('history');
    if (historyString != null) {
      final List<dynamic> decoded = jsonDecode(historyString);
      setState(() {
        history.clear();
        history.addAll(decoded.map((e) => Data.fromJson(e)));
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    final sortedHistory = [...history]
      ..sort((a, b) => b.time.compareTo(a.time));

    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: _controller,
            maxLines: null,
            keyboardType: TextInputType.text,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            minLines: 3,
            decoration: InputDecoration(
              labelText: 'Enter expression',
              border: OutlineInputBorder(),
              hintText: 'e.g. 2 + ( 2 * 3 )',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () => submitExpression(context, ""),
            child: isLoading
                ? SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      strokeWidth: 4.0,
                    ),
                  )
                : Text('Evaluate',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Theme.of(context).colorScheme.error,
            thickness: 2,
            height: 20,
          ),
          Row(
            children: [
              Icon(Icons.history),
              SizedBox(
                width: 15,
              ),
              Text(
                "History",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondaryContainer
                          .withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Theme.of(context).colorScheme.error,
            thickness: 2,
            height: 20,
          ),
          history.isEmpty
              ? Column(
                  children: [
                    Text(
                      "No history here!",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer
                                .withOpacity(0.8),
                          ),
                    ),
                    SizedBox(height: 20,),
                    Image.asset("assets/images/history.gif",
                    
                    ),
                  ],
                )
              : Column(
                  children: sortedHistory
                      .map(
                        (data) => Dismissible(
                          key: ValueKey(data.time.toIso8601String()),
                          direction: DismissDirection.horizontal,
                          onDismissed: (direction) {
                            setState(() {
                              history.remove(data);
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.error,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "Data is removed",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                          },
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _controller = TextEditingController(
                                    text: data.expression);
                              });
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: History(history: data),
                          ),
                        ),
                      )
                      .toList(),
                ),
        ],
      ),
    );
  }
}
