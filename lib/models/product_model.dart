import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  static const ID = "id";
  static const NAME = "name";
  static const PICTURE = "picture";
  static const PRICE = "price";
  static const DESCRIPTION = "description";
  static const CATEGORY = "category";
  static const QUANTITY = "quantity";
  static const SALE = "sale";

  String _id;
  String _name;
  String _picture;
  String _description;
  String _category;
  int _quantity;
  int _price;
  bool _sale;


  String get id => _id;

  String get name => _name;

  String get picture => _picture;

  String get category => _category;

  String get description => _description;

  int get quantity => _quantity;

  int get price => _price;

  bool get sale => _sale;


  Product.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _sale = snapshot.data[SALE];
    _description = snapshot.data[DESCRIPTION] ?? " ";
    _price = snapshot.data[PRICE].floor();
    _category = snapshot.data[CATEGORY];
    _name = snapshot.data[NAME];
    _picture = snapshot.data[PICTURE];


  }
   Product.fromMap(Map<String, dynamic> data) {
    _id = data['id'];
    _name = data['name'];
    _sale = data['sale'];
    _price = data['price'];
     _picture = data['picture'];
     _category= data['category'];
    _description= data['description'];

  }

}