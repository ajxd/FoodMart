import 'package:flutter/material.dart';
import 'package:foodmart/model/cart.dart';
import 'order_confirmation_page.dart';

class CheckoutPage extends StatefulWidget {
  final Cart cart;

  CheckoutPage({Key? key, required this.cart}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String address = '';
  String email = '';
  String phoneNumber = '';
  bool isCardPayment = false;

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Details Section
                TextFormField(
                  decoration: _inputDecoration('Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) => name = value!,
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: _inputDecoration('Address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                  onSaved: (value) => address = value!,
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: _inputDecoration('Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty ||
                        !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (value) => email = value!,
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: _inputDecoration('Phone Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  onSaved: (value) => phoneNumber = value!,
                ),
                SizedBox(height: 25),

                // Payment Method Section
                Text(
                  'Payment Method',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ListTile(
                  title: Text('Card Payment'),
                  leading: Radio<bool>(
                    value: true,
                    groupValue: isCardPayment,
                    onChanged: (value) =>
                        setState(() => isCardPayment = value!),
                  ),
                ),
                ListTile(
                  title: Text('Cash on Delivery'),
                  leading: Radio<bool>(
                    value: false,
                    groupValue: isCardPayment,
                    onChanged: (value) =>
                        setState(() => isCardPayment = value!),
                  ),
                ),
                isCardPayment ? buildCardPaymentInputs() : SizedBox.shrink(),

                // Order Summary Section
                Text(
                  'Order Summary',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ...widget.cart.items.values.map((item) =>
                    ListTile(
                      title: Text(item.creation.title),
                      trailing: Text('\$${item.creation.costEstimation} x ${item
                          .quantity}'),
                    )),
                Divider(),
                ListTile(
                  title: Text(
                      'Total', style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: Text(
                      '\$${widget.cart.getTotalPrice().toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 20),

                // Place Order Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();


                      // Navigate to OrderConfirmationPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderConfirmationPage()),
                      );
                    }
                  },
                  child: Text(
                    "Place Order",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Button background color
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCardPaymentInputs() {
    return Column(
      children: [
        TextFormField(
          decoration: _inputDecoration('Card Number'),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty)
              return 'Please enter your card number';
            if (value.length < 16) return 'Invalid card number';
            return null;
          },
          onSaved: (value) {
            // Save card number
          },
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: _inputDecoration('Expiry Date'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Enter expiry date';

                  return null;
                },
                onSaved: (value) {
                  // Save expiry date
                },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                decoration: _inputDecoration('CVV'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter CVV';
                  if (value.length != 3) return 'Invalid CVV';
                  return null;
                },
                onSaved: (value) {
                  // Save CVV
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        TextFormField(
          decoration: _inputDecoration('Cardholder Name'),
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty)
              return 'Enter cardholder\'s name';
            return null;
          },
          onSaved: (value) {
            // Save cardholder's name
          },
        ),
      ],
    );
  }
}
