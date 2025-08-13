import 'package:calculadora/controllers/calculator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:calculadora/widgets/line_separator.dart';
import 'package:calculadora/widgets/main_result.dart';
import 'package:calculadora/widgets/sub_result.dart';

class MathResults extends StatelessWidget {

  // Buscamos nuestra instancia del controlador GetX.
  final calculatorCtrl = Get.find<CalculatorController>();

  MathResults({super.key});

  @override
  Widget build(BuildContext context) {
    // Cada vez que cambie el estado, esto se va a redibujar.
    return Obx(
      () => Column(
        children: [
          SubResult(text: '${calculatorCtrl.firstNumber}'),
          SubResult(text: '${calculatorCtrl.operation}'),
          SubResult(text: '${calculatorCtrl.secondNumber}'),
          LineSeparator(),
          MainResultText(text: '${calculatorCtrl.mathResult}'),
        ],
      ),
    );
  }
}
