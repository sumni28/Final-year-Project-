import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:kkhaney/registration/manager/HttpException.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Constant.dart';
import 'package:http/http.dart' as http;
class AuthManager{
  static Future<void> login({
    required String phoneNumber,required String password
  }) async{
    Uri uri=Uri.parse(Constant.serverUrl+"login/");
    print(uri.toString());
    await http.post(
      uri,
      headers: {
        "Content-Type": "application/json"
      },
      body:json.encode(
          {
            "username":phoneNumber,
            "password":password
          }
      )
    ).then((response) async{
      final responseData=json.decode(response.body);

      if(response.statusCode>299) throw HttpException(errorMessage: responseData.toString());
      await saveTokenAndUserId(responseData);
    });
  }

  static Future<void> register({
    required String phoneNumber,required String password,required String email
  }) async{
    Uri uri=Uri.parse(Constant.serverUrl+"register/");
    print(uri.toString());
    await http.post(
        uri,
        headers: {
          "Content-Type": "application/json"
        },
        body:json.encode(
            {
              "username":phoneNumber,
              "password":password,
              "email":email
            }
        )
    ).then((response) async{
      final responseData=json.decode(response.body);

      if(response.statusCode>299) throw HttpException(errorMessage: responseData.toString());
      await saveTokenAndUserId(responseData);
    });
  }

  static Future<void> saveTokenAndUserId(dynamic responseData) async{
    final sharedPref=await SharedPreferences.getInstance();
    String token =responseData[Constant.tokenKey];
    sharedPref.setString(Constant.tokenKey,token );
    Uri uri=Uri.parse(Constant.serverUrl+"getUserId/");
    final userIdResponse=await http.get(
        uri,
      headers: {
          "Authorization":"Token $token"
      }
    );
    final userResponse=json.decode(userIdResponse.body);
    if(userIdResponse.statusCode>299) throw HttpException(errorMessage: userResponse.toString());
    sharedPref.setInt(Constant.userIdKey, userResponse["userId"]);
  }


  static Future<void> restaurantLogin({
    required String email,required String password
  }) async{
    Uri uri=Uri.parse(Constant.serverUrl+"restaurantLogin/");
    final response=await http.post(
        uri,
        headers: {
          "Content-Type": "application/json"
        },
        body:json.encode(
            {
              "restaurantEmail":email,
              "password":password
            }
        )
    );
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(errorMessage: responseData.toString());
    final sharedPref=await SharedPreferences.getInstance();
    sharedPref.setString(Constant.tokenKey, Constant.restaurantToken);
    sharedPref.setInt(Constant.restaurantToken, responseData["id"]);
  }


  static Future<void> registerRestaurant({
    required String restaurantName,
    required String location,
    required String openingTime,
    required String closingTime,
    required String restaurantEmail,
    required int minimumOrder,
    required String restaurantInfo,
    required String restaurantImage,
    required String password,
    required String phone,
  }) async{
    Uri uri = Uri.parse(Constant.serverUrl+"restaurantSignup/");
    var request = http.MultipartRequest("POST", uri);
    File file=File(restaurantImage);
    List<int> byteData=List.from(await file.readAsBytes());
    String imageName=restaurantImage.split("/").last;
    var multipartFileSign =  http.MultipartFile.fromBytes("restaurantImage",byteData,filename: imageName,
        contentType: MediaType('multipart', 'form-data',{"charset": "utf-8"}));
    request.files.add(multipartFileSign);
    request.fields["restaurantName"] =restaurantName;
    request.fields["location"] =location;
    request.fields["openingTime"] =openingTime;
    request.fields["closingTime"] =closingTime;
    request.fields["restaurantEmail"] =restaurantEmail;
    request.fields["minimumOrder"] =minimumOrder.toString();
    request.fields["restaurantInfo"] =restaurantInfo;
    request.fields["password"] =password;
    request.fields["restaurantPhonenumber"] =phone;
    final streamResponse=await request.send();
    final response= await http.Response.fromStream(streamResponse);
    final responseData = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode >= 300) throw HttpException(errorMessage: responseData.toString());
    final sharedPref=await SharedPreferences.getInstance();
    sharedPref.setString(Constant.tokenKey, Constant.restaurantToken);
    sharedPref.setInt(Constant.restaurantToken, responseData["id"]);
  }


}


