import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color buttonColor;
  final String text;
  final IconData? iconData;

  // Constructor with required onPressed callback
  const CustomButton({Key? key, required this.onPressed, required this.buttonColor, this.iconData, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(

        onPressed: onPressed,
        style: ElevatedButton.styleFrom(

          backgroundColor: buttonColor, // Background color of button
          textStyle: TextStyle(color: Colors.black),
          // Text color
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide.none

          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if(iconData!=null)
              Icon(iconData,color: Colors.black,),
            Gap(8),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
