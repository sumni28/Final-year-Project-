import 'package:flutter/material.dart';
import 'package:kkhaney/AccountNotification/manager/notification_manager.dart';
import 'package:kkhaney/Blog/BlogPage.dart';
import 'package:kkhaney/Restaurantfromfilter/ItemDetailPage.dart';
import 'package:kkhaney/Restaurantfromfilter/user_drink_menu.dart';
import 'package:kkhaney/Restaurantfromfilter/user_food_menu.dart';
import 'package:kkhaney/menu/manager/restaurant_menu_manager.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Notifications"
          ),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.all(10),
          child: ChangeNotifierProvider(
            create: (context)=>NotificationProvider(),
            child: Consumer<NotificationProvider>(
              builder: (context,provider,child){
                if(provider.isLoading){
                  return Center(
                    child:  CircularProgressIndicator(),
                  );
                }
                if(provider.notificationList.isEmpty){
                  return Center(
                    child: Text(
                      "No Notification For Today"
                    ),
                  );
                }
                return ListView.builder(
                  itemBuilder: (context,index){
                    return NotificationWidget(data: provider.notificationList[index],);
                  },
                  itemCount: provider.notificationList.length,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  final NotificationModal data;
  const NotificationWidget({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        switch(data.type){
          case NotificationType.Blog:
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>UserBlogSpecificPage(serverBlogModal: data.blogModal!))
            );
            break;
          case NotificationType.Drink:
            ServerDrinkModal serverDrinkModal=data.drinkModal!;
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>ItemDetailPage(
                  data: ItemDetail(
                      startingEnding: "${serverDrinkModal.openingTime} to ${serverDrinkModal.closingTime}",
                      restaurantName: serverDrinkModal.restName??"",
                      name: serverDrinkModal.drinkName,
                      image: serverDrinkModal.drinkImage,
                      description: serverDrinkModal.drinkDescription,
                      price: serverDrinkModal.price,
                      id: serverDrinkModal.id??0,
                      isFood: false,
                      category: serverDrinkModal.drinkCategory,
                      discountCode: ''
                  ),
                )
                )
            );
            break;
          case NotificationType.Food:
            ServerFoodModal serverFoodModal=data.foodModal!;
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>ItemDetailPage(
                  data: ItemDetail(
                      startingEnding: "${serverFoodModal.openingTime} to ${serverFoodModal.closingTime}",
                      restaurantName: serverFoodModal.restName??"",
                      name: serverFoodModal.foodName,
                      image: serverFoodModal.foodImage,
                      description: serverFoodModal.foodDescription,
                      price: serverFoodModal.price,
                      id: serverFoodModal.id??0,
                      isFood: true,
                      category: serverFoodModal.foodCategory,
                      discountCode: ''
                  ),
                )
                )
            );

            break;
        }
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: Image.network(
                    data.image,
                    fit: BoxFit.cover,
                  )
              ),
              SizedBox(width: 10,),
              Expanded(
                flex: 3,
                  child: Column(
                    children: [
                      Text(
                          data.heading,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          decoration: TextDecoration.underline
                        ),
                      ),
                      Text(
                        data.subheading,
                        textAlign: TextAlign.center,
                      )
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
