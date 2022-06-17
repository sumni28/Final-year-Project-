import 'package:flutter/material.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/FoodPostDetail/Widget/TimeStartCalorie.dart';
import 'package:kkhaney/RestaurantArea/manager/server_image_picker.dart';
import 'package:kkhaney/menu/manager/restaurant_menu_manager.dart';
import 'package:kkhaney/registration/manager/image_selector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantAddEditFood extends StatefulWidget {
  final ServerFoodModal? foodModal;
  const RestaurantAddEditFood({
    this.foodModal,
    Key? key
  }) : super(key: key);

  @override
  State<RestaurantAddEditFood> createState() => _RestaurantAddEditFoodState();
}

class _RestaurantAddEditFoodState extends State<RestaurantAddEditFood> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  bool forEdit=false;
  String name = "", category = "", description = "";
  String discountCode = "";
  int price = 0;
  final ValueNotifier<String?> pickedImage = ValueNotifier(null);
  late final ValueNotifier<String> serverImage;
  bool isInitializing=true;

  int totalLikes=0;
  double totalRating=0.0;
  int totalOrder=0;

  @override
  void initState() {
    super.initState();
    setUpEverything();
  }

  void setUpEverything() async{
    forEdit=widget.foodModal!=null;
    if(forEdit) {
      name=widget.foodModal!.foodName;
      category=widget.foodModal!.foodCategory;
      description=widget.foodModal!.foodDescription;
      discountCode=widget.foodModal!.foodDiscountCode;
      price=widget.foodModal!.price;
      serverImage=ValueNotifier(widget.foodModal!.foodImage);
      totalLikes=await RestaurantMenuManager.getTotalLike(widget.foodModal!.id!, true);
      totalRating=await RestaurantMenuManager.getTotalRating(widget.foodModal!.id!, true);
      totalOrder=await RestaurantMenuManager.getTotalOrder(widget.foodModal!.id!, true);


    }
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        isInitializing=false;

      });
    });
  }




  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        forEdit?"Edit Food":"Add Food",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Constant.primaryColor),
                      ),
                    isInitializing?
                    Center(
                      child: CircularProgressIndicator(),
                    ):
                    Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                forEdit?
                                ServerImagePicker(
                                    serverImageLocation: serverImage,
                                    pickedImageLocation: pickedImage
                                )
                                :GalleryImagePicker(
                                    imageLocation: pickedImage
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                forEdit?
                                TimeStar(
                                  heart:totalLikes.toString(),
                                  rating: totalRating.toString(),
                                )
                                    :SizedBox(),

                                forEdit?Text(
                                    "Ordered $totalOrder Times",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ):SizedBox(),
                                SizedBox(
                                  height: forEdit?20:0,
                                ),
                                Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        initialValue: name,
                                        textInputAction:
                                            TextInputAction.next,
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return "Please Enter Name";
                                          }
                                          return null;
                                        },
                                        onSaved: (value)=>name=value??"",
                                        decoration: Constant.getDecoration(
                                            "Food Name"),
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      TextFormField(
                                        initialValue: category,
                                        textInputAction:
                                        TextInputAction.next,
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return "Please Enter Category";
                                          }
                                          return null;
                                        },
                                        onSaved: (value)=>category=value??"",
                                        decoration: Constant.getDecoration(
                                            "Food Category"),
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      TextFormField(
                                        initialValue: description,
                                        decoration: Constant.getDecoration(
                                            "Description"),
                                        maxLines: 5,
                                        keyboardType: TextInputType.multiline,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please Enter Food Description";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          description = value ?? "";
                                        },
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      TextFormField(
                                        initialValue: price.toString(),
                                        textInputAction:
                                        TextInputAction.next,
                                        decoration: Constant.getDecoration(
                                            "Price"),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please Enter Price";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          try {
                                            price = int.parse(value ?? "0");
                                          } catch (e) {
                                            price = 1;
                                          }
                                        },
                                      ),

                                      SizedBox(
                                        height: 18,
                                      ),
                                      TextFormField(
                                        initialValue: discountCode,
                                        textInputAction:
                                        TextInputAction.next,
                                        decoration: Constant.getDecoration(
                                            "Discount Code"),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please Enter Discount";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                         discountCode=value??"";
                                        },
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      isLoading
                                          ? CircularProgressIndicator()
                                          : SizedBox(
                                              width: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .stretch,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () async{
                                                      if (formKey.currentState!.validate()) {
                                                        formKey.currentState!.save();
                                                        if(!forEdit &&pickedImage.value==null){
                                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Please Pick Image.")));
                                                          return;
                                                        }
                                                        setState(() {
                                                          isLoading = true;
                                                        });

                                                        final sharedPref=await SharedPreferences.getInstance();
                                                        int restaurantId=sharedPref.getInt(Constant.restaurantToken)??0;
                                                        Future future=

                                                        forEdit?
                                                            RestaurantMenuManager.editFood(
                                                              ServerFoodModal(
                                                                id: widget.foodModal!.id,
                                                                  foodName: name,
                                                                  foodCategory: category,
                                                                  foodDiscountCode: discountCode,
                                                                  foodImage: "yoyo",
                                                                  foodDescription: description,
                                                                  price: price,
                                                                  restaurantId: restaurantId
                                                              ),
                                                              pickedImage.value
                                                            ):RestaurantMenuManager.addFood(
                                                            ServerFoodModal(
                                                                foodName: name,
                                                                foodCategory: category,
                                                                foodDiscountCode: discountCode,
                                                                foodImage: pickedImage.value??"",
                                                                foodDescription: description,
                                                                price: price,
                                                                restaurantId: restaurantId)
                                                        );
                                                        future.then(
                                                            (value) {
                                                          setState(() {
                                                            isLoading =
                                                                false;
                                                          });
                                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully ${forEdit?"Edited":"Added"} Food")));
                                                          Navigator.pop(context);
                                                            }).onError((error, stackTrace) {
                                                          setState(() {
                                                            isLoading =
                                                                false;
                                                          });
                                                          print(error
                                                              .toString());
                                                          ScaffoldMessenger
                                                                  .of(
                                                                      context)
                                                              .showSnackBar(
                                                                  SnackBar(
                                                                      content:
                                                                          Text(error.toString())));
                                                        });
                                                      }
                                                    },
                                                    child: Text(
                                                      forEdit?"Edit Food":"Add Food",
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  forEdit?
                                                      isLoading?
                                                          Center(
                                                            child: CircularProgressIndicator(),
                                                          ):
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(primary: Colors.red),
                                                      onPressed: (){
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                  "Delete", //,
                                                                  //style:Styles.mediumHeading
                                                                ),
                                                                content:
                                                                Text("Do you really want to Delete"),
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
                                                            setState(() {
                                                              isLoading=true;
                                                            });
                                                            try{
                                                              await RestaurantMenuManager.deleteFood(widget.foodModal!.id!);
                                                              Navigator.pop(context);
                                                            }catch(e,s){
                                                              print(e.toString()+"\n"+s.toString());
                                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                                                            }
                                                            setState(() {
                                                              isLoading=false;
                                                            });
                                                          }
                                                        });
                                                      },
                                                      child: Text("Delete")
                                                  ):
                                                  SizedBox(
                                                    height: 10,
                                                  ),

                                                ],
                                              ),
                                            )
                                    ],
                                  ),
                                )
                              ],
                            ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
