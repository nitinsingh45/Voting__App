// manage_candidate.dart

import 'package:flutter/material.dart';
import 'package:voting_app/models/candidate_model.dart';
import 'package:voting_app/services/candidate_database_helper.dart';

class ManageCandidate extends StatefulWidget {
  @override
  _ManageCandidateState createState() => _ManageCandidateState();
}

class _ManageCandidateState extends State<ManageCandidate> {
  late Future<List<Candidate>> candidates;

  @override
  void initState() {
    super.initState();
    candidates = CandidateDatabaseHelper.instance.getAllCandidates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Candidates'),
        backgroundColor: Colors.green.shade600,
      ),
      body: FutureBuilder<List<Candidate>>(
        future: candidates,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final candidateList = snapshot.data!;

            return ListView.builder(
              itemCount: candidateList.length,
              itemBuilder: (context, index) {
                final candidate = candidateList[index];

                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: ${candidate.name}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text('Semester: ${candidate.semester}'),
                        Text('Post ID: ${candidate.postId}'),
                        Text('Department: ${candidate.department}'),
                        Text('USN: ${candidate.usn}'),
                        Text('Phone Number: ${candidate.phoneNumber}'),
                        Text('Email: ${candidate.email}'),
                        Text('Election ID: ${candidate.electionId}'),
                        Text('Gender: ${candidate.gender}'),

                        // Delete button for each card
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _showDeleteDialog(candidate.id!);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  // Function to show a delete confirmation dialog for each card
  Future<void> _showDeleteDialog(int candidateId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Candidate'),
          content: Text('Are you sure you want to delete this candidate?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await CandidateDatabaseHelper.instance
                    .deleteCandidate(candidateId);
                Navigator.of(context).pop();
                // Refresh the candidate list after deletion
                setState(() {
                  candidates =
                      CandidateDatabaseHelper.instance.getAllCandidates();
                });
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
