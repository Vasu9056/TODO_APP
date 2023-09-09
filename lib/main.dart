import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/Button%20&%20textfield/Home.dart';
import 'package:todo_app/signin.dart';
import 'package:todo_app/signup.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'Services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = Signup();
  Auth authclass = Auth();
  @override
  void initState() {
    super.initState();
  }

  void checkLogin() async {
    String? token = await authclass.getToken();
    print("token");
    if (token != null) {
      setState(() {
        currentPage = Home();
      });
    }
  }

  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, home: SignIn());
  }
}
//Vasu Langdecha
// in this todo app I have make a first sign and signup page with google sign in and otp verification
// after that I have make a todo home page with firebase in that page we have read data from firebase and also we have set new task in this app
//profile page is not complete