import 'package:flutter/material.dart';

class CustomeTextFormAuthfuel extends StatefulWidget {
  final String hinttext;
  final String labeltext;
  final IconData iconData;
  final TextEditingController? mycontroller;
  final String? hintTextOnIconClick;

  const CustomeTextFormAuthfuel({
    Key? key,
    required this.hinttext,
    required this.labeltext,
    required this.iconData,
    required this.mycontroller,
    this.hintTextOnIconClick,
  }) : super(key: key);

  @override
  _CustomeTextFormAuthfuelState createState() =>
      _CustomeTextFormAuthfuelState();
}

class _CustomeTextFormAuthfuelState extends State<CustomeTextFormAuthfuel> {
  bool _showHintOnIconClick = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.mycontroller,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: widget.hinttext,
              hintStyle: const TextStyle(fontSize: 14),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 9),
                child: Text(widget.labeltext),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _showHintOnIconClick = !_showHintOnIconClick;
                  });
                },
                child: Icon(widget.iconData),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          if (_showHintOnIconClick && widget.hintTextOnIconClick != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                widget.hintTextOnIconClick!,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
