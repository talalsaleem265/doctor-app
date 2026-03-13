import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/patient_model.dart';

class EditPatientScreen extends StatefulWidget {

  final Patient patient;

  EditPatientScreen({required this.patient});

  @override
  _EditPatientScreenState createState() => _EditPatientScreenState();
}

class _EditPatientScreenState extends State<EditPatientScreen> {

  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController diseaseController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.patient.name);
    ageController = TextEditingController(text: widget.patient.age.toString());
    diseaseController = TextEditingController(text: widget.patient.disease);
  }

  void updatePatient() async {

    final updatedPatient = Patient(
      id: widget.patient.id,
      name: nameController.text,
      age: int.parse(ageController.text),
      disease: diseaseController.text,
    );

    await DatabaseHelper.instance.updatePatient(updatedPatient);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Patient"),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Patient Name",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Age",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: diseaseController,
              decoration: InputDecoration(
                labelText: "Disease",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: updatePatient,
              child: Text("Update Patient"),
            )

          ],
        ),
      ),
    );
  }
}