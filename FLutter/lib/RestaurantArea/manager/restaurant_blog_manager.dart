import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/RestaurantArea/manager/restaurant_profile_manager.dart';
import 'package:kkhaney/registration/manager/HttpException.dart';

class ServerBlogModal{
  String heading,description,image,date;
  int restaurantId;
  int? id;
  RestaurantModal? restaurantModal;
  ServerBlogModal(
  {
    this.restaurantModal,
    required this.heading,
    required this.description,
    required this.image,
    required this.date,
    this.id,
    required this.restaurantId
  });

  factory ServerBlogModal.fromMap(Map map){
    return ServerBlogModal(
        heading: map["heading"],
        description: map["description"],
        image: ImageGetter.getImageLocation(map["image"]),
        date: map["date"],
        restaurantId: map["restaurant"]["id"],
      id: map["id"],
      restaurantModal: RestaurantModal.fromMap(map["restaurant"])
    );
  }
}


class RestaurantBlogProvider with ChangeNotifier{
  int restaurantId;
  RestaurantBlogProvider({
    required this.restaurantId,
  }){
    getBlog();
  }
  List<ServerBlogModal> blogList=[];

  bool isLoading=true;
  Future<void> getBlog() async{
    Uri uri=Uri.parse(Constant.serverUrl+"restaurantBlog/$restaurantId/");
    http.Response response=await http.get(uri);
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(errorMessage: responseData.toString());
    blogList.clear();
    for(Map map in responseData){
      blogList.add(ServerBlogModal.fromMap(map));
    }
    isLoading=false;
    notifyListeners();
  }

  Future<void> deleteBlog(int id) async{
    Uri uri=Uri.parse(Constant.serverUrl+"blog/$id/");
    await http.delete(uri);
    await getBlog();
  }

  static Future<void> addBlog(ServerBlogModal modal) async{
    Uri uri = Uri.parse(Constant.serverUrl+"blog/");
    var request = http.MultipartRequest("POST", uri);
    File file=File(modal.image);
    List<int> byteData=List.from(await file.readAsBytes());
    String imageName=modal.image.split("/").last;
    var multipartFileSign =  http.MultipartFile.fromBytes("image",byteData,filename: imageName,
        contentType: MediaType('multipart', 'form-data',{"charset": "utf-8"}));
    request.files.add(multipartFileSign);
    request.fields["heading"] =modal.heading;
    request.fields["description"] =modal.description;
    request.fields["restaurant"] =modal.restaurantId.toString();
    request.fields["date"] =modal.date;
    final streamResponse=await request.send();
    final response= await http.Response.fromStream(streamResponse);
    final responseData = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode >= 300) throw HttpException(errorMessage: responseData.toString());
  }

  static Future<void> editBlog(ServerBlogModal modal,bool haveNewImage) async{
    Uri uri = Uri.parse(Constant.serverUrl+"blog/${modal.id}/");
    var request = http.MultipartRequest("PATCH", uri);
    if(haveNewImage){
      File file=File(modal.image);
      List<int> byteData=List.from(await file.readAsBytes());
      String imageName=modal.image.split("/").last;
      var multipartFileSign =  http.MultipartFile.fromBytes("image",byteData,filename: imageName,
          contentType: MediaType('multipart', 'form-data',{"charset": "utf-8"}));
      request.files.add(multipartFileSign);
    }

    request.fields["heading"] =modal.heading;
    request.fields["description"] =modal.description;
    final streamResponse=await request.send();
    final response= await http.Response.fromStream(streamResponse);
    final responseData = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode >= 300) throw HttpException(errorMessage: responseData.toString());
  }
}