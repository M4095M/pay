import 'package:flutter/material.dart';

class ItemFetchingForm extends StatefulWidget {
  final Function(String) onFetchItem;

  ItemFetchingForm({required this.onFetchItem});

  @override
  _ItemFetchingFormState createState() => _ItemFetchingFormState();
}

class _ItemFetchingFormState extends State<ItemFetchingForm> {
  final TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _idController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter Item ID',
            ),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () => widget.onFetchItem(_idController.text),
            child: Text('Fetch Item'),
          ),
        ],
      ),
    );
  }
}
