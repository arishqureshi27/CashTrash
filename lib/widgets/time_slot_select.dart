// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../screens/dashboard_screens/pickup_req.dart';

class TimeSlotWidget extends StatefulWidget {
  TimeSlotWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TimeSlotWidget> createState() => _TimeSlotWidgetState();
}

class _TimeSlotWidgetState extends State<TimeSlotWidget> {
  final List<String> timeSlot = [
    '',
    'Morning Slot - 9AM to 12PM',
    'Afternoon Slot - 12PM to 3PM',
    'Evening Slot - 3PM to 6PM',
  ];

  @override
  Widget build(BuildContext context) {
    String? timeslot;
    return Row(
      children: [
        Icon(
          Icons.timer_outlined,
          color: Colors.grey[600],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: SizedBox(
            width: 300,
            child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  fillColor: Colors.amber,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.black38,
                    ),
                  ),
                ),
                value: timeslot,
                items: timeSlot
                    .map(
                      (slot) => DropdownMenuItem<String>(
                        value: slot,
                        child: Text(
                          slot,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (slot) => setState(() {
                      timeslot = slot;
                      selectedTimeSlot = slot!;
                      print(selectedTimeSlot);
                    })),
          ),
        ),
      ],
    );
  }
}
