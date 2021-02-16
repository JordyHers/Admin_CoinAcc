import 'package:admincoinacc/db/product.dart';
import 'package:admincoinacc/db/users.dart';
import 'package:admincoinacc/orderServices/get_orders_list.dart';
import 'package:admincoinacc/orderServices/order_screen.dart';
import 'package:admincoinacc/providers/order_provider.dart';
import 'package:admincoinacc/screens/home_page.dart';
import 'package:admincoinacc/screens/list_category_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../screens/add_product.dart';
import '../db/category.dart';
import '../db/brand.dart';
import 'list_product_page.dart';
import 'notification_page.dart';

enum Page { dashboard, manage }

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.red;
  MaterialColor notActive = Colors.grey;
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  GlobalKey<FormState> _brandFormKey = GlobalKey();
  OrderServices _orderServices = OrderServices();
  CategoryService _categoryService = CategoryService();
  ProductService _productService = ProductService();
  UsersService _usersService= UsersService();
  int category;
  int product;
  int users;
  int _total;
  @override
  void initState() {
    _getCategories();
    //_getProducts();
    _getUsers();


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.teal[50],
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.dashboard);
                      },
                      icon: Icon(
                        Icons.dashboard,
                        color: _selectedPage == Page.dashboard
                            ? active
                            : notActive,
                      ),
                      label: Text('Information'))),
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.manage);
                      },
                      icon: Icon(
                        Icons.sort,
                        color:
                        _selectedPage == Page.manage ? active : notActive,
                      ),
                      label: Text('Management'))),
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: _loadScreen());
  }
  _loadScreen()  {
    final orderProvider = Provider.of<OrderProvider>(context);

    switch (_selectedPage) {
      case Page.dashboard:
        return MainPage();
        break;
      case Page.manage:
        return ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Ajouter un article"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => AddProduct()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.format_line_spacing),
              title: Text("Liste articles"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ListProduct()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_shopping_cart),
              title: Text("Ajouter  categorie"),
              onTap: () {
                _categoryAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.merge_type),
              title: Text("Liste categorie"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ListCategory()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text("Ajouter marque"),
              onTap: () {
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.library_books),
              title: Text("Notifications"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> NotificationPage()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.store_mall_directory),
              title: Text("Liste des commandes"),
              onTap: ()  async {
                await orderProvider.loadOrder();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>  OrdersScreen()));
              },
            ),
            Divider(),
          ],
        );
        break;
      default:
        return Container();
    }
  }

  void _categoryAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _categoryFormKey,
        child: TextFormField(
          controller: categoryController,
          validator: (value){
            if(value.isEmpty){
              return 'category cannot be empty';
            }
          },
          decoration: InputDecoration(
              hintText: "ajouter une categorie"
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(onPressed: (){
          if(categoryController.text != null){
            _categoryService.createCategory(categoryController.text);
          }
          Fluttertoast.showToast(msg: 'Nouvelle categorie !');
          Navigator.pop(context);
        }, child: Text('ajouter')),
        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('annuler')),

      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }

  void _brandAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _brandFormKey,
        child: TextFormField(
          controller: brandController,
          validator: (value){
            if(value.isEmpty){
              return 'category cannot be empty';
            }
          },
          decoration: InputDecoration(
              hintText: "Ajouter une commande "
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(onPressed: (){
          if(brandController.text != null){
            //_brandService.createBrand(brandController.text);
          }
//          Fluttertoast.showToast(msg: 'brand added');
          Navigator.pop(context);
        }, child: Text('Ajouter')),
        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('annuler')),

      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }

  _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    print(data.length);
    setState(() {
      category = data.length;
    });
  }

  // _getProducts() async{
  //   List<DocumentSnapshot> data = await _productService.getProducts();
  //   print(data.length);
  //   setState(() {
  //     product = data.length;
  //   });
  // }
  _getUsers() async {
    List<DocumentSnapshot> data = await _usersService.getUsers();
    print(data.length);
    setState(() {
      users = data.length;
    });

  }
}









































//
//
//
//
// Column(
// children: <Widget>[
// ListTile(
// subtitle: FlatButton.icon(
//
// onPressed: null,
// icon: Icon(
// Icons.shopping_basket,
// size: 20.0,
// color: Colors.green,
// ),
// label: Text('Derya nın Emeği',
// textAlign: TextAlign.center,
// style: TextStyle(fontSize: 20.0, color: Colors.grey)),
// ),
// title: Image.asset('assets/images/icon.png',height: 80,),
// ),
// Expanded(
// child: GridView(
// gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 2),
// children: <Widget>[
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Card(
// child: ListTile(
// title: FlatButton.icon(
// onPressed: null,
// icon: Icon(Icons.people_outline),
// label: Text("Kullanıcı",style: TextStyle(fontSize: 14),)),
// subtitle: Text(
// '$users',
// textAlign: TextAlign.center,
// style: TextStyle(color: active, fontSize: 60.0),
// )),
// ),
// ),
//
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Card(
// child: ListTile(
// title: FlatButton.icon(
// onPressed: null,
// icon: Icon(Icons.loyalty),
// label: Text("Kategoriler")),
// subtitle: Text(
// '$category',
// textAlign: TextAlign.center,
// style: TextStyle(color: active, fontSize: 60.0),
// )),
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Card(
// child: ListTile(
// title: FlatButton.icon(
// onPressed: null,
// icon: Icon(Icons.track_changes),
// label: Text("Ürünler")),
// subtitle:  Text(
// '$product',
// textAlign: TextAlign.center,
// style: TextStyle(color: active, fontSize: 60.0),
// )),
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Card(
// child: ListTile(
// title: FlatButton.icon(
// onPressed: null,
// icon: Icon(Icons.tag_faces),
// label: Text("Satılmış")),
// subtitle: Text(
// '0',
// textAlign: TextAlign.center,
// style: TextStyle(color: active, fontSize: 60.0),
// )),
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Card(
// child: ListTile(
// title: FlatButton.icon(
// onPressed: null,
// icon: Icon(Icons.shopping_cart),
// label: Text("Sipariş")),
// subtitle: Text(
// '0',
// textAlign: TextAlign.center,
// style: TextStyle(color: active, fontSize: 60.0),
// )),
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Card(
// child: ListTile(
// title: FlatButton.icon(
// onPressed: null,
// icon: Icon(Icons.keyboard_return),
// label: Text("Geri")),
// subtitle: Text(
// '0',
// textAlign: TextAlign.center,
// style: TextStyle(color: active, fontSize: 60.0),
// )),
// ),
// ),
// ],
// ),
// ),
// ],
// );


