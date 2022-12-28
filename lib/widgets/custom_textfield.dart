// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController myController;
  final String? hintText;
  final Icon? icon;
  final bool? onTap;
  final TextInputType inputType;

  const CustomTextField({
    Key? key,
    required this.myController,
    this.hintText,
    this.icon,
    this.onTap,
    required this.inputType,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomizedTextfieldState();
}

class _CustomizedTextfieldState extends State<CustomTextField> {
  bool show = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.myController,
      keyboardType: widget.inputType,
      onTap: widget.onTap ?? false
          ? () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2022),
                  lastDate: DateTime(2023));
              if (pickedDate != null) {
                setState(() {
                  widget.myController.text =
                      DateFormat('dd-MM-yyyy').format(pickedDate);
                });
              }
            }
          : null,
      decoration: InputDecoration(
        fillColor: const Color(0xffE8ECF4),
        filled: true,
        hintText: widget.hintText,
        icon: widget.icon ?? null,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffE8ECF4), width: 1),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffE8ECF4), width: 1),
            borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
