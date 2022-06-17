import 'package:flutter/material.dart';
import 'package:kkhaney/Constant.dart';
import 'package:flutter/material.dart';
import 'package:kkhaney/Home/HomePage.dart';
import 'package:kkhaney/RestaurantArea/profile_edit_page.dart';
import 'package:kkhaney/RestaurantArea/restaurant_portal.dart';
import 'package:kkhaney/registration/manager/AuthManager.dart';
import 'package:kkhaney/registration/manager/image_selector.dart';
import 'package:kkhaney/registration/signUp.dart';

import 'login.dart';

class RestaurantSignUp extends StatefulWidget {
  const RestaurantSignUp({Key? key}) : super(key: key);

  @override
  State<RestaurantSignUp> createState() => _RestaurantSignUpState();
}

class _RestaurantSignUpState extends State<RestaurantSignUp> {
  GlobalKey<FormState> formKey=GlobalKey();
  bool isLoading=false;

  String emailAddress="",restaurantName="",location="",restaurantPhone="",
      openingTime="",closingTime="",restaurantInfo="",password="",confirmPassword="";
  int minimumOrder=1;
  final ValueNotifier<String?> restaurantImage=ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
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
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Restaurant Register",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Constant.primaryColor
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          GalleryImagePicker(
                            imageLocation: restaurantImage,
                          ),
                          SizedBox(height: 20,),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(

                                  textInputAction: TextInputAction.next,
                                  decoration: Constant.getDecoration("Phone Number"),
                                  keyboardType: TextInputType.number,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Please Enter Phone Number";
                                    }
                                    return null;
                                  },
                                  onSaved: (value){

                                    restaurantPhone=value??"";
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
                                  decoration: Constant.getDecoration("Restaurant Name"),
                                  keyboardType: TextInputType.name,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Please Enter Restaurant Name";
                                    }
                                    return null;
                                  },
                                  onSaved: (value){

                                    restaurantName=value??"";
                                  },
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                TextFormField(

                                  textInputAction: TextInputAction.next,
                                  decoration: Constant.getDecoration("Location"),
                                  keyboardType: TextInputType.name,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Please Enter Location";
                                    }
                                    return null;
                                  },
                                  onSaved: (value){

                                    location=value??"";
                                  },
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                TextFormField(

                                  textInputAction: TextInputAction.next,
                                  decoration: Constant.getDecoration("Opening Time"),
                                  keyboardType: TextInputType.name,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Please Enter Opening Time";
                                    }
                                    return null;
                                  },
                                  onSaved: (value){

                                    openingTime=value??"";
                                  },
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                TextFormField(

                                  textInputAction: TextInputAction.next,
                                  decoration: Constant.getDecoration("Closing Time"),
                                  keyboardType: TextInputType.name,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Please Enter Closing Time";
                                    }
                                    return null;
                                  },
                                  onSaved: (value){

                                    closingTime=value??"";
                                  },
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                TextFormField(

                                  textInputAction: TextInputAction.next,
                                  decoration: Constant.getDecoration("Minimum Order(Rs.)"),
                                  keyboardType: TextInputType.number,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Please Enter Minimum Order";
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    try{
                                      minimumOrder=int.parse(value??"0");

                                    }catch (e){
                                      minimumOrder=1;
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                TextFormField(

                                  decoration: Constant.getDecoration("Restaurant Info"),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Please Enter Restaurant Info";
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    restaurantInfo=value??"";
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
                                if(restaurantImage.value==null){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Select Image")));
                                }
                                AuthManager.registerRestaurant(
                                  phone: restaurantPhone,
                                    restaurantName: restaurantName,
                                    location: location,
                                    openingTime: openingTime,
                                    closingTime: closingTime,
                                    restaurantEmail: emailAddress.toLowerCase(),
                                    minimumOrder: minimumOrder,
                                    restaurantInfo: restaurantInfo,
                                    restaurantImage: restaurantImage.value??"",
                                    password: password
                                ).then((value){
                                  setState(() {
                                    isLoading=false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Successfully Registered"))
                                  );
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>RestaurantPortal()));
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

                            },
                            child: Text(
                              "Sign Up",
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
      ),
    );
  }
}
