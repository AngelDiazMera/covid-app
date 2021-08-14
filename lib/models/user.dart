class User {
  int? id;
  String? name;
  String? lastName;
  String? email;
  String psw;
  String gender;
  String? healthCondition;
  bool isDarkTheme;

  User({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.psw = '',
    this.gender = 'male',
    this.healthCondition,
    this.isDarkTheme = false,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        name: json['name'],
        lastName: json['lastName'],
        gender: json['gender'],
        email: json['access']['email'],
        psw: json['access']['password']);
  }

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'lastName': this.lastName,
        'gender': this.gender,
        'access': {'email': this.email, 'password': this.psw},
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
