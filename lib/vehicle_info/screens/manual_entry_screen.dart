import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManualEntryScreen extends StatefulWidget {
  @override
  _ManualEntryScreenState createState() => _ManualEntryScreenState();
}

class _ManualEntryScreenState extends State<ManualEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _vinController = TextEditingController();

  @override
  void dispose() {
    _vinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manual Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _vinController,
                decoration: InputDecoration(
                  labelText: 'VIN Number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a VIN number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      String vinNumber = _vinController.text;
                      var response = await http.get(Uri.parse(
                          'https://vpic.nhtsa.dot.gov/api/vehicles/decodevinvalues/$vinNumber?format=json'));
                      if (response.statusCode == 200) {
                        // decode the JSON response
                        var data = jsonDecode(response.body);
                        // get the vehicle details
                        String make = data['Results'][0]['Make'];
                        String model = data['Results'][0]['Model'];
                        int year = int.parse(data['Results'][0]['ModelYear']);
                        String bodyType = data['Results'][0]['BodyClass'];
                        String fuelType = data['Results'][0]['FuelTypePrimary'];
                        // navigate to the VehicleDetailsScreen and pass the details as arguments
                        Navigator.pushNamed(context, '/vehicleDetails',
                            arguments: {
                              'make': make,
                              'model': model,
                              'year': year,
                              'bodyType': bodyType,
                              'fuelType': fuelType,
                            });
                      } else {
                        // show an error message
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Error'),
                            content: Text('Failed to get vehicle details'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
