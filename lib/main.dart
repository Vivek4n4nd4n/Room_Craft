import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:room_craft/helpers.dart';

import 'package:room_craft/views/login_screen.dart';
import 'package:room_craft/views/product_list_screen.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.amber, errorColor: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(), //const  LoginScreen(),
        '/second': (context) =>  const ProductListScreen(),
      },
      // home:const LoginScreen()
    );
  }
}
