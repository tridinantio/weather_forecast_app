import 'package:flutter/material.dart';

class CustomForm extends StatefulWidget {
  const CustomForm(
      {Key? key,
      required this.label,
      required this.hint,
      required this.controller})
      : super(key: key);
  final String label;
  final String hint;
  final TextEditingController controller;

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  bool dataCorrect = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        children: [
          TextField(
            controller: widget.controller,
            decoration: InputDecoration(
                hintText: widget.hint,
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)))),
          ),
        ],
      ),
    );
  }
}
