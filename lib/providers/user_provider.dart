import 'dart:async';

import 'package:admincoinacc/models/users.dart';
import 'package:admincoinacc/db/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:coinaccessoires/services/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  UsersService _userServices = UsersService();
  // OrderServices _orderServices = OrderServices();

  UserModel _userModel;

//  getter
  UserModel get userModel => _userModel;

  Status get status => _status;

  FirebaseUser get user => _user;

  // public variables
  // List<OrderModel> orders = [];

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp(String name, String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        _userServices.createUser({
          'name': name,
          'email': email,
          'uid': user.user.uid,
          'stripeId': ''
        });
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(FirebaseUser user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      _userModel = await _userServices.getUserById(user.uid);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

//   Future<bool> addToCart(
//       {Product product, String size, String color}) async {
//     try {
//       var uuid = Uuid();
//       String cartItemId = uuid.v4();
//       List<CartItemModel> cart = _userModel.cart;
//
//       Map cartItem = {
//         "id": cartItemId,
//         "name": product.name,
//         "image": product.picture,
//         "productId": product.id,
//         "price": product.price,
//         "size": size,
//         "color": color
//       };
//
//       CartItemModel item = CartItemModel.fromMap(cartItem);
// //      if(!itemExists){
//       print("CART ITEMS ARE: ${cart.toString()}");
//       _userServices.addToCart(userId: _user.uid, cartItem: item);
// //      }
//
//       return true;
//     } catch (e) {
//       print("THE ERROR ${e.toString()}");
//       return false;
//     }
//   }
  //
  // Future<bool> removeFromCart({CartItemModel cartItem})async{
  //   print("THE PRODUC IS: ${cartItem.toString()}");
  //
  //   try{
  //     _userServices.removeFromCart(userId: _user.uid, cartItem: cartItem);
  //     return true;
  //   }catch(e){
  //     print("THE ERROR ${e.toString()}");
  //     return false;
  //   }
  //
  // }

  // getOrders()async{
  //   orders = await _orderServices.getUserOrders(userId: _user.uid);
  //   notifyListeners();
  // }

  Future<void> reloadUserModel()async{
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }
}