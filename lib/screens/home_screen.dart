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
  List<Patient> filteredPatients = [];

  TextEditingController searchController = TextEditingController();

  void loadPatients() async {
    final data = await DatabaseHelper.instance.getPatients();
    setState(() {
      patients = data;
      filteredPatients = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPatients();
  }

  void searchPatient(String query) {
    final result = patients.where((p) {
      return p.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredPatients = result;
    });
  }

  void deletePatient(int id) async {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Patient"),
        content: Text("Are you sure you want to delete this patient?"),
        actions: [

          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),

          TextButton(
            onPressed: () async {
              await DatabaseHelper.instance.deletePatient(id);
              Navigator.pop(context);
              loadPatients();
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor App"),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(10),

        child: Column(
          children: [

            // Patient Count
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people),
                  SizedBox(width: 10),
                  Text(
                    "Total Patients: ${patients.length}",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),

            SizedBox(height: 10),

            // Search Box
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search Patient",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: searchPatient,
            ),

            SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: filteredPatients.length,
                itemBuilder: (context, index) {

                  final patient = filteredPatients[index];

                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 6),

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
            ),
          ],
        ),
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