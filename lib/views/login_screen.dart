// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:room_craft/helpers.dart';

import 'package:http/http.dart';
import 'package:room_craft/views/product_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
    this.visibility = false,
    this.valid = false,
  }) : super(key: key);
  final bool visibility, valid;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode _focusA = FocusNode();
  final FocusNode _focusB = FocusNode();
  var emailelev = 0.0;
  var passelev = 0.0;
  void initState() {
    super.initState();
    _focusA.addListener(_onFocusChange);
    _focusB.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_focusA.hasFocus) {
      setState(() {
        emailelev = 10.0;
        passelev = 0;
      });
    } else if (_focusB.hasFocus) {
      setState(() {
        emailelev = 0.0;
        passelev = 10;
      });
    } else {
      setState(() {
        emailelev = 0.0;
        passelev = 0.0;
      });
    }
  }

  login(String email, password) async {
    try {
      Response response = await post(
          Uri.parse('https://fakestoreapi.com/auth/login/'),
          body: {'username': email, 'password': password});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('accessToken', '${data['token']}');

        if (prefs.containsKey('accessToken')) {
          prefs.setString('password', '${data['password']}');
          prefs.setString('username', '${data['username']}');
        }

        print('Login successfully,${prefs.containsKey(
          'accessToken',
        )}');
        print('username: ${prefs.containsKey('username')}');
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, "/second");
      } else {
        print('failed');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'Invalid Credentials..',
          style: TextStyle(color: bgcolor),
        )));
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: bgcolor,
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  SizedBox(
                    height: height * 0.15,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                          backgroundColor: greycircle,
                          radius: 55,
                          child: CircleAvatar(
                            backgroundColor: bgcolor,
                            radius: 50,
                            child: Icon(
                              Icons.person,
                              size: 80,
                              color: greycircle,
                            ),
                          ))),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Welcome Back',
                      style: TextStyle(
                          color: textBlack,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Sign to continue',
                      style: TextStyle(
                          color: textBlack.withOpacity(0.6), fontSize: 20),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 25,
                      horizontal: 20,
                    ),
                    child: Card(
                      elevation: emailelev,
                      child: TextFormField(
                        focusNode: _focusA,
                        controller: emailController,
                        style: TextStyle(color: themeGreen),
                        cursorColor: themeGreen,
                        decoration: InputDecoration(
                            icon: IconTheme(
                              data: IconThemeData(color: Colors.blueGrey),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.email_outlined),
                              ),
                            ),
                            labelText: 'Username',
                            labelStyle:
                                TextStyle(fontSize: 18, color: textBlack),
                            errorStyle: TextStyle(fontSize: 15),
                            border: InputBorder.none),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Please Fill Username';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      //vertical: 5,
                      horizontal: 15,
                    ),
                    child: Card(
                      elevation: passelev,
                      child: TextFormField(
                        focusNode: _focusB,
                        controller: passwordController,
                        style: TextStyle(color: themeGreen),
                        cursorColor: themeGreen,
                        decoration: InputDecoration(
                            prefixIcon: IconTheme(
                              data: IconThemeData(color: Colors.blueGrey),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.lock_outlined),
                              ),
                            ),
                            labelText: 'Password',
                            labelStyle:
                                TextStyle(fontSize: 18, color: textBlack),
                            errorStyle: TextStyle(fontSize: 15),
                            border: InputBorder.none),
                        obscureText: true,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Please Fill Password';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: themeGreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ))),
                  Container(
                    height: height * 0.06,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: themeGreen),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            login(
                                emailController.text, passwordController.text);
                          }
                        },
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              color: bgcolor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RichText(
                      text: TextSpan(
                        children: const <TextSpan>[
                          TextSpan(
                              text: ' Dont have account?',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textBlack,
                                  fontSize: 16)),
                          TextSpan(
                              text: ' Create a new account',
                              style: TextStyle(
                                  color: themeGreen,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ])),
          ),
        ));
  }

  
}
