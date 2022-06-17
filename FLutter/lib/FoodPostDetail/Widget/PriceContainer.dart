import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/Model/FoodModel.dart';

class PriceContainer extends StatefulWidget {
  final ValueNotifier quantityValue;
  const PriceContainer({
    required this.quantityValue,
    Key? key,
    required this.price,
  }) : super(key: key);

  final int price;

  @override
  State<PriceContainer> createState() => _PriceContainerState();
}

class _PriceContainerState extends State<PriceContainer> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.quantityValue.value=1;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10,top: 0,right: 0),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(60)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Rs." + (widget.price*widget.quantityValue.value).toString(),
            style: TextStyle(
                color: Constant.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.minus,
                    size: 12,
                  ), onPressed: () {

                    if(widget.quantityValue.value>1){
                      setState(() {
                        widget.quantityValue.value=widget.quantityValue.value-1;

                      });
                    }
                },
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 9),
                  child:Text(
                    widget.quantityValue.value.toString(),
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
                  ), onPressed: () {
                    if(widget.quantityValue.value<10){

                      setState(() {
                        widget.quantityValue.value=widget.quantityValue.value+1;
                      });
                    }
                },
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Constant.primaryColor,
              borderRadius: BorderRadius.circular(60)
            ),
          ),
        ],
      ),
    );
  }
}

