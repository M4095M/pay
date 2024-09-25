import 'package:flutter/material.dart';
import '../colors/color_names.dart';
import '../widgets/header_widget.dart';
import '../widgets/navigation_widget.dart';
import '../widgets/item_list.dart';
import '../widgets/item_fetching_form.dart';
import '../models/item.dart';
import '../db/db.dart';

class ClientHomeScreen extends StatefulWidget {
  @override
  _ClientHomeScreenState createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  bool _showItemDetails = true;
  Item? _selectedItem;

  void _fetchItem(String id) async {
    final item = await DatabaseHelper().getItemById(id);
    setState(() {
      _selectedItem = item;
      _showItemDetails = true;
    });
  }

  void _toggleItemDetails() {
    setState(() {
      _showItemDetails = !_showItemDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Home'),
        backgroundColor: ColorNames.getColorByName('Orange'),
      ),
      body: Stack(
        children: [
          NavigationWidget(),
          Column(
            children: [
              if (_selectedItem != null)
                Expanded(
                  child: ItemList(
                    items: [_getItemData(_selectedItem!)],
                    onDeleteItem: (id) {}, // No delete action for client
                    onItemTapped: (id) {}, // No item tap action for client
                  ),
                ),
            ],
          ),
          if (_showItemDetails)
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () => _toggleItemDetails(),
              child: Icon(Icons.add),
            ),
          ),
          if (!_showItemDetails)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(16.0),
                child: ItemFetchingForm(onFetchItem: _fetchItem),
              ),
            ),
        ],
      ),
    );
  }

  Map<String, String> _getItemData(Item item) {
    return {
      'id': item.id,
      'name': item.name,
      'price': item.totalPrice.toString(),
      'divisions': item.divisions.toString(),
      'timeGap': item.timeGap.inDays.toString(),
    };
  }
}
