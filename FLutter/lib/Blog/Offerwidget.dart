import 'package:flutter/material.dart';

class OfferModel {
  String image;
  OfferModel({
    required this.image,
  });
}



class Offerwidget extends StatelessWidget {
  OfferModel offerdata;
   Offerwidget({
     required this.offerdata,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 365,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
             offerdata.image
            ),
            fit: BoxFit.fill
        ),
      ),
    );
  }
}