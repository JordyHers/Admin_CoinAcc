import 'package:admincoinacc/main.dart';
import 'package:admincoinacc/models/fetch_order_details.dart';
import 'package:admincoinacc/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admincoinacc/models/cart_item_model.dart';
import 'package:flutter/cupertino.dart';

class OrderServices {
  String collection = "orders";
  Firestore _firestore = Firestore.instance;
  String userName;
  int total=0;
  int temp;
  Main main;
  List <DetailsModel>cart =[];


  Future<List<OrderModel>> getOrders1() async =>
      _firestore.collection(collection)
          .orderBy("createdAt", descending: true)
          .getDocuments()
          .then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot ord in result.documents) {
          orders.add(OrderModel.fromSnapshot(ord));
        }
        return orders;
      });


  Future<List<DetailsModel>> getCart() async =>
      _firestore.collection(collection).orderBy("createdAt",descending: true).getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((result) {
          main =  Main(
            id:result.data["id"],
            name:result.data["name"],
            surname:result.data["surname"],
            price: result.data['total'],
            telephone: result.data['telephone'],
            address: result.data['address'],
            createdAt: result.data['createdAt'],
            cart: List<Cart>.from(result.data["cart"].map((item){
              print(item["name"] + "  item[name]");
              print(item["price"].toString() + "  item[price]");
              print(result.data["id"] +"  result.data[id]");
              print(result.data["name"] + "  result.data[name]");
              print(result.data["surname"] + " result.data[surname]");
              return Cart(
                name: item["name"],
                price: item["price"],
              );

            })));
          for (DocumentSnapshot ord in querySnapshot.documents) {
            cart.add(DetailsModel.fromSnapshot(ord));
          }

         // print(cart[0]);
        });
        return cart;
      });




  Future<List<DocumentSnapshot>> getOrders()=>_firestore.collection(collection).getDocuments().then((snaps) {
    return snaps.documents;
  });



  Future <String> getUserName(String userId) async =>
      _firestore
          .collection("kullanici")
          .document(userId)
          .get()
          .then((value) {
            userName = value.data['name'];
        print (value.data["name"]);
        //String userFullName = value.data['surname'];
        return value.data["name"];
      });

  Future<String> getNumOrders(String id) async =>
      Firestore.instance.collection(collection).document(id).get().then((value){
        print(value.data["id"] + " from order value.data[id]");
        String order = value.data["id"] ;
        print(order + " from order ");
        return order;
      });


}
class Main {
  final String id;
  final String name;
  final String surname;
  final int price;
  final int telephone;
  final int createdAt;
  final String address;
  final List <Cart> cart;
  Main ({this.surname,this.cart,this.name,this.id,this.price,this.telephone,this.address,this.createdAt});

}

class Cart {
  final String name;
  final int price;
  Cart ({this.name,this.price});
}