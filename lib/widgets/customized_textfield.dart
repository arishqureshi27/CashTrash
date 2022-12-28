import 'package:flutter/material.dart';

class CustomizedTextfield extends StatefulWidget {
  final TextEditingController myController;
  final String? hintText;
  final bool? isPassword;
  const CustomizedTextfield(
      {Key? key,
      required this.myController,
      this.hintText,
      required this.isPassword})
      : super(key: key);

  @override
  State<CustomizedTextfield> createState() => _CustomizedTextfieldState();
}

class _CustomizedTextfieldState extends State<CustomizedTextfield> {
  bool show = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        keyboardType: widget.isPassword!
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress,
        enableSuggestions: widget.isPassword! ? false : true,
        autocorrect: widget.isPassword! ? false : true,
        obscureText: widget.isPassword! && show,
        controller: widget.myController,
        decoration: InputDecoration(
          suffixIcon: widget.isPassword!
              ? IconButton(
                  icon: const Icon(Icons.remove_red_eye, color: Colors.grey),
                  onPressed: () {
                    setState(() {
                      show = !show;
                    });
                  },
                )
              : null,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffE8ECF4), width: 1),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffE8ECF4), width: 1),
              borderRadius: BorderRadius.circular(10)),
          fillColor: const Color(0xffE8ECF4),
          filled: true,
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
