import 'package:flutter/material.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/FoodPostDetail/Widget/TimeStartCalorie.dart';
import 'package:kkhaney/RestaurantArea/manager/restaurant_profile_manager.dart';
import 'package:kkhaney/RestaurantArea/manager/server_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RestaurantProfileEdit extends StatefulWidget {
  const RestaurantProfileEdit({Key? key}) : super(key: key);

  @override
  State<RestaurantProfileEdit> createState() => _RestaurantProfileEditState();
}


class _RestaurantProfileEditState extends State<RestaurantProfileEdit> {
  GlobalKey<FormState> formKey=GlobalKey();
  bool isLoading=false;

  String emailAddress="A",restaurantName="B",location="C",
      openingTime="D",closingTime="E",restaurantInfo="F";
  int minimumOrder=1;
  final ValueNotifier<String> restaurantServerImage=ValueNotifier("G");
  final ValueNotifier<String?> restaurantPickedImage=ValueNotifier(null);

  bool isInitializing=true;
  int totalLikes=0;
  double totalRating=0;

  @override
  void initState() {
    super.initState();
    initialize();
  }
  int restaurantId=0;
  void initialize() async{
    final sharedPref=await SharedPreferences.getInstance();
    restaurantId=sharedPref.getInt(Constant.restaurantToken)??0;
    RestaurantModal data= await RestaurantProfileManager.getRestaurantDetails(restaurantId);
    emailAddress=data.restaurantEmail;
    print(emailAddress);
    restaurantName=data.name;
    location=data.location;
    openingTime=data.openingTime;
    closingTime=data.closingTime;
    minimumOrder=data.minimumOrder;
    restaurantInfo=data.restaurantInfo;
    restaurantServerImage.value=data.restaurantImage;
    totalLikes=await RestaurantProfileManager.getTotalLikes(restaurantId);
    totalRating=await RestaurantProfileManager.getTotalRatings(restaurantId);
    setState(() {
      isInitializing=false;
    });
  }
  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: Constant.primaryColor,
          ),

          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Card(
              margin: EdgeInsets.zero,
              child:Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Restaurant Profile",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Constant.primaryColor
                        ),
                      ),
                      isInitializing?
                      SizedBox(
                        height: size.height,
                        width: size.width,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ):
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          ServerImagePicker(
                            key: ValueKey(restaurantServerImage.value),
                            serverImageLocation: restaurantServerImage,
                            pickedImageLocation: restaurantPickedImage,
                          ),
                          SizedBox(height: 15,),
                          TimeStar(
                            heart:totalLikes.toString(),
                            rating: totalRating.toString(),
                          ),
                          SizedBox(height: 10,),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  key: ValueKey(emailAddress),
                                  initialValue: emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: Constant.getDecoration("Email Address"),
                                  keyboardType: TextInputType.emailAddress,
                                  enabled: false,
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                TextFormField(

                                  key: ValueKey(restaurantName),
                                  initialValue: restaurantName,
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
                                  key: ValueKey(location),
                                  initialValue: location,
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
                                  key: ValueKey(openingTime),
                                  initialValue: openingTime,
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
                                  key: ValueKey(closingTime),
                                  initialValue: closingTime,
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
                                  key: ValueKey(minimumOrder),
                                  initialValue: minimumOrder.toString(),
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
                                  key: ValueKey(restaurantInfo),
                                  initialValue: restaurantInfo,
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
                              ],
                            ),
                          ),


                          SizedBox(
                            height: 10,
                          ),
                          isLoading?CircularProgressIndicator():
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ElevatedButton(
                                  onPressed: (){
                                    if(formKey.currentState!.validate()){
                                      formKey.currentState!.save();
                                      setState(() {
                                        isLoading=true;
                                      });
                                      RestaurantProfileManager.editRestaurant(
                                          id: restaurantId,
                                          restaurantName: restaurantName,
                                          location: location,
                                          openingTime: openingTime,
                                          closingTime: closingTime,
                                          restaurantEmail: emailAddress,
                                          minimumOrder: minimumOrder,
                                          restaurantInfo: restaurantInfo,
                                          restaurantImage: restaurantPickedImage.value
                                      ).then((value){
                                        setState(() {
                                          isLoading=false;
                                        });
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Successfully Updated"))
                                        );

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
                                    "Save Restaurant",
                                  ),
                                ),
                                SizedBox(height: 10,),

                              ],
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
              ),
              ),
            ),
          ),
        ),
      );
  }
}
