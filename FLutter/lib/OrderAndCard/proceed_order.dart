import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/OrderAndCard/managert/cart_provider.dart';
import 'package:kkhaney/OrderAndCard/managert/order_provider.dart';
import 'package:provider/provider.dart';

class ProceedOrder extends StatefulWidget {
  final CartProvider cartProvider;

  ProceedOrder({
    required this.cartProvider,
    Key? key
  }) : super(key: key);

  @override
  State<ProceedOrder> createState() => _ProceedOrderState();
}

class _ProceedOrderState extends State<ProceedOrder> {
  bool preorder=false;
  bool donate=false;
  bool payByKhalti=false;
  final TextEditingController locationController=TextEditingController();
  DateTime preorderDate=DateTime.now().add(Duration(days: 1));

  bool isLoading=false;


  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Proceed Order"
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(10),
            height: size.height,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(

                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Payment Details",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            thickness: 5,
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextField(
                          decoration: Constant.getDecoration("Delivery Location"),
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          controller: locationController,
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            thickness: 5,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Preorder",
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Switch(
                                value: preorder,
                                onChanged: (value){
                                  setState(() {
                                    preorder=value;
                                  });
                                }
                            ),
                            preorder?Flexible(
                              child: Text(
                                  preorderDate.toString().substring(0,10)
                              ),
                            ):SizedBox(),
                            preorder?Flexible(
                              child: TextButton(
                                  onPressed: ()async{
                                    preorderDate=await showDatePicker(
                                        context: context,
                                        initialDate: preorderDate,
                                        firstDate: DateTime.now().add(Duration(days: 1)),
                                        lastDate: DateTime.now().add(Duration(days: 8))
                                    )??preorderDate;
                                    setState(() {

                                    });
                                  },
                                  child: Text(
                                    "Click"
                                  )
                              ),
                            ):SizedBox()
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                "Donate This Food For Needy",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Switch(
                                value: donate,
                                onChanged: (value){

                                  setState(() {

                                    donate=value;
                                    if(donate){
                                      payByKhalti=true;
                                    }
                                  });
                                }
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                "Khalti Payment ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Switch(
                                value: payByKhalti,
                                onChanged: (value){
                                  setState(() {
                                    payByKhalti=value;
                                    if(donate){
                                      payByKhalti=true;
                                    }
                                  });
                                }
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            thickness: 5,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                              "Grant Total: Rs ${widget.cartProvider.totalPrice}/- Only",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17
                            ),
                          ),
                        ),
                       
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                isLoading?
                    Center(
                      child: CircularProgressIndicator(),
                    ):
                payByKhalti?ElevatedButton(
                  child:Text("Proceed By Khalti"),
                  onPressed: (){
                    if(locationController.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter Delivery Location")));
                      return;
                    }
                    KhaltiScope.of(context).pay(
                      config: PaymentConfig(
                      amount: 1000,//100 paisa means nrs 10. This much money only for testing For Testing//widget.cartProvider.totalPrice,
                      productIdentity: 'order-sadfasdf',

                      productName: 'Orders-asdfsad',
                    ),
                      preferences: [
                        PaymentPreference.khalti,
                      ],
                      onSuccess: (value){
                        doPayment(false);
                      },
                      onFailure: (value){
                        print("Failure");
                      },
                      onCancel: (){
                        print("Cancle");

                      },
                    );
                  },
                ):ElevatedButton(
                    onPressed: (){
                      doPayment(true);
                    },
                    child: Text(
                      "Proceed By Cash"
                    )
                ),
              ],
            ),
          ),
        )
    );
  }

  Future<void> doPayment(bool paymentByCash) async{
    if(locationController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter Delivery Location")));
      return;
    }
    setState(() {
      isLoading=true;
    });
    await OrderProvider.proceedOrder(
        cartList: widget.cartProvider.cartList,
        totalPrice: widget.cartProvider.totalPrice,
        location: locationController.text,
        preOrderDate: preorder?preorderDate.toString().substring(0,10):null,
        forDonating: donate,
        paymentByCash: paymentByCash
    ) .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully Ordered")));
      Navigator.pop(context);
    });
    setState(() {
      isLoading=false;
    });
  }
}
