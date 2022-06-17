import 'dart:convert';

import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/registration/manager/HttpException.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AccountModal{
  int donatedTimes,totalDonation;
  String userName,gmail;
  AccountModal({
    required this.donatedTimes,
    required this.totalDonation,
    required this.userName,
    required this.gmail
  });

  factory AccountModal.fromMap(Map map){
    return AccountModal(
        donatedTimes: map["donatedTimes"],
        totalDonation: map["totalDonation"],
        userName: map["user"],
        gmail: map["gmail"]
    );
  }
}
class AccountManager{
  static Future<AccountModal> getAccountDetails() async{
    final sharedPref=await SharedPreferences.getInstance();
    int userId=sharedPref.getInt(Constant.userIdKey)??0;
    Uri uri =Uri.parse(Constant.serverUrl+"getUserTotalDonation/$userId/");
    http.Response response=await http.get(uri);
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(errorMessage: responseData.toString());
    return AccountModal.fromMap(responseData);
  }
}