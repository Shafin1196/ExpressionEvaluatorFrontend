import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static final String operandUrl="https://shafin714.pythonanywhere.com/api/operand/";
  static final String evaluatorUrl="https://shafin714.pythonanywhere.com/api/parse/";
  static Future<String> ans(String expression) async{
    try{
      final response= await http.post(
        Uri.parse(evaluatorUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"expression": expression}),
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        return double.parse(data['result']).toStringAsFixed(2);
      }
      return 'Error: ${response.statusCode}';
    } catch (e) {
      return 'Error: $e';
    }
  }
  static Future<String> operand(String expression) async{
    try{
      final response= await http.post(
        Uri.parse(operandUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"expression": expression}),
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        return data['result'].toString();
      }
      return 'Error: ${response.statusCode}';
    } catch (e) {
      return 'Error: $e';
    }
  }
  // Define your API methods here
}