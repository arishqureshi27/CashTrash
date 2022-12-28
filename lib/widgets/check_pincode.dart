import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CheckPincode extends StatefulWidget {
  const CheckPincode({super.key});

  @override
  State<CheckPincode> createState() => _CheckPincodeState();
}

class _CheckPincodeState extends State<CheckPincode> {
  final TextEditingController _controller = TextEditingController();
  bool showError = false;
  List<String> pincodes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillList(pincodes);
  }

  @override
  Widget build(BuildContext context) {
    List<String> pincodes = [];

    fillList(pincodes);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // TextField to Enter Pincode
      content: TextFormField(
        controller: _controller,
        keyboardType: TextInputType.number,
        maxLength: 6,
        decoration: InputDecoration(
          errorText: showError ? 'Please Enter Pincode' : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: 'Enter Pincode',
          hintText: 'Enter Pincode',
        ),
        onChanged: (value) {
          if (value.isEmpty) {
            setState(() {
              showError = true;
            });
          } else {
            setState(() {
              showError = false;
            });
          }
        },
      ),

      // Actions
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          onPressed: () {
            pincodes.contains(_controller.text)
                ? showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        titleTextStyle:
                            const TextStyle(fontSize: 24, color: Colors.black),
                        title: const Text(
                          'ALRIGHT!!',
                        ),
                        content: const Text(
                            'Our Service is available at your location'),
                        actions: [
                          Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/pickup-page');
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text('Alright')),
                          )
                        ],
                      );
                    })
                : showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        titleTextStyle:
                            const TextStyle(fontSize: 24, color: Colors.black),
                        title: const Text(
                          'OOPS!!',
                        ),
                        content: const Text(
                            'Seems like service at your location is not available'),
                        actions: [
                          Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text('Alright')),
                          )
                        ],
                      );
                    });
          },
          child: const Text('Check Avaibility'),
        )
      ],
    );
  }
}

void fillList(pincodes) async {
  var doc = await FirebaseFirestore.instance.collection('pincode').get();
  for (int i = 0; i < doc.docs.length; i++) {
    pincodes.add(doc.docs[i].data()['pincode']);
  }
}
