import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


import 'package:room_craft/views/login_screen.dart';
import 'package:room_craft/views/product_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp( MyApp(prefs: prefs,));
}

class MyApp extends StatelessWidget {
  SharedPreferences prefs;
   MyApp({super.key,required this.prefs});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     // title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.amber, errorColor: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) {
          return prefs.getString("username") == null && prefs.getString("password") == null 
              ?const LoginScreen()
              :const ProductListScreen();
        }, //const  LoginScreen(),
        '/second': (context) => const ProductListScreen(),
      },
      // home:const LoginScreen()
    );
  }
}
