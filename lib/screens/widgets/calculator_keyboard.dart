import 'package:calculator_app/constants/constants.dart';
import 'package:calculator_app/controller.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

/// The keyboard widget for the calculator
class CalculatorKeyboard extends StatelessWidget {
  const CalculatorKeyboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CalculatorController>();
    return Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Material(
          child: DefaultTextStyle(
            style: workSans.copyWith(fontSize: 23, color: Colors.black),
            child: SizedBox(
              width: screen(context).width,
              child: Obx(() {
                return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: controller.columns,
                    //alignment: WrapAlignment.spaceBetween,
                    children: List.generate(controller.keys.length, (index) {
                      final (child, func, isNumber) = controller.keys[index];
                      final bool isLast= index == controller.keys.length - 1;
                      return KeyItem(
                          onTap: func,
                          isLastKey: isLast,
                          width: screen(context).width /
                              (controller.mode.value == CalculatorMode.scientific ? 4.5 : 3.5),
                          child: !isNumber
                              ? Text((child as Text).data!,
                                  style: TextStyle(
                                      color: isLast
                                          ? Colors.white
                                          : royalBlue,
                                      fontWeight: FontWeight.w600))
                              : child);
                    }));
              }),
            ),
          ),
        ));
  }
}

class KeyAction extends StatelessWidget {
  const KeyAction({super.key, required this.icon, this.onPress});
  final Widget icon;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onPress, child: Center(child: icon));
  }
}

class KeyItem extends StatelessWidget {
  const KeyItem(
      {super.key, required this.child, required this.width, this.color, required this.onTap, this.isLastKey = false});
  final Widget child;
  final double width;
  final Color? color;
  final bool isLastKey;
  final String? Function(String?, CalculatorController) onTap;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CalculatorController>();
    return InkWell(
      onTap: () => controller.type(onTap),
      overlayColor: MaterialStatePropertyAll(isLastKey ? royalBlue.withOpacity(0.5):aliceBlue),
      child: Ink(
          width: width,
          decoration:  BoxDecoration(color: isLastKey ? royalBlue: null),
          padding: const EdgeInsets.all(8),
          child: Center(child: child)),
    );
  }
}
