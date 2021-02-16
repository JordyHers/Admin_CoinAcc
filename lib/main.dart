import 'package:admincoinacc/providers/order_provider.dart';
import 'package:admincoinacc/providers/user_provider.dart';
import 'package:admincoinacc/screens/home_page.dart';
import 'package:admincoinacc/screens/loading.dart';
import 'package:flutter/material.dart';
import 'package:admincoinacc/providers/app_state.dart';
import 'package:admincoinacc/screens/admin.dart';
import 'package:admincoinacc/screens/dashboard.dart';
import 'package:provider/provider.dart';
import 'screens/Login_page.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: OrderProvider.initialize()),
      ChangeNotifierProvider.value(value: AppState()),
      ChangeNotifierProvider(
        create: (_) => UserProvider.initialize(),   )],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Admin(),
    ),
  ));
}
class ScreensController extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch(user.status){
      case Status.Uninitialized:
        return Loading();
      case Status.Unauthenticated:
        return Login();
      case Status.Authenticating:
        return Loading();
      case Status.Authenticated:
        return Admin();
      default: return Login();
    }
  }
}