import 'package:flutter/material.dart';
import 'package:kkhaney/RestaurantArea/blog_edit_add.dart';
import 'package:kkhaney/RestaurantArea/manager/restaurant_blog_manager.dart';
import 'package:provider/provider.dart';

class RestaurantBlog extends StatelessWidget {
  final int restaurantId;
  const RestaurantBlog({
    required this.restaurantId,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context)=>RestaurantBlogProvider(restaurantId: restaurantId),
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: Consumer<RestaurantBlogProvider>(
            builder: (context,provider,child) {
              return FloatingActionButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BlogEditAdd())).then((value){
                   provider.getBlog();
                  });
                },
                child: Icon(
                  Icons.add
                ),
              );
            }
          ),
          appBar: AppBar(
            title: Text("Your Blogs"),
          ),
          body: Container(
            padding: EdgeInsets.all(10),
            height: size.height,
            width: size.width,
            child: Consumer<RestaurantBlogProvider>(
              builder: (context,provider,child){
                if(provider.isLoading){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(provider.blogList.isEmpty){
                  return Center(
                    child:Text(
                      "No Blog."
                    ),
                  );
                }
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index){
                      return RestaurantBlogWidget(blogModal: provider.blogList[index],);
                    },
                  itemCount: provider.blogList.length,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class RestaurantBlogWidget extends StatefulWidget {
  final ServerBlogModal blogModal;
  const RestaurantBlogWidget({
    required this.blogModal,
    Key? key,
  }) : super(key: key);

  @override
  State<RestaurantBlogWidget> createState() => _RestaurantBlogWidgetState();
}

class _RestaurantBlogWidgetState extends State<RestaurantBlogWidget> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantBlogProvider>(
      builder: (context,provider,child) {
        return InkWell(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>BlogEditAdd(blogModal: widget.blogModal,))
            ).then((value) {
              provider.getBlog();
            });
          },
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Expanded(
                    child:Image.network(
                      widget.blogModal.image
                    )
                ),
                Expanded(
                  flex: 2,
                    child: Column(
                      children: [
                        Text(
                            widget.blogModal.heading,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            decoration: TextDecoration.underline
                          ),
                        ),
                        Text(widget.blogModal.description),
                      ],
                    )
                ),
                Consumer<RestaurantBlogProvider>(
                  builder: (context,provider,child) {
                    return isLoading?
                    CircularProgressIndicator():
                    IconButton(
                        onPressed: (){
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "Delete Blog", //,
                                    //style:Styles.mediumHeading
                                  ),
                                  content:
                                  Text("Do you really want to Delete Blog"),
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
                                isLoading=true;
                              });
                              await provider.deleteBlog(widget.blogModal.id??0);
                              setState(() {
                                isLoading=false;
                              });
                            }
                          });

                        },
                        icon: Icon(
                          Icons.delete
                        )
                    );
                  }
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
