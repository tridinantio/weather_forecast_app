import 'package:flutter/material.dart';
import 'package:weather_forecast_app/theme_manager/font_manager.dart';
import 'package:weather_forecast_app/theme_manager/style_manager.dart';

class CustomForm extends StatefulWidget {
  const CustomForm(
      {Key? key,
      required this.desc,
      required this.hint,
      required this.controller,
      required this.textInputType})
      : super(key: key);
  final String desc;
  final String hint;
  final TextEditingController controller;
  final TextInputType textInputType;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            keyboardType: widget.textInputType,
            controller: widget.controller,
            decoration: InputDecoration(
                prefixIcon: widget.textInputType == TextInputType.phone
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 4),
                            decoration: const BoxDecoration(
                                border: Border(
                                    right: BorderSide(color: Colors.black))),
                            child: Text(
                              '+62',
                              textAlign: TextAlign.center,
                              style: getBlackTextStyle().copyWith(
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontSizeManager.f18),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                hintText: widget.hint,
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)))),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            widget.desc,
            style:
                getBlack30TextStyle().copyWith(fontSize: FontSizeManager.f14),
          )
        ],
      ),
    );
  }
}
