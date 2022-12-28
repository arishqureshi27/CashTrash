import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderProvider extends ChangeNotifier {
  static bool loading = false;
  void addOrder({
    required TextEditingController pincode,
    required TextEditingController address,
    required TextEditingController landmark,
    required TextEditingController phone,
    required TextEditingController pickupDate,
    required String timeSlot,
    required List<String> items,
    required XFile? image,
    required BuildContext context,
  }) async {
    if (pincode.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pincode Field is Empty'),
        ),
      );
    } else if (pincode.text.length > 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter Valid Pincode'),
        ),
      );
    } else if (address.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Address field is Empty'),
        ),
      );
    } else if (landmark.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter nearby landmark'),
        ),
      );
    } else if (items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select items for pickup'),
        ),
      );
    } else if (phone.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter phone number'),
        ),
      );
    } else if (phone.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid phone number'),
        ),
      );
    } else if (pickupDate.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid date'),
        ),
      );
    } else if (timeSlot == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a time slot'),
        ),
      );
    } else if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Select an Image'),
        ),
      );
    } else {
      try {
        loading = true;
        notifyListeners();

        final DateTime now = DateTime.now();
        final DateFormat formatter = DateFormat('dd-MM-yyyy');
        final String dateNow = formatter.format(now);
        String timeNow = DateFormat.Hms().format(now);

        final userId = FirebaseAuth.instance.currentUser!.uid;
        final order = FirebaseFirestore.instance.collection('order').doc();

        Reference referenceRoot = FirebaseStorage.instance.ref();
        Reference referenceDirImages = referenceRoot.child('images');
        Reference referenceImageToUpload = referenceDirImages.child(order.id);

        String url = '';
        try {
          await referenceImageToUpload.putFile(
            File(image.path),
          );
          url = await referenceImageToUpload.getDownloadURL();
        } catch (e) {
          print(e.toString());
        }

        final data = {
          'uid': userId,
          'orderId': order.id,
          'image': url,
          'pincode': pincode.text,
          'address': address.text,
          'landmark': landmark.text,
          'phone': phone.text,
          'pickupDate': pickupDate.text,
          'timeSlot': timeSlot,
          'order': items,
          'date': dateNow,
          'time': timeNow,
          'status': 'pending',
          'reasonRejection': '',
        };

        FirebaseFirestore.instance.collection('order').doc(order.id).set(data);

        FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('orders')
            .doc(order.id)
            .set(
              (data),
            )
            .then((value) {
          loading = false;
          notifyListeners();
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              context: context,
              builder: (context) {
                return SizedBox(
                  height: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pickup Request Generated Successfully',
                        style: GoogleFonts.lato(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[600],
                          ),
                          child: const Text('OK'))
                    ],
                  ),
                );
              }).then(
            (value) => Navigator.popUntil(context, (route) => route.isFirst),
          );
        });
      } catch (e) {
        loading = false;
        notifyListeners();
        print(e);
      }
    }
  }
}
