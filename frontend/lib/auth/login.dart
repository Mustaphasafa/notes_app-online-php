import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttercourse/Facilities/textformfield.dart';
import 'package:fluttercourse/auth/crud.dart';
import 'package:fluttercourse/auth/linkapi.dart';
import 'package:fluttercourse/auth/signup.dart';
import 'package:fluttercourse/home.dart';
import 'package:fluttercourse/main.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> form = GlobalKey();

  GetPost crud = GetPost();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Login() async {
    if(form.currentState!.validate()){
    var response = await crud.postRequest(linklogin, {
      "email": email.text,
      "password": password.text,
    });
    if (response['status'] == "succes") {
                        sharedPref.setString("id", response["data"]["id"].toString());
                        sharedPref.setString("username", response["data"]["username"]);
                        sharedPref.setString("email", response["data"]["email"]);

      Get.offAll(() => Home());
    } else {
      AwesomeDialog(
          context: context,
          title: "Warning",
          body:
              Text("Email Or Password Worng , Or No account with this details"))
        ..show();
    }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: form,
        child: ListView(
          children: [
            Container(
              color: const Color.fromARGB(255, 231, 222, 222),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: Image.asset(
                            "images/test.jpg",
                            height: 120,
                            width: 160,
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
                  Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Container(
                      padding: EdgeInsets.only(
                        top: 20,
                      ),
                      child: Text(
                        "Enter Your Details",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 15),
                      )),
                  GridView.count(
                     crossAxisCount: 1,
                childAspectRatio: 5.5,
                mainAxisSpacing: 5,
                    padding: EdgeInsets.only(top: 8, bottom: 15),
                    shrinkWrap: true,
                   
                    children: [
                      CustomTextField(
                          texthint: "Email",
                          controller: email,
                          val: (val) {
                            if (val!.isEmpty) {
                              return "Can`t Be Empty";
                            }
                            if (val.length < 2) {
                              return "Can Not Be Shorter Then 2";
                            }
                            if (val.length > 30) {
                              return "Can Not Be Longer Then 30";
                            }
                            if (!val.endsWith("@gmail.com")) {
                              return "email must end with '@gmail.com'";
                            }
                            return null;
                          },
                          icon: Icon(Icons.email), mode: AutovalidateMode.disabled,),
                      CustomTextField(
                          texthint: "Password",
                          controller: password,
                          val: (val) {
                            if (val!.isEmpty) {
                              return "Can`t Be Empty";
                            }
                            if (val.length < 6) {
                              return "Can Not Be Shorter Then 2";
                            }
                            if (val.length > 30) {
                              return "Can Not Be Longer Then 30";
                            }

                            return null;
                          },
                          icon: Icon(Icons.remove_red_eye_outlined), mode: AutovalidateMode.disabled,)
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15.0),
              child: ElevatedButton(
                onPressed: ()async {
                  await Login();
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orangeAccent,
                ),
                child: Text("Login"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.off(() => Register());
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orangeAccent,
                ),
                child: Text("Sign Up"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
