import 'package:flutter/material.dart';
import 'package:kkhaney/Home/widget/DrawerContainer.dart';
import 'package:kkhaney/OrderAndCard/Order_Items_page.dart';
import 'package:kkhaney/OrderAndCard/managert/order_provider.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  final bool forUser;
  const OrderPage({
    required this.forUser,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          endDrawer: forUser?Drawer(child: DrawerContainer(),):null,
          appBar: AppBar(
            title: Text("Orders"),
          ),
          body: Container(
            height: size.height,
            width: size.width,
            padding: EdgeInsets.all(10),
            child: ChangeNotifierProvider(
              create: (context)=>OrderProvider(forUser: forUser),
              child: Consumer<OrderProvider>(
                builder: (context,orderProvider,child){
                  if(orderProvider.isLoading){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(orderProvider.orderList.isEmpty){
                    return Center(
                      child: Text(
                        "No Orders For Now"
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: orderProvider.orderList.length,
                    itemBuilder: (context,index){
                      return OrderWidget(
                        order: orderProvider.orderList[index], isUser: orderProvider.forUser,
                      );
                    },
                  );
                },

              ),
            ),
          ),
        )
    );
  }
}

class OrderWidget extends StatelessWidget {

  final Order order;
  final bool isUser;
  const OrderWidget({
    required this.order,
    required this.isUser,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
            context, MaterialPageRoute(builder: (context)=>OrderItems(order: order,isUser: isUser,))
        ).then((value){
          Provider.of<OrderProvider>(context,listen: false).getOrder(showLoading: true);
        });
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: Image.network(order.restaurantModal.restaurantImage)
              ),
              SizedBox(width:isUser? 10:0,),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Text(
                        "Order Id: ${order.id}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        fontSize: 18
                      ),
                    ),
                    Text(
                      order.forDonating?"Donate This To Needy":
                      order.restaurantDelivered?isUser?"Restaurant Have Already Delivered.":"User Haven't Received Yet.":isUser?"Restaurant Is Preparing!!":"User Is Waiting!!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: order.forDonating?Colors.green: order.restaurantDelivered?Colors.red:null,
                        fontWeight: (order.forDonating ||order.restaurantDelivered)?FontWeight.bold:null,
                      ),
                    ),
                   Text(
                       order.paymentDone?"Already Paid":"Amount: Rs.${order.totalPrice}/-",
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       fontSize: 14,
                       fontWeight: FontWeight.w600
                     ),
                    ),
                    order.preOrderDate!=null?Text(
                      "Preorder Date :${order.preOrderDate}",
                      textAlign: TextAlign.center,
                    ):SizedBox(),
                    Text(
                      "Location: ${order.location}",
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Contact: ${isUser?order.restaurantModal.phone:order.userPhone}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    )

                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
