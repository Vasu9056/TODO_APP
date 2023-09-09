import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/Button%20&%20textfield/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/Services/auth_service.dart';
import 'package:todo_app/Services/phoneAuthpage.dart';
import 'package:todo_app/signup.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool circular = false;
  String image1 = "assets/google.svg";
  String image2 = "assets/phone.svg";

  Auth authclass = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign In",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              buttonItem(context, image1, 'Continue With Google', 25, () {
                authclass.googleSignIn(context);
              }),
              SizedBox(
                height: 15,
              ),
              buttonItem(context, image2, 'Continue with Mobile', 25, () {
                Get.to(() => PhoneAuthPage());
              }),
              SizedBox(
                height: 15,
              ),
              Text(
                "OR",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField("Email....", emailController, false),
              SizedBox(
                height: 15,
              ),
              CustomTextField("Password", passwordController, true),
              SizedBox(
                height: 30,
              ),
              ColorButton(
                context,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "If you don't have an Account? ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: 4.7,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => Signup());
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Forgot Password ?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget ColorButton(context) {
    return InkWell(
      onTap: () async {
        setState(() {
          circular = true;
        });
        try {
          firebase_auth.UserCredential userCredential =
              await firebaseAuth.signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text);
          print(userCredential.user!.email);
          setState(() {
            circular = false;
          });
          Get.offAll(() => Home());
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [
              Color(0xfffd746c),
              Color(0xffff9068),
              Color(0xfffd746c)
            ])),
        child: Center(
          child: circular
              ? CircularProgressIndicator()
              : Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
        ),
      ),
    );
  }

  Widget buttonItem(context, String imglink, String text, double size, onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        width: MediaQuery.of(context).size.width * 60,
        height: 60,
        child: Card(
          color: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.grey, width: 1),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(
              imglink,
              height: size,
              width: size,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 17),
            )
          ]),
        ),
      ),
    );
  }

  Widget CustomTextField(
      String Labeltext, TextEditingController controller, bool obscureText) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(fontSize: 17, color: Colors.white),
        decoration: InputDecoration(
            labelText: Labeltext,
            labelStyle: TextStyle(fontSize: 17, color: Colors.white),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.amber, width: 1),
            )),
      ),
    );
  }
}
