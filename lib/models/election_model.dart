// election_model.dart

class Election {
  final int id;
  final String electionId;
  final DateTime electionDate;
  final String electionName;

  Election({
    required this.id,
    required this.electionId,
    required this.electionDate,
    required this.electionName,
  });

  // Add this method to convert Election object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'electionId': electionId,
      'electionDate': electionDate.toIso8601String(),
      'electionName': electionName,
    };
  }
}
