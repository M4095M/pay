import 'package:flutter/material.dart';
import 'seller_home_screen.dart';
import 'client_home_screen.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facility Payment App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SellerHomeScreen()),
                );
              },
              child: Text('Sign In as Seller'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClientHomeScreen()),
                );
              },
              child: Text('Sign In as Client'),
            ),
          ],
        ),
      ),
    );
  }
}
