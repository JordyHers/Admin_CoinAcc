import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsModel {
  static const ID = "id";
  static const CART = "cart";
  static const USER_NAME = "name";
  static const USER_SURNAME = "surname";



  String id;
  String name;
  String surname;


  DetailsModel();

//  getters
//   String get id => _id;
//
//   String get description => _description;
//
//   String get userId => _userId;
//
//   String get status => _status;
//
//   int get total => _total;
//
//   int get createdAt => _createdAt;

  // public variable
  List cart;

  DetailsModel.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.data[ID];
    name = snapshot.data[USER_NAME];
    surname = snapshot.data[USER_SURNAME];
    cart = snapshot.data[CART];
  }

  DetailsModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    surname = data['surname'];
    cart  = data['cart'];

  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'cart': cart,
    };
  }
}