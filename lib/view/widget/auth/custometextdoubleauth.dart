import 'package:flutter/material.dart';

class CustomeTextFormAuthfuel extends StatelessWidget {
  final String hinttext;
  final String labeltext;
  final IconData iconData;
  final TextEditingController? mycontroller;

  const CustomeTextFormAuthfuel({
    super.key, 
    required this.hinttext,
    required this.labeltext,
    required this.iconData,
    required this.mycontroller,
  }); 
  
  double? getConsumptionRate() {
  String? enteredValue = mycontroller?.text;
  if (enteredValue != null && enteredValue.isNotEmpty) {
    try {
      return double.parse(enteredValue);
    } catch (e) {
      // Handle parsing error, return null or throw an exception
      return null;
    }
  } else {
    return null;
  }
}
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: mycontroller,
        keyboardType: TextInputType.numberWithOptions(decimal: true), // Accepts only double numbers
        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: const TextStyle(fontSize: 14),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          label: Container(
            margin: const EdgeInsets.symmetric(horizontal: 9),
            child: Text(labeltext),
          ),
          suffixIcon: Icon(iconData),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
