import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class ServerImagePicker extends StatefulWidget {
  final ValueNotifier<String> serverImageLocation;
  final ValueNotifier<String?> pickedImageLocation;

  const ServerImagePicker({
    required this.serverImageLocation,
    required this.pickedImageLocation,
    Key? key
  }):super(key: key);

  @override
  _ServerImagePickerState createState() => _ServerImagePickerState();
}

class _ServerImagePickerState extends State<ServerImagePicker> {
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
            child: widget.pickedImageLocation.value==null?

            Image.network(
              widget.serverImageLocation.value,
              fit: BoxFit.fill,
            ):
            Image.file(
              File(widget.pickedImageLocation.value!),
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
        widget.pickedImageLocation.value=pickedImage.path;
      });
    }

  }
}
