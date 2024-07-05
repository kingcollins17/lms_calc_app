
import 'package:calculator_app/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import 'widgets/widgets.dart';

class CalculatorScreen extends GetWidget<CalculatorController> {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), (){
      Get.snackbar('Tip', 'Open the drawer to toggle calculator mode');
      });
    return Scaffold(
        backgroundColor: aliceBlue,
        drawer: const MyDrawer(),
        appBar: AppBar(
          //leading: const Icon(Icons.menu),
          title: Obx(() {
            return GestureDetector(
                onTap: () {
                  controller.changeMode();
                },
                child: Text(
                    controller.mode.value == CalculatorMode.scientific
                        ? 'SCIENTIFIC'
                        : 'Calculator',
                    style: workSans.copyWith(fontWeight: FontWeight.w600)));
          }),
          actions: [const Icon(Icons.dark_mode_outlined), spacer(x: 10)],
        ),
        body: SizedBox.expand(
          child: Column(children: [
            const Expanded(flex: 1, child: CalculatorDisplay()),
            spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Obx(() {
                return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  const KeyAction(icon: Icon(Icons.history)),
                  if (controller.mode.value == CalculatorMode.scientific)
                    const KeyAction(icon: Icon(Icons.arrow_upward_sharp)),

                  //action for clearing the controller
                  KeyAction(
                    icon: const Text('C', style: TextStyle(fontSize: 24, color: Colors.red)),
                    onPress: () => controller.clear(),
                  ),
                  const KeyAction(icon: Icon(Icons.label_outlined, color: royalBlue)),
                  const KeyAction(icon: Icon(Icons.refresh))
                ]);
              }),
            ),
            const Expanded(
                flex: 3,
                child: Align(alignment: Alignment.bottomCenter, child: CalculatorKeyboard())),
          ]),
        ));
  }
}

class MyDrawer extends GetWidget<CalculatorController> {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: screen(context).width * 0.7,
      child: Obx(() {
        return Column(
          children: [
            DrawerHeader(
              child: Text('My Calculator', style: workSans.copyWith(fontSize: 20, fontWeight: FontWeight.w600)),
            ),
            spacer(),
            _DrawerItem(
              label: 'Scientific',
              isCurrentMode: controller.mode.value == CalculatorMode.scientific,
              onPress: () {
                controller.mode.value = CalculatorMode.scientific;
                },
            ),
            spacer(),
            _DrawerItem(
              label: 'Calculator',
              isCurrentMode: controller.mode.value == CalculatorMode.regular,
              onPress: () {
                controller.mode.value = CalculatorMode.regular;
                },
            )
          ],
        );
      }),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({required this.label, this.isCurrentMode = false, this.onPress});
  final String label;
  final bool isCurrentMode;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(color: isCurrentMode ? royalBlue: null),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Visibility(
                visible: isCurrentMode,
                child: const Icon(Icons.check, size: 20, color: Colors.white)),
              spacer(x: 6),
              Text(label, style: isCurrentMode ? workSans.copyWith(color: Colors.white): workSans),
            ],
          ),
        ),
      ),
    );
  }
}
