// candidate_registration.dart

import 'package:flutter/material.dart';
import 'package:voting_app/models/candidate_model.dart';
import 'package:voting_app/services/candidate_database_helper.dart';

class CandidateRegistration extends StatefulWidget {
  @override
  _CandidateRegistrationState createState() => _CandidateRegistrationState();
}

class _CandidateRegistrationState extends State<CandidateRegistration> {
  late TextEditingController nameController;
  late TextEditingController semesterController;
  late TextEditingController postIdController;
  late TextEditingController departmentController;
  late TextEditingController usnController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;
  late TextEditingController electionIdController;
  late TextEditingController genderController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    semesterController = TextEditingController();
    postIdController = TextEditingController();
    departmentController = TextEditingController();
    usnController = TextEditingController();
    phoneNumberController = TextEditingController();
    emailController = TextEditingController();
    electionIdController = TextEditingController();
    genderController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Candidate Registration'),
        backgroundColor: Colors.green.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: semesterController,
                decoration: InputDecoration(labelText: 'Semester'),
              ),
              TextField(
                controller: postIdController,
                decoration: InputDecoration(labelText: 'Post ID'),
              ),
              TextField(
                controller: departmentController,
                decoration: InputDecoration(labelText: 'Department'),
              ),
              TextField(
                controller: usnController,
                decoration: InputDecoration(labelText: 'USN'),
              ),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: electionIdController,
                decoration: InputDecoration(labelText: 'Election ID'),
              ),
              TextField(
                controller: genderController,
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final candidate = Candidate(
                    name: nameController.text,
                    semester: semesterController.text,
                    postId: postIdController.text,
                    department: departmentController.text,
                    usn: usnController.text,
                    phoneNumber: phoneNumberController.text,
                    email: emailController.text,
                    electionId: electionIdController.text,
                    gender: genderController.text,
                  );

                  await CandidateDatabaseHelper.instance
                      .insertCandidate(candidate);
                  // You can add a success message or navigation to the next screen here
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
