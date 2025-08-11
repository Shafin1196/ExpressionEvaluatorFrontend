import 'package:expression_evaluator/services/api.dart';
import 'package:flutter/material.dart';

class Expression extends StatefulWidget{
  const Expression({super.key});

  @override
  State<Expression> createState() {
    return _ExpressionState();
  }

}

class _ExpressionState extends State<Expression> {
  final TextEditingController _controller = TextEditingController();
  var _outPut="";
  var isLoading = false;
  bool validExpression()
  {
    final text = _controller.text;
    // Add your validation logic here
    for(var i = 0; i < text.length; i++) {
      if(!RegExp(r'^[0-9+\-*/()\s]+$').hasMatch(text[i])) {
        return false;
      }
    }
    return true;
  }
  void submitExpression(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    if (validExpression()&& _controller.text.isNotEmpty) {
      _outPut= await ApiService.ans(_controller.text);
      setState(() {
        isLoading = false;
      });
      showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Result',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold
        ),
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
              Icon(Icons.error,color: Theme.of(context).colorScheme.inversePrimary,),
              SizedBox(width: 8),
              Text('Invalid expression',style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold
                ),
                ),
            ],
          ),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
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
            fontWeight: FontWeight.bold
          ),
          minLines: 3,
           decoration: InputDecoration(
             labelText: 'Enter expression',
             border: OutlineInputBorder(),
             hintText: 'e.g. 2 + 2 * 3',
             
           ),
         ),
         SizedBox(height: 20,),
         ElevatedButton(
           onPressed: () => submitExpression(context),
           child: isLoading
               ? SizedBox(
                height: 15,
                width: 15,
                 child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  strokeWidth: 4.0,
                  ),
               )
               : Text('Evaluate',style: TextStyle(
                 
                 fontSize: 20,
                 fontWeight: FontWeight.bold
               )),
         ),
        ],
      ),
    );
  }
}