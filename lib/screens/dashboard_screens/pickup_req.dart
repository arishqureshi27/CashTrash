import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/order_provider.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/customized_button.dart';
import '../../widgets/custom_toggle_button.dart';
import '../../widgets/time_slot_select.dart';

XFile? _image;
String? selectedTimeSlot;

class PickUpRequest extends StatelessWidget {
  PickUpRequest({super.key});

  final TextEditingController _pincode_Controller = TextEditingController();
  final TextEditingController _address_Controller = TextEditingController();
  final TextEditingController _landmark_Controller = TextEditingController();
  final TextEditingController _phone_Controller = TextEditingController();
  final TextEditingController _date_Controller = TextEditingController();
  final List<String> items = [
    'Newspaper',
    'Books',
    'CardBoard',
    'Monitor',
    'Telecom Equipment',
    'Solar Panels',
    'Cooling Equipments',
    'Vending Machine',
    'Miscellaneous',
    'Hard Plastic',
    'Soft Plastic',
    'Plastic Fiber',
    'Steel',
    'Tin',
    'Iron',
    'Copper',
    'Aluminium',
  ];
  final List<String> order = [];

  @override
  Widget build(BuildContext context) {
    OrderProvider orderprovider = Provider.of<OrderProvider>(context);

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green.shade900, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_sharp),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Text(
                  'Request PickUp',
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),

              // Pincode Title
              const Text(
                'Pincode',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              // Pincode Text Field
              CustomTextField(
                myController: _pincode_Controller,
                hintText: 'Enter valid Pincode',
                inputType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              // Address Title
              const Text(
                'Address',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),

              // Address Text Field
              CustomTextField(
                myController: _address_Controller,
                hintText: 'Enter your Address',
                inputType: TextInputType.streetAddress,
              ),
              const SizedBox(height: 20),
              const Text(
                'Landmark',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                myController: _landmark_Controller,
                hintText: 'Enter nearby Landmark',
                inputType: TextInputType.streetAddress,
              ),
              const SizedBox(height: 20),
              const Text(
                'Phone',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                myController: _phone_Controller,
                hintText: 'Enter Phone Number to contact',
                inputType: TextInputType.streetAddress,
              ),
              const SizedBox(height: 20),
              const Text(
                'Date',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                myController: _date_Controller,
                hintText: 'Enter Date ',
                icon: const Icon(Icons.date_range),
                inputType: TextInputType.streetAddress,
                onTap: true,
              ),
              const SizedBox(height: 20),
              const Text(
                'Time Slot',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              TimeSlotWidget(),

              const SizedBox(height: 20),

              const Text(
                'Select Items',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),

              Wrap(
                children: items
                    .map((e) => CustomToggleButton(order: order, name: e))
                    .toList(),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: DottedBorder(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                            onPressed: () {
                              _pickimage();
                            },
                            icon: const Icon(Icons.photo_camera),
                            label: const Text('Choose Image'))
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              // Order Button
              OrderProvider.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: CustomizedButton(
                        buttonText: "Request Pickup",
                        buttonColor: Colors.green[800],
                        textColor: Colors.white,
                        onPressed: () {
                          orderprovider.addOrder(
                            pincode: _pincode_Controller,
                            address: _address_Controller,
                            landmark: _landmark_Controller,
                            phone: _phone_Controller,
                            pickupDate: _date_Controller,
                            timeSlot: selectedTimeSlot!,
                            image: _image,
                            items: order,
                            context: context,
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      )),
    );
  }
}

_pickimage() async {
  ImagePicker imagePicker = ImagePicker();
  _image =
      await imagePicker.pickImage(source: ImageSource.camera, imageQuality: 80);
}
