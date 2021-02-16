import 'package:admincoinacc/db/product.dart';
import 'package:admincoinacc/screens/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'admin.dart';

class ListProduct extends StatefulWidget {
  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  List<DocumentSnapshot> product = <DocumentSnapshot>[];
  ProductService productService = ProductService();

  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context, MaterialPageRoute(builder: (_) => Admin()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Liste des articles',
          style: TextStyle(color: Colors.black),
        ),
        //leading: Icon(Icons.category,color: Colors.red.shade400,),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body:   ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading:  Image.network(
                product[index].data['picture'],
                width:110,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              title: Text(product[index].data['name']),
              subtitle: Text(product[index].data['description']),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              thickness: 1,
              color: Colors.grey,
            );
          },
          itemCount: product.length),
    );
  }

  _getProducts() async {
    List<DocumentSnapshot> data1 = await productService.getBij();
    List<DocumentSnapshot> data2 = await productService.getMai();
    List<DocumentSnapshot> data3 = await productService.getChau();
    List<DocumentSnapshot> data4 = await productService.getSac();
    List<DocumentSnapshot> data5 = await productService.getAcc();
    List<DocumentSnapshot> data6 = await productService.getOwa();
    List<DocumentSnapshot> data7 = await productService.getSou();
    List<DocumentSnapshot> data8 = await productService.getPyj();
    print(data1.length);
    setState(() {
      product = data1 + data2 + data3 + data4 + data5 + data6 + data7 + data8;
    });
  }
}
