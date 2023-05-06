import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VinInfoScreen extends StatefulWidget {
  final String vin;

  VinInfoScreen({required this.vin});

  @override
  _VinInfoScreenState createState() => _VinInfoScreenState();
}

class _VinInfoScreenState extends State<VinInfoScreen> {
  String _makeModel = '';
  String _year = '';
  String _bodyStyle = '';
  String _engineType = '';
  String _transmission = '';
  String _drivetrain = '';
  String _fuelType = '';
  String _manufacturer = '';
  String _plant = '';

  @override
  void initState() {
    super.initState();
    fetchVehicleInfo();
  }

  Future<void> fetchVehicleInfo() async {
    final response = await http.get(
      Uri.parse(
          'https://vpic.nhtsa.dot.gov/api/vehicles/decodevinvalues/${widget.vin}?format=json'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _makeModel = data['Results'][0]['Make'];
        _year = data['Results'][0]['ModelYear'];
        _bodyStyle = data['Results'][0]['BodyClass'];
        _engineType = data['Results'][0]['EngineType'];
        _transmission = data['Results'][0]['TransmissionStyle'];
        _drivetrain = data['Results'][0]['DriveType'];
        _fuelType = data['Results'][0]['FuelTypePrimary'];
        _manufacturer = data['Results'][0]['Manufacturer'];
        _plant = data['Results'][0]['PlantCountry'] +
            ', ' +
            data['Results'][0]['PlantState'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Information'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Make/Model: $_makeModel',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Year: $_year',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Body Style: $_bodyStyle',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Engine Type: $_engineType',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Transmission: $_transmission',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Drivetrain: $_drivetrain',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Fuel Type: $_fuelType',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Manufacturer: $_manufacturer',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Plant: $_plant',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
