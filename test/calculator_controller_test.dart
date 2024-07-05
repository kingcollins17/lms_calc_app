import 'package:flutter_test/flutter_test.dart';

import 'package:calculator_app/controller.dart';

void main() {
  late CalculatorController controller;
  setUp(() {
    controller = CalculatorController();
  });

  group('Test CalculatorController', () {
    test('Test addition -> 5 + 2 = 7', () {
      expect(controller.result.value, equals(0.0)); //expect there is no result initially
      //type in the addition
      controller.type((exp, _) => '5 + 2');
      controller.evaluate();

      expect(controller.result.value, equals(7.0)); // now expect that result is equal to 7
    });

    test('Test complex addition -> 5 + (4 * 5) + (-1) +3', () {
      expect(controller.result.value, equals(0.0));

      controller.type((expr, _) => '5 + (4 * 5) + (-1) +3');
      controller.evaluate();
      expect(controller.result.value, equals(27));
    });
    test('Test substraction', () {
      expect(controller.result.value, equals(0.0));
      controller.type((expr, _) => '7 - 4');
      controller.evaluate();

      expect(controller.result.value, 3.0);
    });
    test('Test simple multiplication', () {
      expect(controller.result.value, equals(0.0));
      controller.type((expr, _) => '5 * 10');
      controller.evaluate();

      expect(controller.result.value, equals(50.0));
    });

    test('Test raised to Power', () {
    	expect(controller.result.value, equals(0.0));
    	controller.type((expr, _) => '5^2 + 10');
    	controller.evaluate();

    	expect(controller.result.value, equals(35.0));
    	});

    test('Test division', () {

    	expect(controller.result.value, equals(0.0));
    	controller.type((expr, _) => '10 / 2');

    	controller.evaluate();
    	expect(controller.result.value, equals(5.0));
    	});
  });
}
