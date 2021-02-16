
import 'package:admincoinacc/db/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'admin.dart';

class ListCategory extends StatefulWidget {
  @override
  _ListCategoryState createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {

  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  CategoryService _categoryService = CategoryService();

 @override
 void initState() {
    super.initState();
    _getCategories();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        leading: InkWell(
          onTap: (){ Navigator.pop(context, MaterialPageRoute(builder: (_) => Admin()));},
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text('Kategori Listesi',style: TextStyle(color: Colors.black),),
        //leading: Icon(Icons.category,color: Colors.red.shade400,),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: ListView.separated(itemBuilder:(BuildContext context,int index){
         return ListTile(
           title: Text(categories[index].data['category']),
         );
      }  , separatorBuilder: (BuildContext context, int index){
        return Divider(thickness: 1,color: Colors.grey,);
      }, itemCount: categories.length  ),

    );
  }
  _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    print(data.length);
    setState(() {
      categories = data;
    });
  }
}
