import 'package:flutter/material.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/RestaurantArea/manager/restaurant_blog_manager.dart';
import 'package:kkhaney/RestaurantArea/manager/server_image_picker.dart';
import 'package:kkhaney/registration/manager/image_selector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlogEditAdd extends StatefulWidget {
  final ServerBlogModal? blogModal;
  const BlogEditAdd({
    this.blogModal,
    Key? key
  }) : super(key: key);

  @override
  State<BlogEditAdd> createState() => _BlogEditAddState();
}

class _BlogEditAddState extends State<BlogEditAdd> {
  bool forEdit=false;
  final ValueNotifier<String?> imageLocation=ValueNotifier(null);
  final ValueNotifier<String> serverImage=ValueNotifier("");
  bool isLoading=false;
  final GlobalKey<FormState> formKey=GlobalKey();
  String headingValue="",descriptionValue="";
  @override
  void initState() {
    super.initState();
    forEdit=widget.blogModal!=null;
    if(forEdit){
      serverImage.value=widget.blogModal!.image;
      headingValue=widget.blogModal!.heading;
      descriptionValue=widget.blogModal!.description;
    }
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            forEdit?"Edit Blog":"Add Blog"
          ),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  forEdit?
                  ServerImagePicker(
                      serverImageLocation: serverImage,
                      pickedImageLocation: imageLocation
                  )
                  :GalleryImagePicker(
                      imageLocation: imageLocation
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    initialValue: headingValue,
                    textInputAction: TextInputAction.next,
                    onSaved: (value)=>headingValue=value??"",
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please Enter Heading";
                      }
                      return null;
                    },
                    decoration: Constant.getDecoration("Heading"),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    initialValue: descriptionValue,
                    decoration: Constant.getDecoration("Description"),
                    maxLines: 10,
                    onSaved: (value)=>descriptionValue=value??"",
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please Enter Description";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 10,),
                  isLoading?
                  Center(
                    child: CircularProgressIndicator(),
                  ):
                  ElevatedButton(
                      onPressed: () async{
                        if(formKey.currentState!.validate()){
                          formKey.currentState!.save();
                          if(imageLocation.value==null && !forEdit){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pick Image")));
                            return;
                          }
                          setState(() {
                            isLoading=true;
                          });
                          final sharedPref=await SharedPreferences.getInstance();
                          int restaurantId=sharedPref.getInt(Constant.restaurantToken)??0;
                          String date=DateTime.now().toString().substring(0,10);
                          try{
                            Future future=forEdit?
                            RestaurantBlogProvider.editBlog(
                                ServerBlogModal(
                                  id: widget.blogModal!.id??0,
                                    heading: headingValue,
                                    description: descriptionValue,
                                    image: imageLocation.value??"",
                                    date: date,
                                    restaurantId: restaurantId
                                ),
                              imageLocation.value!=null
                            )

                            :RestaurantBlogProvider.addBlog(
                                ServerBlogModal(
                                    heading: headingValue,
                                    description: descriptionValue,
                                    image: imageLocation.value??"",
                                    date: date,
                                    restaurantId: restaurantId
                                )
                            );
                            await future.then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(forEdit?"Successfully Edited":"Successfully Added")));
                              Navigator.pop(context);
                            });
                          }catch (e){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                          }

                          setState(() {
                            isLoading=false;
                          });
                        }


                      },
                      child: Text(
                        forEdit?"Edit Blog":"Add Blog"
                      )
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
