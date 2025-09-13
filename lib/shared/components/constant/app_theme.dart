import 'package:flutter/material.dart';
import 'package:masar/shared/components/constant/app_color.dart';

ThemeData themeLight = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor:const Color(0xFFF1F6F5), //AppColor.thirdColor,
    centerTitle: true,
    titleTextStyle: TextStyle(color:const Color(0xFF00214E), //AppColor.blue,
     fontSize: 20),
    
  ),
  scaffoldBackgroundColor: const Color(0xFFEEEEEE),
  bottomNavigationBarTheme:BottomNavigationBarThemeData(
    backgroundColor:const Color(0xFFF1F6F5),// AppColor.thirdColor,
    
    elevation: 20.0,
    //selectedIconTheme: IconThemeData(color: AppColor.secaodColor ),
    selectedItemColor: AppColor.primaryColor,
    unselectedItemColor: AppColor.grey,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,

  ) 
          
);
ThemeData themeDark =  ThemeData(
                appBarTheme: AppBarTheme(
                  backgroundColor:
                    const Color(0xff191A1F), 
                  centerTitle: true,
                  actionsIconTheme: IconThemeData(color: AppColor.blue),
                  titleTextStyle:
                      TextStyle(color: AppColor.blue, fontSize: 20),
                ),
                scaffoldBackgroundColor: const Color(0xff191A1F),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: const Color(0xFF1F222B),//HexColor('313237'),

                  elevation: 20.0,
                  //selectedIconTheme: IconThemeData(color: AppColor.secaodColor ),
                  selectedItemColor: AppColor.primaryColor,
                  unselectedItemColor: AppColor.grey,
                  showUnselectedLabels: true,
                  type: BottomNavigationBarType.fixed,
                ));