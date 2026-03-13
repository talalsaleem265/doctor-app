import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/patient_model.dart';
import 'add_patient_screen.dart';
import 'edit_patient_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Patient> patients = [];

  void loadPatients() async {
    final data = await DatabaseHelper.instance.getPatients();
    setState(() {
      patients = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPatients();
  }

  void deletePatient(int id) async {
    await DatabaseHelper.instance.deletePatient(id);
    loadPatients();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor App"),
        centerTitle: true,
      ),

      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {

          final patient = patients[index];

          return Card(
            margin: EdgeInsets.all(10),

            child: ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),

              title: Text(patient.name),

              subtitle: Text(
                "Age: ${patient.age} | Disease: ${patient.disease}",
              ),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.orange),
                    onPressed: () async {

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditPatientScreen(patient: patient),
                        ),
                      );

                      loadPatients();
                    },
                  ),

                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      deletePatient(patient.id!);
                    },
                  ),

                ],
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),

        onPressed: () async {

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddPatientScreen(),
            ),
          );

          loadPatients();
        },
      ),
    );
  }
}