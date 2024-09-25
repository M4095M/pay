import 'package:flutter/material.dart';

class AddItemForm extends StatefulWidget {
  final Function(String, double, int, int) onAddItem;

  AddItemForm({required this.onAddItem});

  @override
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _formKey = GlobalKey<FormState>();
  String _itemName = '';
  String _itemPrice = '';
  int _divisions = 1;
  int _timeGap = 0;

  void _addItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onAddItem(_itemName, double.parse(_itemPrice), _divisions, _timeGap);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item Added: $_itemName')));
      setState(() {
        _itemName = '';
        _itemPrice = '';
        _divisions = 1;
        _timeGap = 30;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Item Name'),
            validator: (value) => value!.isEmpty ? 'Please enter an item name' : null,
            onSaved: (value) => _itemName = value!,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Item Price'),
            keyboardType: TextInputType.number,
            validator: (value) => value!.isEmpty ? 'Please enter an item price' : null,
            onSaved: (value) => _itemPrice = value!,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Number of Divisions'),
            keyboardType: TextInputType.number,
            initialValue: '1',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter the number of divisions';
              }
              int divisions = int.parse(value);
              if (divisions <= 0) {
                return 'Divisions must be at least 1';
              }
              return null;
            },
            onSaved: (value) => _divisions = int.parse(value!),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Time Gap (Days)'),
            keyboardType: TextInputType.number,
            initialValue: '0',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter the time gap in days';
              }
              int timeGap = int.parse(value);
              if (timeGap < 0) {
                return 'Time gap cannot be negative';
              }
              return null;
            },
            onSaved: (value) => _timeGap = int.parse(value!),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _addItem,
            child: Text('Add Item'),
          ),
        ],
      ),
    );
  }
}
