import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  final List<Map<String, dynamic>> items; // Use dynamic to handle various types
  final Function(String) onDeleteItem;
  final Function(String) onItemTapped;

  ItemList({required this.items, required this.onDeleteItem, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Items List'),  automaticallyImplyLeading: false,),
      body: items.isEmpty
          ? Center(child: Text('No items available'))
          : ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          // Determine the number of divisions, defaulting to 1 if not provided
          int divisions = int.tryParse(item['divisions'] ?? '1') ?? 1;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.image, size: 50), // Placeholder for item image
                title: Text(item['name'] ?? 'No name'),
                subtitle: Text(
                  'Price: \$${item['price'] ?? ''}\nTime Gap: ${item['timeGap']} days',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        onDeleteItem(item['id']); // Call the delete function with the item's ID
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.info, color: Colors.blue),
                      onPressed: () {
                        onItemTapped(item['id']); // Call the item tapped function with the item's ID
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0), // Equal padding on left and right
                child: Container(
                  height: 10, // Thickness of the line
                  child: Row(
                    children: List.generate(divisions, (divIndex) {
                      return Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5), // Round all corners
                          child: Container(
                            color: Colors.blue, // Color of the line
                            margin: EdgeInsets.only(
                              right: divIndex < divisions - 1 ? 1.0 : 0.0,
                              left: divIndex > 0 ? 1.0 : 0.0, // Optional spacing between segments
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              SizedBox(height: 20), // Add spacing below the line
            ],
          );
        },
      ),
    );
  }
}
