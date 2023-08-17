import 'package:flutter/material.dart';

import '../utils/constants.dart';


class ChatBubble extends StatelessWidget {
  String? content ;
  double bottomRight ;
  double bottomLeft ;
  Color color ;
  Alignment alignment ;

  ChatBubble({
    required this.content ,
    this.bottomLeft = 0,
    this.bottomRight = 30,
    this.alignment = Alignment.centerLeft,
    this.color = KprimaryColor ,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        // height: 65,
        // width: 190,
        padding:const EdgeInsets.all(18),
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
              bottomRight: Radius.circular(bottomRight),
            bottomLeft: Radius.circular(bottomLeft)
          ),
          color: color,
        ),
        child:Text(
          content!,
          style:const TextStyle(color: Colors.white , fontSize: 18),
        ),
      ),
    );
  }
}

