import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final String vin;

  const SearchButton({Key? key, required this.vin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // TODO: Implement search functionality
        // You can use the VIN number stored in 'vin' to search for vehicle info
      },
      child: Text('Search'),
    );
  }
}
