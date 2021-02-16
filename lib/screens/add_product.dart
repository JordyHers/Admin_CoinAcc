import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../db/product.dart';
import 'package:provider/provider.dart';
import '../providers/products_providers.dart';
import '../db/category.dart';
import '../db/brand.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  ProductService productService = ProductService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController quatityController = TextEditingController();
  TextEditingController descriptionController= TextEditingController();

  final priceController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
  <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory;
  String _currentBrand;
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
  List<String> selectedSizes = <String>[];
  List<String> selectedPointure = <String>[];
  List<String> colors = <String>[];
  bool onSale = false;
  bool featured = false;
  File _image2,_image3;
  File _image1;
  bool isLoading = false;

  @override
  void initState() {
    _getCategories();

  }

  List<DropdownMenuItem<String>> getCategoriesDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < categories.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(categories[i].data['category']),
                value: categories[i].data['category']));
      });
    }
    return items;
  }

  List<DropdownMenuItem<String>> getBrandosDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < brands.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(brands[i].data['brand']),
                value: brands[i].data['brand']));
      });
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: white,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            color: black,
          ),
        ),
        title: Text(
          "ajoute un produit",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isLoading
              ? CircularProgressIndicator()
              : Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 90,
                        width: 80,
                        child: OutlineButton(
                            borderSide: BorderSide(
                                color: grey.withOpacity(0.5), width: 2.5),
                            onPressed: () {
                              _selectImage(
                                ImagePicker.pickImage(
                                    source: ImageSource.gallery),1
                              );
                            },
                            child: _displayChild1()),
                      ),
                    ),
                  ), Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 90,
                        width: 80,
                        child: OutlineButton(
                            borderSide: BorderSide(
                                color: grey.withOpacity(0.5), width: 2.5),
                            onPressed: () {
                              _selectImage(
                                ImagePicker.pickImage(
                                    source: ImageSource.gallery),2
                              );
                            },
                            child: _displayChild2()),
                      ),
                    ),
                  ), Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 90,
                        width: 80,
                        child: OutlineButton(
                            borderSide: BorderSide(
                                color: grey.withOpacity(0.5), width: 2.5),
                            onPressed: () {
                              _selectImage(
                                ImagePicker.pickImage(
                                    source: ImageSource.gallery),3
                              );
                            },
                            child: _displayChild3()),
                      ),
                    ),
                  ),

                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'enter a product name with 10 characters at maximum',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: red, fontSize: 12),
                ),
              ),


              Text('Tailles disponibles'),

              Row(
                children: <Widget>[
                  Flexible(
                    child: Checkbox(
                        value: selectedSizes.contains('XS'),
                        onChanged: (value) => changeSelectedSize('XS')),
                  ),
                  Text('XS'),
                  Flexible(
                    child: Checkbox(
                        value: selectedSizes.contains('S'),
                        onChanged: (value) => changeSelectedSize('S')),
                  ),
                  Text('S'),
                  Flexible(
                    child: Checkbox(
                        value: selectedSizes.contains('M'),
                        onChanged: (value) => changeSelectedSize('M')),
                  ),
                  Text('M'),
                  Flexible(
                    child: Checkbox(
                        value: selectedSizes.contains('L'),
                        onChanged: (value) => changeSelectedSize('L')),
                  ),
                  Text('L'),
                  Flexible(
                    child: Checkbox(
                        value: selectedSizes.contains('XL'),
                        onChanged: (value) => changeSelectedSize('XL')),
                  ),
                  Text('XL'),
                  Flexible(
                    child: Checkbox(
                        value: selectedSizes.contains('XXL'),
                        onChanged: (value) => changeSelectedSize('XXL')),
                  ),
                  Text('XXL'),
                ],
              ),

              Text('Pointures disponibles'),

              Row(
                children: <Widget>[
                  Flexible(
                    child: Checkbox(
                        value: selectedPointure.contains('35'),
                        onChanged: (value) => changeSelectedPointure('35')),
                  ),
                  Text('35'),Flexible(
                    child: Checkbox(
                        value: selectedPointure.contains('36'),
                        onChanged: (value) => changeSelectedPointure('36')),
                  ),
                  Text('36'),Flexible(
                    child: Checkbox(
                        value: selectedPointure.contains('37'),
                        onChanged: (value) => changeSelectedPointure('37')),
                  ),
                  Text('37'),
                  Flexible(
                    child: Checkbox(
                        value: selectedPointure.contains('38'),
                        onChanged: (value) => changeSelectedPointure('38')),
                  ),
                  Text('38'),
                  Flexible(
                    child: Checkbox(
                        value: selectedPointure.contains('39'),
                        onChanged: (value) => changeSelectedPointure('39')),
                  ),
                  Text('39'),
                  Flexible(
                    child: Checkbox(
                        value: selectedPointure.contains('40'),
                        onChanged: (value) => changeSelectedPointure('40')),
                  ),
                  Text('40'),
                  Flexible(
                    child: Checkbox(
                        value: selectedPointure.contains('41'),
                        onChanged: (value) => changeSelectedPointure('41')),
                  ),
                  Text('41'),
                  Flexible(
                    child: Checkbox(
                        value: selectedPointure.contains('42'),
                        onChanged: (value) => changeSelectedPointure('42')),
                  ),
                  Text('42'),
                  Flexible(
                    child: Checkbox(
                        value: selectedPointure.contains('43'),
                        onChanged: (value) => changeSelectedPointure('43')),
                  ),
                  Text('43'),
                  Flexible(
                    child: Checkbox(
                        value: selectedPointure.contains('44'),
                        onChanged: (value) => changeSelectedPointure('44')),
                  ),
                  Text('44'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Promotion'),
                      SizedBox(width: 10,),
                      Switch(value: onSale, onChanged: (value) {
                        setState(() {
                          onSale = value;
                        });
                      }),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      Text('Featured'),
                      SizedBox(width: 10,),
                      Switch(value: featured, onChanged: (value) {
                        setState(() {
                          featured = value;
                        });
                      }),
                    ],
                  ),

                ],
              ),


              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: productNameController,
                  decoration: InputDecoration(hintText: 'Product name'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the product name';
                    } else if (value.length > 10) {
                      return 'Product name cant have more than 10 letters';
                    }
                  },
                ),
              ),

