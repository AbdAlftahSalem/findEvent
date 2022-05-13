import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventfinder/controllers/local_db.dart';
import 'package:eventfinder/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'homepage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
        color: Colors.deepPurple[800],
        child: Container(
          color: Colors.black38,
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
                              "SignUp",
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        component(Icons.account_circle_outlined, 'User name...',
                            false, false, nameController),
                        SizedBox(
                          height: 20,
                        ),
                        component(Icons.phone, 'Phone number...', false, false,
                            phoneController),
                        SizedBox(
                          height: 20,
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
                                if (nameController.text.trim() != "" &&
                                    emailController.text.trim() != "" &&
                                    phoneController.text.trim() != "" &&
                                    passwordController.text.trim() != "") {
                                  signUpData(
                                      emailController.text.trim(),
                                      passwordController.text.trim(),
                                      nameController.text.trim(),
                                      phoneController.text.trim());
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
                                                LoginScreen())),
                                    child: Text(
                                      " LogIn here",
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
      ),
    );
  }

  Future signUpData(
      String email, String password, String name, String phone) async {
    // LocalDB.add("user", value.data());
    // Get.offAll(() => HomePage());
    Map<String, String> data = {
      "name": name,
      "phone": phone,
      "email": email,
      "id": "",
      "type": "user",
    };
    try {
      EasyLoading.show(status: "Please wait a moment...");
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((val) {
        data["id"] = val.user.uid;
        FirebaseFirestore.instance
            .collection("Users")
            .doc("${val.user.uid}")
            .set(data)
            .then((value) {
          LocalDB.add("user", data);
          EasyLoading.dismiss().then((value) {
            Get.offAll(() => HomePage());
          });
        });
      });
    } on Exception catch (exception) {
      print(exception);
      EasyLoading.showError("$exception",
          duration: Duration(milliseconds: 800));
    } catch (e) {
      EasyLoading.showError("${e.toString()}",
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
