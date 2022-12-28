// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomToggleButton extends StatefulWidget {
  final List<String> order;
  final String name;

  const CustomToggleButton({Key? key, required this.order, required this.name})
      : super(key: key);
  @override
  State<CustomToggleButton> createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: !selected ? 0 : 5,
      color: !selected ? null : Colors.green[600],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: !selected
            ? const BorderSide(color: Colors.black26)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: () {
          fillRemoveItem(widget.order, widget.name, selected);
          setState(() {
            selected = !selected;

            print(widget.order);
          });
          print(selected);
        },
        customBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        splashColor: Colors.green[400],
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            widget.name,
            style: GoogleFonts.lato(
                textStyle: TextStyle(
              color: !selected ? Colors.black : Colors.white,
              fontSize: 20,
            )),
          ),
        ),
      ),
    );
  }
}

void fillRemoveItem(List<String> order, String text, bool active) {
  if (active && order.contains(text)) {
    order.remove(text);
  } else if (!active && !order.contains(text)) {
    order.add(text);
  }
}
