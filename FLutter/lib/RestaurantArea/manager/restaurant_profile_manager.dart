import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:kkhaney/Constant.dart';
import 'package:http/http.dart' as http;
import 'package:kkhaney/registration/manager/HttpException.dart';
class RestaurantModal{

  String cusine;
  int id,minimumOrder;
  bool sponsored;
  String name,location,openingTime,closingTime,restaurantEmail,restaurantInfo,restaurantImage,phone;
  RestaurantModal({
    required this.id,
    required this.sponsored,
    required this.minimumOrder,
    required this.name,
    required this.location,
    required this.openingTime,
    required this.closingTime,
    required this.restaurantEmail,
    required this.restaurantInfo,
    required this.restaurantImage,
    required this.phone,
    required this.cusine

  });

  factory RestaurantModal.fromMap(Map<String,dynamic> map){
    return RestaurantModal(
        id: map["id"],
        minimumOrder: map["minimumOrder"],
        name: map["restaurantName"],
        location: map["location"],
        openingTime: map["openingTime"],
        closingTime: map["closingTime"],
        restaurantEmail: map["restaurantEmail"],
        restaurantInfo: map["restaurantInfo"],
        phone: map["restaurantPhonenumber"],
        restaurantImage: ImageGetter.getImageLocation(map["restaurantImage"]),
        cusine:map["cusine"],
        sponsored:map["sponsored"]
    );
  }
}
class ImageGetter{
  static getImageLocation(String image)=>Constant.serverUrl.substring(0,Constant.serverUrl.length-1)+image;
}
class RestaurantProfileManager{

  static Future<RestaurantModal> getRestaurantDetails(int id) async{
    Uri uri =Uri.parse(Constant.serverUrl+"restaurantdetail/$id/");
    http.Response response=await http.get(uri);
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(errorMessage: responseData.toString());
    return RestaurantModal.fromMap(responseData);

  }

  static Future<int> getTotalLikes(int id) async{
    Uri uri=Uri.parse(Constant.serverUrl+"restaurantTotalLike/$id/");
    http.Response response=await http.get(uri);
    final likeResponseData=json.decode(response.body);
    return likeResponseData["count"];

  }

  static Future<double> getTotalRatings(int id) async{
    Uri uri=Uri.parse(Constant.serverUrl+"restaurantTotalRating/$id/");
    double totalRating=0.0;
    http.Response response=await http.get(uri);
    final ratingResponseData=json.decode(response.body);
    if(ratingResponseData["rating"]==0){//when server send 0, its integer but totalRating is double
      totalRating=0.0;
    }else{
      totalRating=ratingResponseData["rating"];

    }
    return totalRating;

  }

  static Future<void> editRestaurant({
    required int id,
    required String restaurantName,
    required String location,
    required String openingTime,
    required String closingTime,
    required String restaurantEmail,
    required int minimumOrder,
    required String restaurantInfo,
    required String? restaurantImage,
  }) async{
    Uri uri = Uri.parse(Constant.serverUrl+"restaurantdetail/$id/");
    var request = http.MultipartRequest("PATCH", uri);
    if(restaurantImage!=null){
      File file=File(restaurantImage);
      List<int> byteData=List.from(await file.readAsBytes());
      String imageName=restaurantImage.split("/").last;
      var multipartFileSign =  http.MultipartFile.fromBytes("restaurantImage",byteData,filename: imageName,
          contentType: MediaType('multipart', 'form-data',{"charset": "utf-8"}));
      request.files.add(multipartFileSign);
    }
    request.fields["restaurantName"] =restaurantName;
    request.fields["location"] =location;
    request.fields["openingTime"] =openingTime;
    request.fields["closingTime"] =closingTime;
    request.fields["restaurantEmail"] =restaurantEmail;
    request.fields["minimumOrder"] =minimumOrder.toString();
    request.fields["restaurantInfo"] =restaurantInfo;
    final streamResponse=await request.send();
    final response= await http.Response.fromStream(streamResponse);
    final responseData = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode >= 300) throw HttpException(errorMessage: responseData.toString());

  }
}