import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  static const ID = "id";
  static const DESCRIPTION = "description";
  static const CART = "cart";
  static const USER_ID = "userId";
  static const USER_NAME = "name";
  static const USER_SURNAME = "surname";
  static const USER_ADDRESS = "address";
  static const USER_PHONE_NUMBER = "telephone";
  static const TOTAL = "total";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";

  String id;
  String description;
  String userId;
  String status;
  int createdAt;
  int total;
  String name;
  String surname;
  String address;
  String telephone;

  OrderModel();

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

  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.data[ID];
    description = snapshot.data[DESCRIPTION];
    total = snapshot.data[TOTAL];
    status = snapshot.data[STATUS];
    userId = snapshot.data[USER_ID];
    name = snapshot.data[USER_NAME];
    surname = snapshot.data[USER_SURNAME];
    address = snapshot.data[USER_ADDRESS];
    telephone = snapshot.data[USER_PHONE_NUMBER];
    createdAt = snapshot.data[CREATED_AT];
    cart = snapshot.data[CART];
  }

  OrderModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    description = data['description'];
    total = data['total'];
    userId = data['userId'];
    name = data['name'];
    surname = data['surname'];
    address = data['address'];
    telephone = data['telephone'];
    createdAt= data['createdAt'];
    cart  = data['cart'];

  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'total': total,
      'userId': userId,
      'name': name,
      'surname': surname,
      'address': address,
      'telephone': telephone,
      'createdAt': createdAt,
      'cart': cart,
    };
  }
}