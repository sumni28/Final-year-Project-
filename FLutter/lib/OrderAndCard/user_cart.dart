import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/Home/widget/DrawerContainer.dart';
import 'package:kkhaney/OrderAndCard/managert/cart_provider.dart';
import 'package:kkhaney/OrderAndCard/proceed_order.dart';
import 'package:provider/provider.dart';

class UserCart extends StatelessWidget {
  const UserCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          endDrawer: Drawer(
            child: DrawerContainer(

            ),
          ),
          appBar: AppBar(
            title: Text("User Basket"),
            automaticallyImplyLeading: false,
          ),
          body: ChangeNotifierProvider(
            create: (context)=>CartProvider(),
            child: Consumer<CartProvider>(
              builder: (context,cartProvider,child) {
                if(cartProvider.isLoading){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                  height: size.height,
                  width: size.width,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                          child:cartProvider.cartList.isEmpty?
                          Center(
                            child:Text("No Item In Cart"),
                          ):
                          ListView.builder(
                            physics: BouncingScrollPhysics(),
                              itemBuilder: (context,index){
                                return CartOrOrderItemWidget(itemToDisplay: cartProvider.cartList[index]);
                              },
                            itemCount: cartProvider.cartList.length,
                          )
                      ),
                      ElevatedButton(
                          onPressed: cartProvider.cartList.isEmpty?
                          null:(){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context)=>ProceedOrder(cartProvider: cartProvider)
                                )
                            ).then((value) {
                              cartProvider.getUserCart(showReload: true);
                            });
                          },
                          child: Text("Order (Rs ${cartProvider.totalPrice})")
                      )

                    ],
                  ),
                );
              }
            ),
          ),
        )
    );
  }
}


class CartOrOrderItemWidget extends StatefulWidget {
  final CartOrOrderItemModal itemToDisplay;
  final bool isOrderItem;
  const CartOrOrderItemWidget({
    required this.itemToDisplay,
    this.isOrderItem=false,
    Key? key
  }) : super(key: key);

  @override
  _CartOrOrderItemWidgetState createState() => _CartOrOrderItemWidgetState();
}

class _CartOrOrderItemWidgetState extends State<CartOrOrderItemWidget> {
  bool deleting=false;
  bool changingQuantity=false;
  @override
  Widget build(BuildContext context) {
    return  Card(
      margin: EdgeInsets.symmetric(vertical:10),
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.all(10),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 2,
                child: Image.network(
                  widget.itemToDisplay.itemDetail.image,
                  fit: BoxFit.cover,
                )
            ),
            SizedBox(width: 10,),
            Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.itemToDisplay.itemDetail.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontSize: 18
                      ),
                    ),
                    Text(
                      "Category: "+widget.itemToDisplay.itemDetail.category,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Total Price "+(widget.itemToDisplay.itemDetail.price*widget.itemToDisplay.quantity).toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text(
                          "Quantity:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10,),
                        widget.isOrderItem?
                        Text(
                            widget.itemToDisplay.quantity.toString(),
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold
                          ),
                        )
                        :Flexible(
                          child: FittedBox(
                            child: Consumer<CartProvider>(
                              builder: (context,cartProvider,child) {
                                return changingQuantity?
                                Center(
                                  child: CircularProgressIndicator(),
                                ):
                                Container(
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          FontAwesomeIcons.minus,
                                          size: 12,
                                        ),
                                        onPressed: () async{
                                          setState(() {
                                            changingQuantity=true;
                                          });
                                          await cartProvider.updateQuantity(widget.itemToDisplay.id??0, widget.itemToDisplay.quantity-1);
                                          setState(() {
                                            changingQuantity=false;
                                          });
                                          },
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 9),
                                        child:Text(
                                          widget.itemToDisplay.quantity.toString()
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(60),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          FontAwesomeIcons.plus,
                                          size: 14,
                                        ), onPressed: ()async {
                                          setState(() {
                                            changingQuantity=true;
                                          });
                                          await cartProvider.updateQuantity(widget.itemToDisplay.id??0, widget.itemToDisplay.quantity+1);
                                          setState(() {
                                            changingQuantity=false;
                                          });
                                          },
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Constant.primaryColor,
                                      borderRadius: BorderRadius.circular(60)
                                  ),
                                );
                              }
                            ),
                          ),
                        ),

                      ],
                    )


                  ],
                )
            ),
            widget.isOrderItem?
            widget.itemToDisplay.notes!=null?
            IconButton(
                onPressed:(){
                  print("Pressed");
                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text("User Notes"),
                          content: SingleChildScrollView(
                            child: Text(
                              widget.itemToDisplay.notes??""
                            ),
                          ),
                        );
                      }
                  );
                },
                icon: Icon(
                  Icons.message
                )
            ):SizedBox()
                :Expanded(
                child: Consumer<CartProvider>(
                  builder: (context,cartProvider,child) {
                    return deleting?
                    CircularProgressIndicator():
                    IconButton(
                      onPressed: () async{
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Remove Item", //,
                                  //style:Styles.mediumHeading
                                ),
                                content:
                                Text("Do you really want to Remove this Item from Cart"),
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
                              deleting=true;
                            });
                            await cartProvider.deleteCart(widget.itemToDisplay.id??0);
                            setState(() {
                              deleting=false;
                            });
                          }
                        });

                      },
                      icon: Icon(
                        Icons.delete
                      ),

                    );
                  }
                )
            )
          ],
        ),
      ),
    );
  }
}

