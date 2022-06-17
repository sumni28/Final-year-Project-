import 'package:flutter/material.dart';


class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Scaffold(
          //backgroundColor: Colors.white,

          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: new Column(

              children: <Widget>[
                SizedBox(height: 15,),
                Center(
                    child: Text(
                      "Contact Us",
                      style: new TextStyle(
                          color: Colors.orange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    )
                ),
                SizedBox(height: 20,),
                SizedBox(height: 10,),
                new Text("Do you have any queries? \n Feel free to contact us",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontFamily: 'Cursive',
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 150,
                        padding: EdgeInsets.all(3),
                        width: 150,
                        decoration: BoxDecoration(

                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,offset: Offset(0, 8)

                              )
                            ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.email, color: Colors.orange, size: 45,),
                            SizedBox(height: 5,),
                            Text("Email:", style: new TextStyle(
                              color: Colors.orange,
                            ),),
                            Center(
                                child: Text(
                                  "KKhaneyfoodappp@gmail.com",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                              color: Colors.grey[600],
                            ),)),
                          ],
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(

                        padding: EdgeInsets.all(3),
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,offset: Offset(0,8)
                              )
                            ]
                        ),
                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.location_on, color: Colors.orange,size: 45,),
                            SizedBox(height: 5,),
                            Text("Location:", style: new TextStyle(
                              color: Colors.orange,
                            ),),
                            Center(child: Text("Dharan, Sunsari \n Nepal", textAlign: TextAlign.center, style: new TextStyle(
                              color: Colors.grey[600],
                            ),)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 150,
                        padding: EdgeInsets.all(3),
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,offset: Offset(0, 8)
                              )
                            ]
                        ),
                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.web, color: Colors.orange,size: 45,),
                            SizedBox(height: 5,),

                            Text("K Khaney Food App",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                              color: Colors.grey[600],
                            ),),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 150,
                        width: 150,
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,offset: Offset(0, 8)
                              )
                            ]
                        ),
                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.call, color: Colors.orange,size: 45,),
                            SizedBox(height: 5,),
                            Text("Contact:", style: new TextStyle(
                              color: Colors.orange,
                            ),),
                            Text("98XXXXXXXX",style: new TextStyle(
                              color: Colors.grey[600],
                            ),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30,),
                Text("Copyright (C) 2020. Sumnima Dewan", style: new TextStyle(
                    color: Colors.grey[500]
                ),),
                Text("All Rights Reserved.", style: new TextStyle(
                    color: Colors.grey[500]
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

