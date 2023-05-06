import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:share/share.dart';

class VehicleDetailsScreen extends StatelessWidget {
  final String make;
  final String model;
  final int year;

  VehicleDetailsScreen(
      {required this.make, required this.model, required this.year});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Details'),
        actions: [
          IconButton(
            onPressed: () async {
              // generate a PDF file with the vehicle information
              final pdfLib.Document pdf = pdfLib.Document();
              pdf.addPage(
                pdfLib.Page(
                  build: (context) => pdfLib.Center(
                    child: pdfLib.Text(
                      '$make $model $year',
                      style: pdfLib.TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              );
              final bytes = await pdf.save();

              // save the PDF file to the device's external storage
              final directory = await getExternalStorageDirectory();
              final file = File('${directory!.path}/vehicle_info.pdf');
              await file.writeAsBytes(bytes);

              // show a snackbar to indicate that the file has been saved
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('File saved to ${file.path}'),
                  duration: Duration(seconds: 3),
                ),
              );
            },
            icon: Icon(Icons.download),
          ),
          IconButton(
            onPressed: () {
              // share the vehicle information
              Share.share('$make $model $year');
            },
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Make: $make',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Model: $model',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Year: $year',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
