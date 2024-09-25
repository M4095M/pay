import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import '../widgets/header_widget.dart';
import '../widgets/navigation_widget.dart';
import '../widgets/add_item_form.dart';
import '../widgets/item_list.dart';
import '../models/item.dart';
import '../db/db.dart';
import '../colors/color_names.dart';

class SellerHomeScreen extends StatefulWidget {
  @override
  _SellerHomeScreenState createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
  bool _showAddItemForm = false;
  List<Item> _items = [];
  String? _selectedItemId;

  final Uuid _uuid = Uuid();

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final items = await DatabaseHelper().getItems();
    setState(() {
      _items = items;
    });
  }

  void _toggleAddItemForm() {
    setState(() {
      _showAddItemForm = !_showAddItemForm;
    });
  }

  Future<void> _addItem(String name, double price, int divisions, int timeGap) async {
    final newItem = Item(
      id: _uuid.v4(),
      name: name,
      totalPrice: price,
      divisions: divisions,
      timeGap: Duration(days: timeGap),
    );
    await DatabaseHelper().insertItem(newItem);
    await _loadItems();
    _toggleAddItemForm(); // Close the form after adding item
  }

  Future<void> _deleteItem(String id) async {
    await DatabaseHelper().deleteItem(id);
    await _loadItems(); // Reload items after deletion
  }

  void _copyToClipboard(String id) {
    final clipboard = ClipboardData(text: id);
    Clipboard.setData(clipboard);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ID copied to clipboard')));
  }

  void _showItemId(String id) {
    setState(() {
      _selectedItemId = id;
    });
  }

  void _closeItemId() {
    setState(() {
      _selectedItemId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller Home'),
        backgroundColor: ColorNames.getColorByName('Orange'),
      ),
      body: Stack(
        children: [
          NavigationWidget(),
          Column(
            children: [
              Expanded(
                child: ItemList(
                  items: _getItemListData(),
                  onDeleteItem: _deleteItem,
                  onItemTapped: _showItemId,
                ),
              ),
            ],
          ),
          if (_showAddItemForm)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AddItemForm(onAddItem: _addItem),
                ),
              ),
            ),
          if (_selectedItemId != null)
            GestureDetector(
              onTap: _closeItemId,
              child: Container(
                color: Colors.black54, // Semi-transparent black background
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0), // Adjust the radius to your preference
                    ),
                    padding: EdgeInsets.all(20.0),
                    width: MediaQuery.of(context).size.width * 0.8, // Width of the dialog
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Item ID: $_selectedItemId',
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => _copyToClipboard(_selectedItemId!),
                          child: Text('Copy ID'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: _toggleAddItemForm,
              child: Icon(_showAddItemForm ? Icons.close : Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> _getItemListData() {
    return _items.map((item) {
      return {
        'id': item.id, // Include the item ID
        'name': item.name,
        'price': item.totalPrice.toString(),
        'divisions': item.divisions.toString(),
        'timeGap': item.timeGap.inDays.toString(),
      };
    }).toList();
  }
}
