import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


class AppColor {
  
  static Color primaryColor=const Color(0xFF106EAC);
  static Color secaodColor=const Color(0xFF2404CC);
  static Color thirdColor= const Color.fromARGB(255, 237, 246, 252);
  static Color fourthColor=const Color.fromARGB(255, 183, 247, 199);
  
  static Color scaffoldColor=const Color(0xFFEEEEEE);

  static Color blue= const Color(0xFF00214E);
  static Color white= Colors.white;
  static Color black= Colors.black;
  static Color greyapp= const Color.fromARGB(255, 99, 99, 99);
  static Color grey= Colors.grey;
  static Color greyLight= Color(0xFFE6E6E6);
 static Color greyButton= Color(0xFFD9D9D9);
 
 
 
 
  static intiColor(bool isDark){
    if (isDark) {
    primaryColor=Colors.blue;
   secaodColor=const Color(0xFF2404CC);
   thirdColor=const Color(0xFF323A44); //1F222B
   fourthColor=const Color(0xFF1F222B);
   scaffoldColor=const Color(0xff191A1F);

   blue= Colors.blue;
   white=HexColor('313237');
   black= Colors.white;
   greyapp=  Colors.white;
   grey= Colors.grey;
   greyLight= Color(0xFF1F222B);
  greyButton= Color(0xFF1F222B);
      
    }
   else{
   primaryColor=const Color(0xFF106EAC);
   secaodColor=const Color(0xFF2404CC);
   thirdColor= const Color.fromARGB(255, 237, 246, 252);
   fourthColor=const Color.fromARGB(255, 94, 191, 255);
   scaffoldColor=const Color(0xFFEEEEEE);

   blue= const Color(0xFF00214E);
   white= Colors.white;
   black= Colors.black;
   greyapp= const Color.fromARGB(255, 99, 99, 99);
   grey= Colors.grey;
  greyLight= Color(0xFFE6E6E6);
 greyButton= Color(0xFFD9D9D9);
    
   }
  }
  
  }

  //   static Color primaryColor=const Color(0xFF6EDD8A);
  // static Color secaodColor=const Color.fromARGB(255, 18, 207, 65);
  // static Color thirdColor=const Color(0xFFF1F6F5);
  // static Color fourthColor=const Color.fromARGB(255, 183, 247, 199);
  
  // static Color scaffoldColor=const Color(0xFFEEEEEE);

  // static Color blue= const Color(0xFF00214E);
  // static Color white= Colors.white;
  // static Color greyapp= const Color.fromARGB(255, 99, 99, 99);
  // static Color grey= Colors.grey;
  // static Color black= Colors.black;
  