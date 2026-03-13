import 'package:flutter/material.dart';
import '../models/patient_model.dart';

class PatientCard extends StatelessWidget {

  final Patient patient;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PatientCard({
    required this.patient,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),

      child: ListTile(

        leading: CircleAvatar(
          backgroundColor: Colors.teal,
          child: Icon(Icons.person, color: Colors.white),
        ),

        title: Text(
          patient.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        subtitle: Text(
          "Age: ${patient.age} | Disease: ${patient.disease}",
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            IconButton(
              icon: Icon(Icons.edit, color: Colors.orange),
              onPressed: onEdit,
            ),

            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),

          ],
        ),
      ),
    );
  }
}