// candidate_model.dart

class Candidate {
  int? id;
  String name;
  String semester;
  String postId;
  String department;
  String usn;
  String phoneNumber;
  String email;
  String electionId;
  String gender;

  Candidate({
    this.id,
    required this.name,
    required this.semester,
    required this.postId,
    required this.department,
    required this.usn,
    required this.phoneNumber,
    required this.email,
    required this.electionId,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'semester': semester,
      'postId': postId,
      'department': department,
      'usn': usn,
      'phoneNumber': phoneNumber,
      'email': email,
      'electionId': electionId,
      'gender': gender,
    };
  }
}
