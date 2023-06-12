class RegisterModel {
    bool status;
    //String message;
    UserData data;

  RegisterModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    // message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null ;
  }
}
//
// class UserData
// {
//    int id;
//    String name;
//    String email;
//    String phone;
//    String image;
//    int points;
//    int credit;
//    String token;
//
//
//   UserData.fromJson(Map<String, dynamic> json)
//   {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     image = json['image'];
//     points = json['points'];
//     credit = json['credit'];
//     token = json['token'];
//   }
// }

class UserData {
  final bool status;
  final String firstName;
  final String lastName;
  final String userName;
  final String height;
  final String weight;
  final String phone;
  final String address;
  final String message;
  final String username;
  final String password;
  final String email;

  UserData({
    this.status,
    this.message,
    this.username,
    this.password,
    this.userName,
    this.address,
    this.weight,
    this.height,
    this.lastName,
    this.firstName,
    this.phone,
    this.email,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      status: json['status'],
      message: json['message'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      password: json['password'],
      email: json['email'],
      phone: json['phone_number']
    );
  }
}
