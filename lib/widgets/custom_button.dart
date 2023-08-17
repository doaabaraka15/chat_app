import 'package:flutter/material.dart';


class CustomElevatedButton extends StatelessWidget {
  String text ;
  Function () onPressed ;

  CustomElevatedButton({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text , style:const  TextStyle(color: Color(0xff2b475e)),),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        minimumSize: const Size(double.infinity, 50),
      ),
    );
  }
}