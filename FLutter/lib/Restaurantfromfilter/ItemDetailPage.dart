
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/FoodPostDetail/Widget/IngredientsContainer.dart';
import 'package:kkhaney/FoodPostDetail/Widget/PriceContainer.dart';
import 'package:kkhaney/FoodPostDetail/Widget/TimeStartCalorie.dart';
import 'package:kkhaney/OrderAndCard/managert/cart_provider.dart';
import 'package:kkhaney/Restaurantfromfilter/RestaurantDetailsForUser.dart';
import 'package:kkhaney/Restaurantfromfilter/manager/item_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ItemDetail{
  int id;
  String name;
  int price;
  String discountCode;
  String description;
  String image;
  String category;
  String restaurantName;
  int? restaurantId;
  bool isFood;
  String startingEnding;
  ItemDetail({
    this.restaurantId,
    required this.startingEnding,
    required this.image,
    required this.id,
    required this.name,
    required this.price,
    required this.discountCode,
    required this.description,
    required this.category,
    required this.isFood,
    required this.restaurantName,


  });
}
class ItemDetailPage extends StatefulWidget {
  ItemDetail data;

  ItemDetailPage({
    required this.data, Key? key}) : super(key: key);

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  ValueNotifier<int> quantityValue=ValueNotifier(1);

  final TextEditingController customizationNotes=TextEditingController();

  bool addingToCart=false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return ChangeNotifierProvider(
      create: (context)=>ItemManager(
        isFood: widget.data.isFood,
        itemId: widget.data.id
      ),
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: height,
                width: width,
                color: Constant.primaryColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 87,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: width,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child:
                                Image.network(
                                  widget.data.image,
                                  height: 260,
                                  fit: BoxFit.cover,
                                )
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                widget.data.name,
                                textAlign: TextAlign.center,
                                style:TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Restaurant: "+widget.data.restaurantName,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16
                                ),
                              ),


                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Category: "+widget.data.category,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600
                                ),
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              Consumer<ItemManager>(
                                builder: (context,provider,child) {
                                  return provider.totalRatingLikesLoading?
                                  Center(
                                    child: CircularProgressIndicator(),
                                  ):TimeStar(
                                    startingEnding: widget.data.startingEnding,
                                    heart:provider.totalLikes.toString() ,
                                    rating: provider.totalRating.toString(),
                                  );
                                }
                              ),
                              ItemRatingWidget(),
                              SizedBox(
                                height: 10,
                              ),

                              addingToCart?
                              Center(
                                child: CircularProgressIndicator(),
                              ):
                              Column(
                                children: [
                                  PriceContainer(
                                    price: widget.data.price,
                                    quantityValue: quantityValue,
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    decoration: Constant.getDecoration("Customization Notes"),
                                    maxLines: 3,
                                    controller: customizationNotes,
                                    keyboardType: TextInputType.multiline,
                                  ),

                                  TextButton(
                                      onPressed: () async{
                                        final sharedPref=await SharedPreferences.getInstance();
                                        int userId=sharedPref.getInt(Constant.userIdKey)??0;
                                        setState(() {
                                          addingToCart=true;
                                        });
                                        try{
                                          await CartProvider.addCart(
                                              CartOrOrderItemModal(
                                                  id: null,
                                                  itemDetail: widget.data,
                                                  quantity: quantityValue.value,
                                                  notes: customizationNotes.text,
                                                  userId: userId
                                              )
                                          );
                                        }
                                        catch(e){
                                          rethrow;
                                        }
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Succesfully Added")));

                                        setState(() {
                                          addingToCart=false;
                                        });
                                      },
                                      child: Text(
                                          "Add To Card"
                                      )
                                  ),
                                ],
                              ),


                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Text(
                                      "Description",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17
                                      ),
                                    ),
                                    Text(
                                      widget.data.description,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),


                              IngredientsContainer(),
                              SizedBox(
                                height: 35,
                              ),
                              ItemUserComments(isFood: widget.data.isFood, id: widget.data.id,)
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight:Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 20,
                left: 22,
                child: ClipOval(
                  child: Container(
                    color: Colors.white,
                    child: IconButton(
                      icon: Icon(
                          Icons.keyboard_arrow_left_outlined
                      ), onPressed: () {
                      Navigator.pop(context);
                    },
                    ),

                  ),
                ),
              ),
              Positioned(
                  top: 20,
                  right: 22,
                  child: ItemLikeIcon(isbig: true,)
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemUserComments extends StatelessWidget {
  final bool isFood;
  final int id;
  final TextEditingController textEditingController = TextEditingController();

  ItemUserComments({
    required this.isFood,
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>ItemCommentProvider(isFood: isFood, id: id),
      child: Consumer<ItemCommentProvider>(
          builder: (context, provider, child) {
            return provider.isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        decoration: Constant.getDecoration("Send Comment"),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          provider.addComment(textEditingController.text);
                        },
                        child: Text("Comment"))
                  ],
                ),
                provider.commentsList.isEmpty
                    ? Center(
                  child: Text("No Comments"),
                )
                    : SizedBox(
                  height: 200,
                  child: ListView.builder(

                    reverse: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SingleCommentWidget(
                        comments: provider.commentsList[index],
                      );
                    },
                    itemCount: provider.commentsList.length,
                  ),
                )
              ],
            );
          }),
    );
  }
}

class ItemRatingWidget extends StatelessWidget {
  const ItemRatingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<ItemManager>(
        builder: (context, provider, child) {
          return Center(
            child: SizedBox(
              width: size.width * 0.6,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: provider.loadingLikeRating
                      ? Center(
                    child: CircularProgressIndicator(),
                  )
                      : Row(
                    children: [
                      for (int i = 1; i <= 5; i++)
                        Expanded(
                            child: InkWell(
                              onTap: () {
                                if (i != provider.rating) {
                                  provider.addFeedback(enteredRating: i);

                                } else if (i == 1) {
                                  provider.addFeedback(enteredRating: 0);
                                }
                              },
                              child: Icon(
                                provider.rating >= i
                                    ? Icons.star
                                    : Icons.star_border,
                                color:
                                provider.rating >= i ? Colors.yellow : null,
                              ),
                            ))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

}




class ItemLikeIcon extends StatefulWidget {
  bool isbig;
  ItemLikeIcon({
    this.isbig=false,
    Key? key,
  }) : super(key: key);

  @override
  State<ItemLikeIcon> createState() => _ItemLikeIconState();
}

class _ItemLikeIconState extends State<ItemLikeIcon> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemManager>(
        builder: (context,provider,child) {
          return ClipOval(
            child: Container(

              padding: widget.isbig?EdgeInsets.all(4):null,
              color: Colors.white,
              child: provider.loadingLikeRating?
              CircularProgressIndicator():IconButton(
                padding: EdgeInsets.all(8),
                constraints: widget.isbig?BoxConstraints(maxHeight: 48,maxWidth: 48):BoxConstraints(),
                icon: Icon(
                  provider.liked?FontAwesomeIcons.solidHeart:FontAwesomeIcons.heart,
                  color: provider.liked?Colors.red.shade500:Colors.black,
                  size: widget.isbig?null:20,
                ), onPressed: () {
                setState(() {
                  provider.addFeedback(enteredLiked: !provider.liked);
                });
              },
              ),
            ),
          );
        }
    );
  }
}

