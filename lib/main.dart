import 'package:flutter/material.dart';
import 'screens/sign_in_screen.dart';

void main() {
  runApp(FacilityPaymentApp());
}

class FacilityPaymentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Facility Payment App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SignInScreen(),
    );
  }
}
