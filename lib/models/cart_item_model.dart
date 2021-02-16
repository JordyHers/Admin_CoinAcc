import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  static const ID = 'id';
  static const NAME = 'name';
  static const IMAGE = 'image';
  static const PRODUCT_ID = 'productId';
  static const PRICE = 'price';
  static const DESCRIPTION = 'description';

  String _id;
  String _name;
  String _image;
  String _productId;
  String _description;
  int _price;

  //  getters
  String get id => _id;

  String get name => _name;

  String get image => _image;

  String get productId => _productId;

  String get description=> _description;

  int get price => _price;

  CartItemModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _name = snapshot.data[NAME];
    _image = snapshot.data[IMAGE];
    _productId =snapshot.data[PRODUCT_ID];
    _description =snapshot.data[DESCRIPTION];
    _price = snapshot.data[PRICE];
  }

  CartItemModel.fromMap(Map data){
    _id = data[ID];
    _name =  data[NAME];
    _image =  data[IMAGE];
    _productId = data[PRODUCT_ID];
    _price = data[PRICE];
    _description = data[DESCRIPTION];
  }

  Map toMap() => {
    ID: _id,
    IMAGE: _image,
    NAME: _name,
    PRODUCT_ID: _productId,
    PRICE: _price,
    DESCRIPTION: _description,
  };
}