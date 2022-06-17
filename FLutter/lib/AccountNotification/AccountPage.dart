import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kkhaney/AccountNotification/EditProfile.dart';
import 'package:kkhaney/AccountNotification/manager/account_maanger.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/Icons/LikeIcon.dart';

class AccountPage extends StatefulWidget {

  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late final AccountModal accountModal;
  bool isLoading=true;
  @override
  void initState() {
    super.initState();
    getAccountModal();
  }
  void getAccountModal() async{
    accountModal=await AccountManager.getAccountDetails();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        isLoading=false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("User Accounts"),
        ),
        body: isLoading?
        Center(
          child: CircularProgressIndicator(),
        ):
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
              children: [
                SizedBox(height: 20,),
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
                  height: 20,
                ),

                Text(
                    accountModal.userName
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                    accountModal.gmail
                ),

                SizedBox(
                  height: 8,
                ),
                Text(
                    "Total Donated:"+accountModal.donatedTimes.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),

                SizedBox(
                  height: 8,
                ),
                Text(
                    "Total Donation Amount: Rs."+accountModal.totalDonation.toString()+"/-",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 140),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 40,
                        width: 120,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>EditProfile()));//Open another
                          },
                          child: Text(
                            "Edit Profile",
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 29,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      LikeIcon(),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "My Favourite"
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      Icon(
                          FontAwesomeIcons.list
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                          "Order History"
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 29,
                ),
                Container(
                  margin: EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      Icon(
                          FontAwesomeIcons.bell
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                          "Notifications"
                      ),
                    ],
                  ),
                ),
              ]
          ),
          ),
                  ),
    );
  }
}
