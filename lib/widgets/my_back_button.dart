import 'package:flutter/material.dart';
import 'package:healthy_san/utils/base_color.dart';

class MyBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.all(4),
        child: Icon(Icons.arrow_back,color: BaseColor.white),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: BaseColor.black.withOpacity(0.2),
        ),
      ),
    );
  }
}
