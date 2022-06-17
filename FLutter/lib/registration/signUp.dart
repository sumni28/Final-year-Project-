import 'package:flutter/material.dart';
import 'package:kkhaney/Constant.dart';
import 'package:flutter/material.dart';
import 'package:kkhaney/Home/HomePage.dart';
import 'package:kkhaney/registration/manager/AuthManager.dart';
import 'package:kkhaney/registration/resturant_signup.dart';

import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> formKey=GlobalKey();
  bool isLoading=false;
  String phoneNumber="",emailAddress="",password="",confirmPassword="";
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async{
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context)=>LogInPage())
        );
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
                color: Constant.primaryColor,
            ),

            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
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

                                  textInputAction: TextInputAction.next,
                                    decoration: Constant.getDecoration("Phone Number"),
                                  keyboardType: TextInputType.phone,
                                  validator: (value){
                                      if(value!.isEmpty){
                                        return "Please Enter Phone Number";
                                      }
                                      return null;
                                  },
                                  onSaved: (value){
                                      phoneNumber=value??"";
                                  },
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                TextFormField(

                                  textInputAction: TextInputAction.next,
                                    decoration: Constant.getDecoration("Email Address"),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Please Enter Email Address";
                                    }
                                    return null;
                                  },
                                  onSaved: (value){

                                      emailAddress=value??"";
                                  },
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                TextFormField(

                                  textInputAction: TextInputAction.next,
                                    obscureText: true,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Please Enter Password";
                                    }
                                    return null;
                                  },
                                    decoration: Constant.getDecoration("Password"),
                                  onSaved: (value){
                                      password=value??"";
                                  },
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                TextFormField(
                                    obscureText: true,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "Please Enter Confirm Password";
                                      }else{
                                        formKey.currentState!.save();
                                        if(password!=value){
                                          return "Password Don't Match Confirm Password";
                                        }
                                      }
                                      return null;
                                    },
                                    decoration: Constant.getDecoration("Conform Password"),

                                  onSaved: (value){
                                      confirmPassword=value??"";
                                  },
                                ),
                              ],
                            ),
                          ),


                          SizedBox(
                            height: 30,
                          ),
                          isLoading?CircularProgressIndicator():ElevatedButton(
                            onPressed: (){
                              if(formKey.currentState!.validate()){
                                formKey.currentState!.save();
                                setState(() {
                                  isLoading=true;
                                });
                                AuthManager.register(phoneNumber: phoneNumber, password: password,email: emailAddress).then((value){
                                  setState(() {
                                    isLoading=false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Successfully Registered"))
                                  );
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomePage()));
                                }).onError((error, stackTrace) {
                                  setState(() {
                                    isLoading=false;
                                  });
                                  print(error.toString());
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(error.toString()))
                                  );
                                });
                              }
                              //Navigator.push(context,MaterialPageRoute(builder: (context)=>LogInPage()));//Open another
                            },
                            child: Text(
                              "Sign Up",
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                    "Already have an account ?",
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              TextButton(
                                  onPressed: (){
                                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LogInPage()));//Open another
                                  },
                                  child: Text(
                                      "Log In"
                                  )
                              )
                            ],
                          ),
                          OrRestaurantRegister(),
                        ],
                      ),
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

class OrRestaurantRegister extends StatelessWidget {
  const OrRestaurantRegister({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        Text(
          "Or",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),
        ),
        SizedBox(height: 10,),
        TextButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RestaurantSignUp()));
            }, child: Text(
            "Register As Restaurant"
        )
        )
      ],
    );
  }
}
