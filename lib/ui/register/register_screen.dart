import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/Database/Model/user.dart' as MyUser;
import 'package:to_do/Database/my_database.dart';
import 'package:to_do/Dialogs.dart';
import 'package:to_do/ui/Components/custom_form_field.dart';
import 'package:to_do/ui/Home_Screen/home_screen.dart';
import 'package:to_do/ui/login/Login_Screen.dart';
import 'package:to_do/validationutils.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  var namecontroller = TextEditingController();

  var emailcontroller = TextEditingController();

  var passwordcontroller = TextEditingController();

  var passwordconfirmationcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color(0xFFDFECDB),
          image: DecorationImage(
            image: AssetImage("assets/images/auth_pattern.png"),
            fit: BoxFit.fill,
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  CustomFormField(
                    controller: namecontroller,
                    label: "Full Name",
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please Enter Full Name";
                      }
                    },
                  ),
                  CustomFormField(
                    controller: emailcontroller,
                    label: "Email Address",
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please Enter Email";
                      }
                      if (!ValidationUtils.isValidEmail(text)) {
                        return "Email not valid";
                      }
                    },
                  ),
                  CustomFormField(
                    controller: passwordcontroller,
                    label: "Password",
                    keyboardType: TextInputType.text,
                    isPassword: true,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please Enter Password";
                      }
                      if (text.length < 6) {
                        return "Password should be at least 6 characters";
                      }
                    },
                  ),
                  CustomFormField(
                    controller: passwordconfirmationcontroller,
                    label: "Password Confirmation",
                    keyboardType: TextInputType.text,
                    isPassword: true,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please Enter Password-Confirmation";
                      }
                      if (passwordcontroller.text != text) {
                        return "password doesn't match";
                      }
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        register();
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12)),
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 24),
                      )),
                  TextButton(onPressed: () {
                    Navigator.pushReplacementNamed(context, LoginScreen.routename);
                  }, child: Text("Already Have Account ?"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    try {
      dialogs.showloadingdialog(context, "Loading...");
      var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );
      dialogs.hidedialog(context);
      var myUser = MyUser.User(
        id: result.user?.uid,
        name: namecontroller.text,
        email: emailcontroller.text,
      );
      await MyDatabase.addUser(myUser);
      dialogs.hidedialog(context);
      dialogs.showMessage(context, "User Successfully Registered",dismissable: false,PosActionName: "Ok", PosAction: (){
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      });
    } on FirebaseAuthException catch (e) {
      dialogs.hidedialog(context);
      String errorMessage = 'Something went wrong';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      dialogs.showMessage(context, errorMessage, PosActionName: "Ok");
    } catch (e) {
      dialogs.hidedialog(context);
      String errorMessage = 'Something went wrong';
      dialogs.showMessage(context, errorMessage,
          PosActionName: "Cancel", NegActionName: "Try again", NegAction: () {
        register();
      });
    }
  }
}
