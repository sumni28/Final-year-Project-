import 'package:flutter/material.dart';
import 'package:kkhaney/OrderAndCard/managert/order_items_provider.dart';
import 'package:kkhaney/OrderAndCard/managert/order_provider.dart';
import 'package:kkhaney/OrderAndCard/user_cart.dart';
import 'package:provider/provider.dart';

class OrderItems extends StatefulWidget {
  final Order order;
  final bool isUser;
  const OrderItems({
    required this.isUser,
    required this.order,
    Key? key
  }) : super(key: key);

  @override
  State<OrderItems> createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Order Items"),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.all(10),
          child: ChangeNotifierProvider(
              create: (context)=>OrderItemProvider(orderId: widget.order.id),
            child: Consumer<OrderItemProvider>(
              builder: (context,provider,child){
                if(provider.isLoading){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index){
                          return CartOrOrderItemWidget(itemToDisplay: provider.orderItemsList[index], isOrderItem: true,);
                        },
                        itemCount: provider.orderItemsList.length,
                      ),
                    ),
                    isLoading?Center(
                      child: CircularProgressIndicator(),
                    ):
                    widget.isUser?
                    ElevatedButton(
                        onPressed: widget.order.restaurantDelivered?() async{
                          setState(() {
                            isLoading=true;
                          });
                          await OrderProvider.userReceived(widget.order.id).then((value){
                            Navigator.pop(context);
                          });
                          setState(() {
                            isLoading=false;
                          });
                        }:null,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.order.restaurantDelivered?"You Received. \n${widget.order.paymentDone?"":" Rs ${widget.order.totalPrice} /-"}":"Restaurant Is Delivering",
                            textAlign: TextAlign.center,
                          ),
                        )
                    ):ElevatedButton(
                        onPressed: !widget.order.restaurantDelivered?() async{
                          setState(() {
                            isLoading=true;
                          });
                          await OrderProvider.restaurantDelivered(widget.order.id).then((value){
                            if(widget.order.forDonating){
                              Navigator.pop(context);
                            }
                            setState(() {
                              widget.order.restaurantDelivered=true;

                            });
                          });
                          setState(() {
                            isLoading=false;
                          });
                        }:null,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.order.forDonating?"Donate This To Needy":
                            widget.order.restaurantDelivered?"User Haven't Received Yet":"Items is Delivered To User. \n${widget.order.paymentDone?"":" Rs ${widget.order.totalPrice} /-"}",
                            textAlign: TextAlign.center,
                          ),
                        )
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
