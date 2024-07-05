import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

enum CalculatorMode {
  scientific,
  regular;
}

class CalculatorController extends GetxController {
  final mode = CalculatorMode.scientific.obs;
  final Rx<String> history = ''.obs;
  final Rx<String> expression = ''.obs; //expression
  final Rx<double> result = 0.0.obs; //result

  //
  final _parser = Parser(); //for parsing the math expressions

  void changeMode () {
    mode.value = mode.value == CalculatorMode.scientific
                      ? CalculatorMode.regular
                      : CalculatorMode.scientific;
  }

  int get columns => mode.value == CalculatorMode.scientific ? 5 : 4;

  List<(
  Widget,
  String? Function(String? expression, CalculatorController controller),
  bool isNumber
)> get keys => mode.value == CalculatorMode.scientific ? scientificKeys: regularKeys;

  double _evaluate(String? expression){
  	if(expression != null) {
  	Expression exp = _parser.parse(expression);
	return exp.evaluate(EvaluationType.REAL, ContextModel());
  	}
  	//else 
  	return 0;
  }
  void clear() {
  	history.value = '';
  	expression.value = ''; //clear the calculator
  	result.value = 0.0;
  }

  void evaluate() {
  	try {

  	  result.value = _evaluate(expression.value);
  	  history.value= expression.value;
  	  expression.value = '';

  	} catch (_) {
  	  //if expression is invalid do something
      history.value = 'Invalid expression syntax = ${expression.value}';
      expression.value = '';
  	}
  }

  void type(String? Function(String?, CalculatorController) compose) {
    //composes the expression as the user types in the keyboard
    if(result.value > 0) {
      // ignore: prefer_interpolation_to_compose_strings
      expression.value = '${result.value}' + (compose(expression.value, this) ?? '');
      result.value = 0;
      }else {
  	   expression.value = compose(expression.value, this) ?? '';
  }
  }


  final scientificKeys = <(
  Widget,
  String? Function(String? expression, CalculatorController controller),
  bool isNumber
)>[
  (const Text('sin'), (expr, _) => '${expr ?? ''} sin(', false),
  (const Text('cos'), (expr, _) => '${expr ?? ''} cos(', false),
  (const Text('tan'), (expr, _) => '${expr ?? ''} tan(', false),
  (const Text('ln'), (expr, _) => '${expr ?? ''} ln(', false),
  (const Text('log'), (expr, _) => '${expr ?? ''} log(', false),
  (const Text('Rad'), (expr, _) => expr, false),
  (const Text('sqrt'), (expr, _) => expr, false),
  (const Text('('), (expr, _) => '${expr ?? ''}(', false),
  (const Text('%'), (expr, _) => '${expr ?? ''} % ', false),
  (const Text('/'), (expr, _) => '${expr ?? ''} / ', false),
  (const Text('pi'), (expr, _) => '${expr ?? ''}3.142', false),
  (const Text('7'), (expr, _) => '${expr ?? ''}7', true),
  (const Text('8'), (expr, _) => '${expr ?? ''}8', true),
  (const Text('9'), (expr, _) => '${expr ?? ''}9', true),
  (const Text('x'), (expr, _) => '${expr ?? ''} * ', false),
  (const Text('e'), (expr, _) => '${expr ?? ''}2.71828', false),
  

  (const Text('4'), (expr, _) => '${expr ?? ''}4', true),
  (const Text('5'), (expr, _) => '${expr ?? ''}5', true),
  (const Text('6'), (expr, _) => '${expr ?? ''}6', true),
  (const Text('-'), (expr, _) => '${expr ?? ''} - ', false),
  (const Text('x^2'), (expr, _) => '${expr ?? ''} ^2', false),
  (const Text('1'), (expr, _) => '${expr ?? ''}1', true),
  (const Text('2'), (expr, _) => '${expr ?? ''}2', true),
  (const Text('3'), (expr, _) => '${expr ?? ''}3', true),
  (const Text('+'), (expr, _) => '${expr ?? ''} + ', false),
  (const Text('x^y'), (expr, _) => '${expr ?? ''} ^', false),
  //(Text('+\n-'), (expr, _) => expr, false),
  (const Text(')'), (expr, _) => '${expr ?? ''})', false),
  (const Text('0'), (expr, _) => '${expr ?? ''}0', false),
  (const Text('.'), (expr, _) => '${expr ?? ''}.', false),
  (
    const Text('='),
    (_, controller) {
      controller.evaluate(); //evaluate the exprression
      return null;
    },
    false
  )
];

final regularKeys = <(
  Widget,
  String? Function(String? exprression, CalculatorController controller),
  bool isNumber
)>[
  //(Text('sin'), (expr, _) => '${expr ?? ''} sin(', false),
  //(Text('cos'), (expr, _) => '${expr ?? ''} cos(', false),
  //(Text('tan'), (expr, _) => '${expr ?? ''} tan(', false),
  //(Text('ln'), (expr, _) => '${expr ?? ''} ln(', false),
  //(Text('log'), (expr, _) => '${expr ?? ''} log(', false),
  //(Text('Rad'), (expr, _) => expr, false),
  (const Text('sqrt'), (expr, _) => expr, false),
  (const Text('('), (expr, _) => '${expr ?? ''}(', false),
  (const Text('%'), (expr, _) => '${expr ?? ''} % ', false),
  (const Text('/'), (expr, _) => '${expr ?? ''} / ', false),
  //(Text('pi'), (expr, _) => '${expr ?? ''} 3.142', false),
  (const Text('7'), (expr, _) => '${expr ?? ''}7', true),
  (const Text('8'), (expr, _) => '${expr ?? ''}8', true),
  (const Text('9'), (expr, _) => '${expr ?? ''}9', true),
  (const Text('x'), (expr, _) => '${expr ?? ''} * ', false),
  
  (const Text('4'), (expr, _) => '${expr ?? ''}4', true),
  (const Text('5'), (expr, _) => '${expr ?? ''}5', true),
  (const Text('6'), (expr, _) => '${expr ?? ''}6', true),
  (const Text('-'), (expr, _) => '${expr ?? ''} - ', false),
  //(Text('x^2'), (expr, _) => '${expr ?? ''} ^2', false),
  (const Text('1'), (expr, _) => '${expr ?? ''}1', true),
  (const Text('2'), (expr, _) => '${expr ?? ''}2', true),
  (const Text('3'), (expr, _) => '${expr ?? ''}3', true),
  (const Text('+'), (expr, _) => '${expr ?? ''} + ', false),
  //(Text('x^y'), (expr, _) => '${expr ?? ''} ^', false),
  //(Text('+\n-'), (expr, _) => expr, false),
  (const Text(')'), (expr, _) => '${expr ?? ''})', false),
  (const Text('0'), (expr, _) => '${expr ?? ''}0', false),
  (const Text('.'), (expr, _) => '${expr ?? ''}.', false),
  (
    const Text('='),
    (_, controller) {
      controller.evaluate(); //evaluate the exprression
      return null;
    },
    false
  )
];

}
