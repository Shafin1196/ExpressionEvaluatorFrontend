class Data{
  final String expression;
  final String result;
  final DateTime time;

  Data(
    {
    required this.expression, 
    required this.result, 
    required this.time
  }
  );
  Map<String,dynamic> toJson()=> {
    'expression': expression,
    'result': result,
    'time': time.toIso8601String(),
  };
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      expression: json['expression'],
      result: json['result'],
      time: DateTime.parse(json['time']),
    );
  }
}