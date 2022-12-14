import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:room_craft/model/model.dart';

import 'package:room_craft/views/login_screen.dart';
import 'package:room_craft/views/product_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;



final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  SharedPreferences prefs;
  MyApp({super.key, required this.prefs});

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
          }, 
          '/second': (context) => const ProductListScreen(),
        }
       
 ); }
}
