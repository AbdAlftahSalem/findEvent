import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventfinder/controllers/local_db.dart';
import 'package:eventfinder/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'Admin/adminHomePage.dart';
import 'Homepage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF190F4B),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              child: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                        width: 200,
                      ),

                      // Wrong Password text

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white.withOpacity(0.9),
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 50),
                                width: 400,
                                alignment: Alignment.center,
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            component(Icons.email, "Email...", false, true,
                                emailController),
                            SizedBox(
                              height: 20,
                            ),
                            component(Icons.lock, "Password...", true, false,
                                passwordController),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 570,
                              height: 70,
                              padding: EdgeInsets.only(top: 20),
                              child: RaisedButton(
                                  color: Colors.deepPurple,
                                  child: Text("Submit",
                                      style: TextStyle(color: Colors.white)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  onPressed: () {
                                    print(emailController.text.trim());
                                    print(passwordController.text.trim());
                                    if (emailController.text.trim() != "" &&
                                        passwordController.text != "") {
                                      loginData(emailController.text.trim(),
                                          passwordController.text.trim());
                                    } else {
                                      EasyLoading.showError(
                                          "Please fill all needed inforamtion",
                                          duration: Duration(milliseconds: 800));
                                    }
                                  }),
                            ),
                            Container(
                                padding:
                                EdgeInsets.only(top: 40, left: 20, right: 20),
                                child: Center(
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Dont have an account? ",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignUpScreen())),
                                            child: Text(
                                              " Signup here",
                                              style: TextStyle(
                                                color: Colors.deepPurple[500],
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                          )
                                        ])))
                          ],
                        ),
                      ),

                      // Submit Button

                      // Register
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future loginData(String email, String password) async {
    try {
      EasyLoading.show(status: "Wait a moment...");
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          if (value.user.uid != null) {
            EasyLoading.dismiss().then(
              (valueLoad) async {
                await FirebaseFirestore.instance
                    .collection("Users")
                    .doc(value.user.uid)
                    .get()
                    .then(
                  (value) {
                    if (value.data()["type"] == "admin") {
                      Get.offAll(() => AdminHomePage());
                      LocalDB.add("user", value.data());
                    } else {
                      LocalDB.add("user", value.data());
                      Get.offAll(() => HomePage());
                    }
                  },
                );
              },
            );
          }
        },
      );
    } catch (e) {
      EasyLoading.showError("${e.message.toString()}",
          duration: Duration(milliseconds: 800));
    }
  }

  Widget component(IconData icon, String hintText, bool isPassword,
      bool isEmail, TextEditingController controller) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 8,
      width: size.width / 1.25,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: Colors.black.withOpacity(.9),
        ),
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.black.withOpacity(.8),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
