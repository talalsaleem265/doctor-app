import 'package:flutter/material.dart';
import '../models/patient_model.dart';

class PatientDetailScreen extends StatelessWidget {

  final Patient patient;

  const PatientDetailScreen({required this.patient});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Patient Details"),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Name: ${patient.name}",
                style: TextStyle(fontSize: 20)),

            SizedBox(height: 10),

            Text("Age: ${patient.age}",
                style: TextStyle(fontSize: 18)),

            SizedBox(height: 10),

            Text("Disease: ${patient.disease}",
                style: TextStyle(fontSize: 18)),

          ],
        ),
      ),
    );
  }
}