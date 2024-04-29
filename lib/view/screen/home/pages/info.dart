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
        child: Scrollbar(
          child: ListView(
            shrinkWrap: true,
            children: [
              RoundedBoxWidget(
                color: const Color(0xFF92739d), //Outer reef
                size: 50,
                textBelow: '60'.tr,
                text: '61'.tr,
              ),
              const SizedBox(height: 15),
              RoundedBoxWidget(
                color: const Color(0xFFc5a7cb), //inner reef
                size: 50,
                textBelow: '62'.tr,
                text: '61'.tr,
              ),
              const SizedBox(height: 15),
              RoundedBoxWidget(
                color: const Color(0xFFfbdefb),
                size: 50,
                textBelow: '63'.tr, //Terrestrial reef
                text: '64'.tr,
              ),
              const SizedBox(height: 15),
              RoundedBoxWidget(
                color: const Color(0xFF614272),
                size: 50,
                textBelow: '65'.tr, //Reef crest
                text: '66'.tr,
              ),
              const SizedBox(height: 15),
              RoundedBoxWidget(
                color: const Color(0xFF77d0fc), //Shallow Lagoon
                size: 50,
                textBelow: '95'.tr,
                text: '96'.tr,
              ),
              const SizedBox(height: 15),
              RoundedBoxWidget(
                color: const Color(0xFF10bda6), //Sheltered reef slope
                size: 50,
                textBelow: '97'.tr,
                text: '98'.tr,
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
