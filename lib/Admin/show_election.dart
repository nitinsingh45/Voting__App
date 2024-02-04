// show_election.dart
import 'package:flutter/material.dart';
import 'package:voting_app/models/election_model.dart';
import 'package:voting_app/services/create_election_database_helper.dart';

class ShowElectionsScreen extends StatefulWidget {
  @override
  _ShowElectionsScreenState createState() => _ShowElectionsScreenState();
}

class _ShowElectionsScreenState extends State<ShowElectionsScreen> {
  late DatabaseHelper _databaseHelper;
  late Future<List<Election>> _elections;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
    _elections = _loadElections();
  }

  Future<List<Election>> _loadElections() async {
    await _databaseHelper.initializeDatabase();
    return _databaseHelper.getElections();
  }

  Future<void> _deleteElection(int id) async {
    await _databaseHelper.deleteElection(id);
    // Refresh the list of elections after deletion
    setState(() {
      _elections = _loadElections();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Election'),
        backgroundColor: Colors.green.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Election>>(
          future: _elections,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No election data available');
            } else {
              List<Election> elections = snapshot.data!;
              return Column(
                children: elections.map((election) {
                  return Card(
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoTile('Election ID', election.electionId),
                        _buildInfoTile(
                            'Election Date', election.electionDate.toString()),
                        _buildInfoTile('Election Name', election.electionName),
                        ElevatedButton(
                          onPressed: () {
                            _deleteElection(election.id);
                            setState(() {}); // Trigger a rebuild after deletion
                          },
                          child: Text('Delete Election'),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildInfoTile(String label, dynamic value) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text('$value'),
    );
  }
}
