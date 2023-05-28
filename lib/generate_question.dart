import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';

class GenerateQuestion {
  static ContextModel? contextModel = ContextModel();

  static String generate() {
    final random = math.Random();
    final int numOperands = random.nextInt(3) + 2; // Generate 2 to 4 operands
    final List<int> operands = List.generate(numOperands, (_) => random.nextInt(10) + 1);
    final List<String> operators = ['+', '-', '*', '/']; // Available operators

    String expression = operands[0].toString();

    for (int i = 1; i < numOperands; i++) {
      final operatorIndex = random.nextInt(operators.length);
      final operator = operators[operatorIndex];
      final operand = operands[i];
      expression += ' $operator $operand';
    }

    return expression;
  }


  static double answer(String expression) {
    try {
      final parser = Parser();
      final parsedExpression = parser.parse(expression);
      final evaluatedExpression = parsedExpression.evaluate(
          EvaluationType.REAL, contextModel!);
      return evaluatedExpression;
    } catch (e) {
      print('Error evaluating expression: $e');
      print(expression);
      return 0;
    }

  }

}
