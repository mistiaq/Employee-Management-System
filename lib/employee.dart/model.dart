class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? contact;

  UserModel({
    // this.uid,
    this.email, this.firstName, this.secondName, this.contact});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      // uid: map['uid'],
      email: map['Email'],
      firstName: map['First Name'],
      secondName: map['Last Name'],
      contact: map['Contact Number'],
    );
  }

}