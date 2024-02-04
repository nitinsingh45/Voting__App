import 'package:flutter/material.dart';
import 'package:voting_app/Admin/manage_candidate.dart';
import 'package:voting_app/candidates/candidate_registration.dart';

class CandidatesScreen extends StatefulWidget {
  const CandidatesScreen({Key? key}) : super(key: key);

  @override
  State<CandidatesScreen> createState() => _CandidatesScreenState();
}

class _CandidatesScreenState extends State<CandidatesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('candidate'),
        backgroundColor: Colors.green.shade600,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          buildCard("Candidate Registration", () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CandidateRegistration()));
          }),
          buildCard("Check Results", () {
            // Handle manage candidates button click
          }),
          buildCard("Analysis", () {
            // Handle check results button click
          }),

          // just for checking remove baad mai

          /* buildCard("ManageCandidatesScreen", () {
            // Handle check results button click

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ManageCandidate()));
          }),*/
        ],
      ),
    );
  }

  Widget buildCard(String title, VoidCallback onPressed) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        trailing: ElevatedButton(
          onPressed: onPressed,
          child: Text('Go'),
        ),
      ),
    );
  }
}
