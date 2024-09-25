import 'package:flutter/foundation.dart';

class Item {
  final String id;
  final String name;
  final double totalPrice;
  final int divisions;
  final Duration timeGap;

  Item({
    required this.id,
    required this.name,
    required this.totalPrice,
    required this.divisions,
    required this.timeGap,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'totalPrice': totalPrice,
      'divisions  ': divisions,
      'timeGap': timeGap.inDays, // Assuming time gap is in days
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      totalPrice: map['totalPrice'],
      divisions: map['divisions'],
      timeGap: Duration(days: map['timeGap']),
    );
  }
}
