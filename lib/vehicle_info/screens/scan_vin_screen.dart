import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'vin_info_screen.dart';

class VinScannerScreen extends StatefulWidget {
  @override
  _VinScannerScreenState createState() => _VinScannerScreenState();
}

class _VinScannerScreenState extends State<VinScannerScreen> {
  String barcode = '';

  Future<void> scanBarcode() async {
    try {
      final result = await BarcodeScanner.scan();
      setState(() {
        barcode = result.rawContent;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VinInfoScreen(vin: barcode),
        ),
      );
    } catch (e) {
      setState(() {
        barcode = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VIN Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/qr_code.svg',
              width: 200.0,
              height: 200.0,
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: scanBarcode,
              child: Text('Scan VIN'),
            ),
            SizedBox(height: 20.0),
            Text(barcode),
          ],
        ),
      ),
    );
  }
}
