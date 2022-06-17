import 'package:flutter/material.dart';
import 'package:kkhaney/Constant.dart';
import 'package:flutter/material.dart';
import 'package:kkhaney/FoodPostDetail/FoodViewPage.dart';
import 'package:kkhaney/Home/HomePage.dart';
import 'package:kkhaney/RestaurantArea/profile_edit_page.dart';
import 'package:kkhaney/RestaurantArea/restaurant_portal.dart';
import 'package:kkhaney/registration/login.dart';
import 'package:kkhaney/registration/manager/AuthManager.dart';
import 'package:kkhaney/registration/signUp.dart';

class RestaurantLoginPage extends StatefulWidget {
  const RestaurantLoginPage({Key? key}) : super(key: key);

  @override
  State<RestaurantLoginPage> createState() => _RestaurantLoginPageState();
}

class _RestaurantLoginPageState extends State<RestaurantLoginPage> {
  final GlobalKey<FormState> formKey=GlobalKey();
  String passwordValue="",emailValue="";
  bool isLogging=false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogInPage()));
        return false;
        },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Constant.primaryColor
            ),

            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    // width: 450,
                    padding: EdgeInsets.all(30),
                    // height: 458,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Restaurant Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Constant.primaryColor
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "Please Enter Email";
                                      }
                                      return null;
                                    },
                                    textInputAction: TextInputAction.next,
                                    onSaved: (value){
                                      emailValue=value??"";
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: Constant.getDecoration("Email Address")
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "Please Enter Password";
                                      }
                                      return null;
                                    },
                                    onSaved: (value){
                                      passwordValue=value??"";
                                    },
                                    obscureText: true,
                                    decoration: Constant.getDecoration("Password")
                                ),
                              ],
                            )
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        isLogging?
                        CircularProgressIndicator():
                        ElevatedButton(
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              formKey.currentState!.save();
                              setState(() {
                                isLogging=true;
                              });
                              AuthManager.restaurantLogin(email: emailValue.toLowerCase(), password: passwordValue).then((value){
                                setState(() {
                                  isLogging=false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Successfully Logged In"))
                                );
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>RestaurantPortal()));
                              }).onError((error, stackTrace) {
                                setState(() {
                                  isLogging=false;
                                });
                                print(error.toString());
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(error.toString()))
                                );
                              });
                            }

                          },
                          child: Text(
                            "Log In",
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
