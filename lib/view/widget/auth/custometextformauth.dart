import 'package:flutter/material.dart';

class CustomeTextFormAuth extends StatefulWidget {
  final String hinttext;
  final String labeltext;
  final IconData iconData;
  final TextEditingController? mycontroller;
  final String? hintTextOnIconClick;
  final bool showErrorHint;

  const CustomeTextFormAuth({
    Key? key,
    required this.hinttext,
    required this.labeltext,
    required this.iconData,
    required this.mycontroller,
    this.hintTextOnIconClick,
    this.showErrorHint = false, // Default value is false
  }) : super(key: key);

  @override
  _CustomeTextFormAuthState createState() => _CustomeTextFormAuthState();
}

class _CustomeTextFormAuthState extends State<CustomeTextFormAuth> {
  bool _showHintOnIconClick = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.mycontroller,
            onChanged: (value) {
              widget.mycontroller?.text = value.trim();
            },
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
              suffixIcon: IconButton(
                icon: Icon(widget.iconData),
                onPressed: () {
                  setState(() {
                    _showHintOnIconClick = !_showHintOnIconClick;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          if (widget.showErrorHint &&
              _showHintOnIconClick &&
              widget.hintTextOnIconClick != null)
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
