import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kkhaney/About/AboutPage.dart';
import 'package:kkhaney/About/ContactPage.dart';
import 'package:kkhaney/About/DrawerItem.dart';
import 'package:kkhaney/About/TermsPage.dart';
import 'package:kkhaney/AccountNotification/AccountPage.dart';
import 'package:kkhaney/AccountNotification/notification_page.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/registration/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerContainer extends StatelessWidget {
  const DrawerContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.only(top: 30, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
              //backgroundColor: Colors.0xff52B788
              height: 150,
              width: double.infinity,
              child: Image.asset(
                  "Photo/logo.png"
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomCard(
                      iconValue: Icons.person,
                      value: 'Accounts',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AccountPage()));
                      },
                    ),
                    CustomCard(
                      iconValue: Icons.doorbell,
                      value: "Today's Notifications",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationPage()));
                      },
                    ),
                    CustomCard(
                      iconValue: Icons.info_outlined,
                      value: 'About K Khaney',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutPage()));
                      },
                    ),
                    CustomCard(
                      iconValue: Icons.mail,
                      value: 'Contact us',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactPage()));
                      },
                    ),
                    CustomCard(
                      iconValue: Icons.list,
                      value: 'Terms and conditions',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermsPage()));
                      },
                    ),
                    CustomCard(
                      iconValue: Icons.logout,
                      value: 'Log Out',
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Log Out", //,
                                  //style:Styles.mediumHeading
                                ),
                                content:
                                    Text("Do you really want to Log Out"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context, true); //true is value
                                      },
                                      child: const Text(
                                        'Yes',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context, false); //true is value
                                      },
                                      child: const Text(
                                        'No',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ],
                              );
                            })
                        .then((value) async{
                          if (value==true){
                            final sharedPref=await SharedPreferences.getInstance();
                            sharedPref.setString(Constant.tokenKey, "");
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Sucessfully Loged out"),
                                  backgroundColor: Colors.grey,
                                ));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogInPage()));
                          }
                        });
                      },
                    ),
                    Text(
                      "K Khaney",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Developed by Sumnima",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}


