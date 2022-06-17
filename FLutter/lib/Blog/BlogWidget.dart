import 'package:flutter/material.dart';

class BlogDummyModel {
  String image, location, cusine, restaurantName;
  BlogDummyModel({
    required this.image,
    required this.location,
    required this.restaurantName,
    required this.cusine,
  });
}


class BlogWidget extends StatelessWidget {
  BlogDummyModel blogdata;
  BlogWidget({
    required this.blogdata,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.2), width: 4),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          ClipRRect(

            borderRadius: BorderRadius.circular(5),
            child: SizedBox(
                height: 150,
                width: double.infinity,
                child: Image.asset(
                  blogdata.image,
                  fit: BoxFit.fill,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Text(
                  blogdata.restaurantName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  blogdata.location,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Divider(
                  thickness: 5,
                  color: Colors.grey.withOpacity(0.3),
                ),
                Text(
                  blogdata.cusine,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
