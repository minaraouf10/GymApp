class LoginModel {
  final String status;
  final int id;
  final String firstName;
  final String lastName;
  final String userName;
  final String height;
  final String weight;
  final String phone;
  final String address;
  final String message;
  final String password;
  final String email;
  final String gender;
  final String gymName;

  LoginModel({
    this.status,
    this.id,
    this.message,
    this.password,
    this.userName,
    this.address,
    this.weight,
    this.height,
    this.lastName,
    this.firstName,
    this.phone,
    this.email,
    this.gender,
    this.gymName,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'],
      id: json['id'] as int,
      message: json['message'],
      userName: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      password: json['password'],
      email: json['email'],
      phone: json['phone_number'],
      address :json['address'],
      height :json['height'],
      weight :json['weight'],
      gender :json['gender'],
      gymName :json['gym_name'],
    );
  }
}