//              select category
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Categorie: ',
                      style: TextStyle(color: red),
                    ),
                  ),
                  DropdownButton(
                    items: categoriesDropDown,
                    onChanged: changeSelectedCategory,
                    value: _currentCategory,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Flexible(
                      child: Text(
                        'Marque: ',
                        style: TextStyle(color: red),
                      ),
                    ),
                  ),
                  DropdownButton(
                    items: brandsDropDown,
                    onChanged: changeSelectedBrand,
                    value: _currentBrand,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(hintText: 'description'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the product name';
                    } else if (value.length > 1000) {
                      return 'Product name cant have more than 100 letters';
                    }

                  },

                ),
              ),
//
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: quatityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Quantite',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the product name';
                    }
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Prix',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the product name';
                    }
                  },
                ),
              ),


              FlatButton(
                color: red,
                textColor: white,
                child: Text('add product'),
                onPressed: () {
                  validateAndUpload();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    print(data.length);
    setState(() {
      categories = data;
      categoriesDropDown = getCategoriesDropdown();
      _currentCategory = categories[0].data['category'];
    });
  }

  // _getBrands() async {
  //   List<DocumentSnapshot> data = await _brandService.getBrands();
  //   print(data.length);
  //   setState(() {
  //     brands = data;
  //     brandsDropDown = getBrandosDropDown();
  //     _currentBrand = brands[0].data['brand'];
  //   });
  // }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() => _currentCategory = selectedBrand);
  }

  void changeSelectedSize(String size) {
    if (selectedSizes.contains(size)) {
      setState(() {
        selectedSizes.remove(size);
      });
    } else {
      setState(() {
        selectedSizes.insert(0, size);
      });
    }
  }  void changeSelectedPointure(String pointure) {
    if (selectedPointure.contains(pointure)) {
      setState(() {
        selectedPointure.remove(pointure);
      });
    } else {
      setState(() {
        selectedPointure.insert(0, pointure);
      });
    }
  }

  void _selectImage(Future<File> pickImage, int imageNumber) async {
    File tempImg = await pickImage;
    switch (imageNumber) {
      case 1:
        setState(() => _image1 = tempImg);
        break;
      case 2:
        setState(() => _image2 = tempImg);
        break;
      case 3:
        setState(() => _image3 = tempImg);
        break;
    }
  }

  Widget _displayChild1() {
    if (_image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }
  Widget _displayChild2() {
    if (_image2 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image2,
        fit: BoxFit.fill,
        width: double.infinity,
        height: double.infinity,
      );
    }
  }
  Widget _displayChild3() {
    if (_image3 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image3,
        fit: BoxFit.fill,
        width: double.infinity,
        height: double.infinity,
      );
    }
  }

  void validateAndUpload() async {
    if (_formKey.currentState.validate()) {
      setState(() => isLoading = true);
      if (_image1 != null && _image2 != null && _image3 != null) {
        if (descriptionController !=null){
          String imageUrl1;
          String imageUrl2;
          String imageUrl3;
          String category;

          if (_currentCategory != null) {
            setState(() {
              category =_currentCategory ;
            });
            print(category);
          }
          final FirebaseStorage storage = FirebaseStorage.instance;


          final picture1 =
              '1-${DateTime
              .now()
              .millisecondsSinceEpoch
              .toString()}.jpg';
          final picture2 =
              '2-${DateTime
              .now()
              .millisecondsSinceEpoch
              .toString()}.jpg';
          final picture3 =
              '3-${DateTime
              .now()
              .millisecondsSinceEpoch
              .toString()}.jpg';
          var task1 =
          storage.ref().child('products/$category/$picture1').putFile(_image1);
          var task2 =
          storage.ref().child('products/$category/$picture2').putFile(_image2);
          var task3 =
          storage.ref().child('products/$category/$picture3').putFile(_image3);

          var snapshot1 = await task1.onComplete.then((snapshot) => snapshot);
          print('task1 completed');
          var snapshot2 = await task2.onComplete.then((snapshot) => snapshot);
          var snapshot4 = await task3.onComplete.then((snapshot) => snapshot);

          await task1.onComplete.then((snapshot3) async {
            imageUrl1 = await snapshot1.ref.getDownloadURL();
            imageUrl2 = await snapshot2.ref.getDownloadURL();
            imageUrl3 = await snapshot4.ref.getDownloadURL();

            productService.uploadProduct({
              'name': productNameController.text,
              'price': double.parse(priceController.text),
              'picture': imageUrl1,
              'picture2': imageUrl2,
              'picture3': imageUrl3,
              'sizes': selectedSizes,
              'pointure':selectedPointure,
              'search': setSearchParam(productNameController.text),
              'quantity': int.parse(quatityController.text),
              'description':descriptionController.text,
              'category': _currentCategory,
              'sale': onSale,
            } ,category );

            print('THE CATEGORY has been SENT TO THE FUNCTION');
            _formKey.currentState.reset();
            setState(() => isLoading = false);
            Navigator.pop(context);
          });
        } else {
          setState(() => isLoading = false);
        }
      } else {
        setState(() => isLoading = false);

//        Fluttertoast.showToast(msg: 'all the images must be provided');
      }

    }
  }
  List<String> setSearchParam(String name) {
    var caseSearchList = List<String>();
    String temp = '';
    for (var i = 0; i < name.length; i++) {
      temp = temp + name[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }
}





