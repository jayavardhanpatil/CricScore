


class User{

  String uid;
  String name;
  String city;
  int phoneNumber;
  String dateOfBirth;
  String email;

  User(
      {this.uid,
        this.name,
        this.city,
        this.phoneNumber,
        this.dateOfBirth,
        this.email});

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      city: json['city'],
      dateOfBirth: json['dateOfBirth'],
      email: json['email'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['dateOfBirth'] = this.dateOfBirth;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['uid'] = this.uid;
    return data;
  }

  String getEmailId(){
    return this.email;
  }

  String getName(){
    return this.name;
  }

  int getPhoneNumber(){
    return this.phoneNumber;
  }

  String getDateOfBirth(){
    return this.dateOfBirth;
  }

  String getCity(){
    return this.city;
  }

}