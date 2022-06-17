import 'package:flutter/material.dart';
import 'package:kkhaney/Constant.dart';
import 'package:flutter/material.dart';
import 'package:kkhaney/FoodPostDetail/FoodViewPage.dart';
import 'package:kkhaney/Home/HomePage.dart';
import 'package:kkhaney/registration/manager/AuthManager.dart';
import 'package:kkhaney/registration/restaurant_login.dart';
import 'package:kkhaney/registration/signUp.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final GlobalKey<FormState> formKey=GlobalKey();
  String passwordValue="",phoneValue="";
  bool isLogging=false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
         height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Constant.primaryColor
          ),

          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
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
                          "Log In",
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
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Please Enter Phone";
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  onSaved: (value){
                                    phoneValue=value??"";
                                  },
                                  keyboardType: TextInputType.phone,
                                  decoration: Constant.getDecoration("Phone Number")
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
                              AuthManager.login(phoneNumber: phoneValue, password: passwordValue).then((value){
                                setState(() {
                                  isLogging=false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Successfully logged In"))
                                );
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomePage()));
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "New to K khaney ?"
                          ),
                          TextButton(
                              onPressed: (){
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>SignUpPage()));//Open another
                              },
                              child: Text(
                                "Register"
                              )
                          )
                        ],
                      ),
                      OrRestaurantLogin(),

                    ],
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

class OrRestaurantLogin extends StatelessWidget {
  const OrRestaurantLogin({
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RestaurantLoginPage()));
            }, child: Text(
            "Login As Restaurant"
        )
        )
      ],
    );
  }
}
