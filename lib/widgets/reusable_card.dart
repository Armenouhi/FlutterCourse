import 'package:flutter/material.dart';
import '../constants.dart';

// ignore: must_be_immutable
class ReusableCardW extends StatelessWidget {
   Color? color;
   Widget? child;
   Function? onTap ;
   IconData? iconData;
   double? sizeIconData;
   String? text;
   
    ReusableCardW({
      Key? key,
       this.color,
       this.child,
       this.onTap,
       this.iconData,
       this.sizeIconData,
       this.text
    }) : super(key: key);

    static bool isTap = false;
    static String page = '';
  
  @override
  Widget build(BuildContext context) {
    // print(FontAwesomeIcons.mars.runtimeType);
    return GestureDetector(
      // ignore: avoid_print
      onTap: () => {
        isTap = true,
        iconData == Icons.supervised_user_circle_sharp ? page = 'products' : page
      },
      child:  Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: kActivateCardColor,
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        height: 150,
          child: Column(
            children: [
              Icon(iconData),
              Text('$text', style: kBodyTextStyle,)
            ],
          ),
      ),
    );
  } 
}