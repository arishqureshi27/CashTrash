// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth101/screens/dashboard_screens/pickup_req.dart';
import 'package:firebase_auth101/widgets/custom_textfield.dart';
import 'package:firebase_auth101/widgets/time_slot_select.dart';
import 'package:flutter/material.dart';

class OrderHistoryCard extends StatelessWidget {
  final DocumentSnapshot<Object?> orderData;

  OrderHistoryCard({
    required this.orderData,
    Key? key,
  }) : super(key: key);

  final TextEditingController _date_Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[600],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    orderData['image'],
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const Text(
                          'OrderId:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(orderData['orderId']),
                        const SizedBox(
                          height: 12,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Date of Request: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(orderData['date']),
                              ],
                            ),
                            (orderData['status'] == 'pending')
                                ? IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              titleTextStyle: const TextStyle(
                                                  fontSize: 24,
                                                  color: Colors.black),
                                              title: const Text('Choose Date'),
                                              content: CustomTextField(
                                                myController: _date_Controller,
                                                hintText: 'Enter Date',
                                                icon: const Icon(
                                                    Icons.date_range),
                                                inputType:
                                                    TextInputType.streetAddress,
                                                onTap: true,
                                              ),
                                              actionsAlignment:
                                                  MainAxisAlignment.center,
                                              actions: [
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.green[600],
                                                    ),
                                                    onPressed: () {
                                                      Map<String, String> dat =
                                                          {
                                                        'date': _date_Controller
                                                            .text
                                                      };

                                                      FirebaseFirestore.instance
                                                          .collection('order')
                                                          .doc(orderData[
                                                              'orderId'])
                                                          .update(dat);
                                                      FirebaseFirestore.instance
                                                          .collection('users')
                                                          .doc(orderData['uid'])
                                                          .collection('orders')
                                                          .doc(orderData[
                                                              'orderId'])
                                                          .update(dat);

                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text('Set Date'))
                                              ],
                                            );
                                          });
                                    },
                                    icon: const Icon(Icons.edit))
                                : const SizedBox(
                                    width: 1,
                                  )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),

                        // Date
                        const Text('Time Slot: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(orderData['timeSlot']),
                        const SizedBox(
                          height: 12,
                        ),

                        // Items Requested for Pickup
                        const Text(
                          'Items:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Center(
                          child: Text(orderData['order']
                              .map((e) => e.toString())
                              .toList()
                              .join(', ')),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text('Status: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(orderData['status']),
                        const SizedBox(
                          height: 16,
                        ),
                        (orderData['status'] == 'rejected')
                            ? const Text('Reason for Rejection: ',
                                style: TextStyle(fontWeight: FontWeight.bold))
                            : SizedBox(),
                        (orderData['status'] == 'rejected')
                            ? const SizedBox(
                                height: 4,
                              )
                            : SizedBox(),
                        (orderData['status'] == 'rejected')
                            ? Text(orderData['reasonRejection'])
                            : SizedBox(),
                      ],
                    ),
                  ),
                );
              });
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 120,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              // Image
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        orderData['image'],
                      ),
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              // Data
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Date: ${orderData['date']}'),
                    const SizedBox(
                      height: 8,
                    ),
                    Text('Request Time: ${orderData['time']}'),
                    const SizedBox(
                      height: 8,
                    ),
                    Text('Item count: ${orderData['order'].length}'),
                    const SizedBox(
                      height: 8,
                    ),
                    Text('Status: ${orderData['status']}'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
