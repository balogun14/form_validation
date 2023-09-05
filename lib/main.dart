// ignore_for_file: unused_element

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  final Order _order = Order();

  String? _validateItemRequired(String value) {
    return value.isEmpty ? 'Item Required' : null;
  }

  String? _validateItemCount(String value) {
    int? valueAsInteger = value.isEmpty ? 0 : int.tryParse(value);
    return valueAsInteger == 0 ? 'At least one Item is Required' : null;
  }

  void _submitOrder() {
    if (_formStateKey.currentState!.validate()) {
      _formStateKey.currentState?.save();
      print('Order Item: ${_order.item}');
      print('Order Quantity: ${_order.quantity}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Form(
            key: _formStateKey,
            autovalidateMode: AutovalidateMode.always,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Espresso',
                      labelText: 'Item',
                    ),
                    validator: (value) =>
                        _validateItemRequired(value as String),
                    onSaved: (value) => _order.item = value as String,
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(hintText: '3', labelText: 'Quantity'),
                    validator: (value) => _validateItemCount(value as String),
                    onSaved: (value) =>
                        _order.quantity = int.tryParse(value!) as int,
                  ),
                  Divider(
                    height: 32.0,
                  ),
                  ElevatedButton(
                    onPressed: () => _submitOrder(),
                    child: Text('save'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.lightGreen)),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

class Order {
  late String item;
  late int quantity;
}
