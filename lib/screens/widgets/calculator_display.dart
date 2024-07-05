
import 'package:calculator_app/constants/constants.dart';
import 'package:calculator_app/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///DISPLAY FOR RESULTS AND USER FEEDBACK WHEN TYPING
class CalculatorDisplay extends GetWidget<CalculatorController> {
  const CalculatorDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screen(context).width,
      height: screen(context).height * 0.225,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(() {
          return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //Text(controller.history.value),
                FittedBox(
                  alignment: Alignment.centerRight,
                  child:
                   Text(controller.history.value.isEmpty ? ' ': controller.history.value,
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      )),
                ),

                spacer(),
                FittedBox(
                  alignment: Alignment.centerRight,
                  child: Text(
                      controller.expression.isEmpty
                          ? controller.result.value.toString()
                          : controller.expression.value,
                      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                )
              ]);
        }),
      ),
    );
    //});
  }
}
