import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/patient_model.dart';

class AddPatientScreen extends StatelessWidget {

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final diseaseController = TextEditingController();

  void savePatient(BuildContext context) async {

    final patient = Patient(
      name: nameController.text,
      age: int.parse(ageController.text),
      disease: diseaseController.text,
    );

    await DatabaseHelper.instance.insertPatient(patient);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Patient"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Patient Name"),
            ),

            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: "Age"),
              keyboardType: TextInputType.number,
            ),

            TextField(
              controller: diseaseController,
              decoration: InputDecoration(labelText: "Disease"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => savePatient(context),
              child: Text("Save Patient"),
            )

          ],
        ),
      ),
    );
  }
}
