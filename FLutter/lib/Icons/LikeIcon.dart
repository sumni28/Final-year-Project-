
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LikeIcon extends StatefulWidget {
  bool isbig;
  LikeIcon({
    this.isbig=false,
    Key? key,
  }) : super(key: key);

  @override
  State<LikeIcon> createState() => _LikeIconState();
}

class _LikeIconState extends State<LikeIcon> {
  bool isSelected=false;
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        padding: widget.isbig?EdgeInsets.all(4):null,
        color: Colors.white,
        child: IconButton(
          padding: EdgeInsets.all(8),
          constraints: widget.isbig?BoxConstraints(maxHeight: 48,maxWidth: 48):BoxConstraints(),
          icon: Icon(
            isSelected?FontAwesomeIcons.solidHeart:FontAwesomeIcons.heart,
            color: isSelected?Colors.red.shade500:Colors.black,
            size: widget.isbig?null:20,
          ), onPressed: () {
            setState(() {
              isSelected=!isSelected;
            });
        },
        ),
      ),
    );
  }
}