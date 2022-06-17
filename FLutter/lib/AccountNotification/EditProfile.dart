import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kkhaney/AccountNotification/AccountPage.dart';
import 'package:kkhaney/Constant.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                          Icons.keyboard_arrow_left_outlined
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "EDIT PROFILE",
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                Container(
                  height: 90,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Center(
                    child: Icon(
                      FontAwesomeIcons.user,
                      size: 50,

                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                Container(
                  width: 350,
                  child: Column(
                    children: [
                      TextField(
                          obscureText: true,
                          decoration: Constant.getDecoration("Username")
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 350,
                  child: Column(
                    children: [
                      TextField(
                          obscureText: true,
                          decoration: Constant.getDecoration("Phone Number")
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 350,
                  child: Column(
                    children: [
                      TextField(
                          obscureText: true,
                          decoration: Constant.getDecoration("Password")
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 30,
                  width: 75,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>AccountPage()));//Open another
                    },
                    child: Text(
                      "Save",
                    ),
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
