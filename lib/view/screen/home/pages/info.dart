import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          children: [
            RoundedBoxWidget(
              color: Colors.pink,
              size: 40,
              textBelow: '60'.tr,
              text: '61'.tr,
            ),
            const SizedBox(height: 10),
            RoundedBoxWidget(
              color: Colors.cyan,
              size: 40,
              textBelow: '62'.tr,
              text: '61'.tr,
            ),
            const SizedBox(height: 10),
            RoundedBoxWidget(
              color: const Color.fromRGBO(139, 195, 74, 1),
              size: 40,
              textBelow: '63'.tr,
              text: '64'.tr,
            ),
            const SizedBox(height: 10),
            RoundedBoxWidget(
              color: Colors.grey,
              size: 40,
              textBelow: '65'.tr,
              text: '66'.tr,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                '67'.tr,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundedBoxWidget extends StatelessWidget {
  final Color color;
  final double size;
  final String text;
  final String textBelow;

  const RoundedBoxWidget({
    required this.color,
    required this.size,
    required this.textBelow,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          textBelow,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
