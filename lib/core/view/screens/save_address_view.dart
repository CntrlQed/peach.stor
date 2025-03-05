import 'package:flutter/material.dart';
import 'payment_address_view.dart';

class SaveAddressView extends StatelessWidget {
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController roadNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  SaveAddressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/map.jpeg',
                  height: 150,
                  fit: BoxFit.cover,
                ),
                const Text(
                  'USE CURRENT LOCATION',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: pincodeController,
              decoration: InputDecoration(
                hintText: 'Pincode',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: houseNumberController,
              decoration: InputDecoration(
                hintText: 'House / Flat / Building No.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: roadNameController,
              decoration: InputDecoration(
                hintText: 'Road Name / Area / Colony',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Use as primary address', style: TextStyle(color: Colors.white)),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                  activeColor: Colors.red,
                  checkColor: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: 'Phone No.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  String address = 'Pincode: ' + pincodeController.text + ', House: ' + houseNumberController.text + ', Road: ' + roadNameController.text + ', Name: ' + nameController.text + ', Phone: ' + phoneNumberController.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentAddressView(
                        address: address,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('SAVE AND CONTINUE', style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 