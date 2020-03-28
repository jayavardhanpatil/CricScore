
class User{

   String uid;
   String name;
   String city;
   int phoneNumber;
   String dob;
   String email;

  User({this.uid, this.name = null, this.city = null, this.phoneNumber = null, this.dob = null, this.email});

  Map<String,dynamic> get map {
    return {
      "name": name,
      "city":city,
      "phoneNumber": phoneNumber,
      "dateOfBirth": dob,
      "email": email
    };
  }

  User mapJsonToUserObject(String key, dynamic value){
    this.name = value['name'];
    this.city = value['city'];
    this.phoneNumber = value['phoneNumber'];
    this.email = value['email'];
    this.dob = value['dateOfBirth'];
    this.uid = key;
    return this;
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
    return this.dob;
  }

  String getCity(){
    return this.city;
  }


}