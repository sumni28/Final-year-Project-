import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class GalleryImagePicker extends StatefulWidget {
  final ValueNotifier<String?> imageLocation;

  const GalleryImagePicker({
    required this.imageLocation,
    Key? key
  }):super(key: key);

  @override
  _GalleryImagePickerState createState() => _GalleryImagePickerState();
}

class _GalleryImagePickerState extends State<GalleryImagePicker> {
  late final ImagePicker _imagePicker;
  @override
  void initState() {
    super.initState();
    _imagePicker=ImagePicker();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 150,
        width: 150,
        child: GestureDetector(
          onTap: openImagePicker,
          child: widget.imageLocation.value==null?

          Image.asset(
            "LocalFoodPhotos/Jholmomo.PNG",
            fit: BoxFit.fill,
          ):
          Image.file(
            File(widget.imageLocation.value!),
            fit: BoxFit.fill,

          )
        ),
      ),
    );
  }

  void openImagePicker() async{

    final pickedImage= await _imagePicker.pickImage(source: ImageSource.gallery);
    if(pickedImage!=null){
      setState(() {
        widget.imageLocation.value=pickedImage.path;
      });
    }

  }
}
