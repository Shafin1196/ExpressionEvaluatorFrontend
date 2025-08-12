import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl="https://shafin714.pythonanywhere.com/api/parse/";
  static Future<String> ans(String expression) async{
    try{
      final response= await http.post(
        Uri.parse("https://shafin714.pythonanywhere.com/api/parse/"),
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
  // Define your API methods here
}