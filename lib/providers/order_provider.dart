import 'package:admincoinacc/models/cart_item_model.dart';
import 'package:admincoinacc/models/fetch_order_details.dart';
import 'package:admincoinacc/models/order.dart';
import 'package:admincoinacc/orderServices/get_orders_list.dart';
// import 'package:shop_app/db/products.dart';
import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  OrderServices _orderServices = OrderServices();
  List<OrderModel> orders = [];
  List <DetailsModel>cart =[];



  OrderProvider.initialize() {
    loadOrder();
   loadCart();
  }

  loadOrder() async {
    orders = await _orderServices.getOrders1();
    notifyListeners();
  }

  loadCart() async {
    cart = await _orderServices.getCart();
    notifyListeners();
  }


  // Future search({String productName}) async {
  //   // productsSearched = await _productServices.searchTur(productName: productName);
  //   productsSearched =
  //       await _productServices.searchTar(productName: productName);
  //
  //   notifyListeners
  //     (
  //   );
  // }
}
