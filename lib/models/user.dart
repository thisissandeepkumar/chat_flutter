class User {
  int id;
  String username;
  String email;
  String firstname;
  String lastname;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstname,
    required this.lastname,
  });

  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
        email: json['email'],
        id: json['id'],
        username: json['username'],
        firstname: json['firstname'],
        lastname: json['lastname']);
  }

  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "username": username,
      "firstname": firstname,
      "lastname": lastname,
      "email": email
    };
  }
}
