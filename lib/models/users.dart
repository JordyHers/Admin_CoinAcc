import 'package:cloud_firestore/cloud_firestore.dart';


class UserModel {
  static const NAME = "name";
  static const ID = "uid";
  static const SURNAME = "surname";
  static const TELEPHONE = "telephone";
  static const ADDRESS= "address";
  static const IMAGE ="image";
  static const EMAIL = "email";


  String name;
  String surname;
  String telephone;
  String address;
  String id;
  String email;
  String image;



  UserModel();

//  getters
//   String get name => _name;
//   String get surname => _surname;
//   String get telephone => _telephone;
//   String get address => _address;
//   String get id => _id;
//   String get email => _email;
  //String get image => image;


  // public variables

  // public variables
  int totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.data[ID];
    name = snapshot.data[NAME];
    surname = snapshot.data[SURNAME];
    telephone= snapshot.data[TELEPHONE];
    address = snapshot.data[ADDRESS];
    email = snapshot.data[EMAIL];
    image = snapshot.data[IMAGE];

  }
  UserModel.fromMap(Map<String, dynamic> data) {
    id = data['uid'];
   name = data['name'];
   surname = data['surname'];
   image = data['image'];
   telephone= data['telephone'];
   email = data['email'];

  }


  Map<String, dynamic> toMap() {
    return {
      'uid': id,
      'name': name,
      'image': image,
      'surname': surname,
      'telephone': telephone,
      'email': email,
      'address':address,
    };
  }


}
