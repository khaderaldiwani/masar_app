import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:masar/main.dart';
import 'package:masar/module/splash/splash_cubit.dart/splash_cubit.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_images.dart';
import 'package:masar/shared/components/constant/app_lottie.dart';
import 'package:masar/shared/components/constant/app_route.dart';
import 'package:masar/shared/network/local/cach_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () {
   //  CachHelper.putString(key: "step", value:"1" );
   CachHelper.putBool(key: "noti", value: true);
      String? step= CachHelper.getString(key: "step");
      if (step == "1") {
navigatorKey.currentState?.pushNamedAndRemoveUntil(
  AppRoute.login,
  (Route<dynamic> route) => false, // يمسح كل الصفحات السابقة
);

      }else if(step == "2"){
//   if (context.mounted) {
//   Navigator.pushNamedAndRemoveUntil(
//     context,
//     AppRoute.homeLayout,
//     (route) => false,
//   );
// }

navigatorKey.currentState?.pushNamedAndRemoveUntil(
  AppRoute.homeLayout,
  (Route<dynamic> route) => false, // يمسح كل الصفحات السابقة
);

      }

      else{
     // navigatorKey.currentState?.pushReplacementNamed(AppRoute.onboarding);
navigatorKey.currentState?.pushNamedAndRemoveUntil(
  AppRoute.onboarding,
  (Route<dynamic> route) => false, // يمسح كل الصفحات السابقة
);
      }
    
    });
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   //   backgroundColor: Color.lerp(AppColor.secaodColor, Colors.white, 0.7)!, 
      //AppColor.primaryColor, // أو لون ثيم التطبيق
      body:Container(
        decoration: BoxDecoration(
           color: AppColor.white
        ),
        child:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //color: App,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
            //   shape: BoxShape.circle,
               borderRadius: BorderRadius.circular(200),
             //  color:  const Color.fromARGB(213, 255, 255, 255)
              ),
              child: Image(image: AssetImage(AppImages.logo,),height: 200,width: 200,)
              ),
          //  Icon(Icons.flutter_dash, size: 100, color: Colors.white),
          //  SizedBox(height: 20),
            Stack(
             alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                
                Text(
                  "MASAR",
                  style: TextStyle(fontSize: 32, color: AppColor.primaryColor, fontWeight: FontWeight.bold),
                ),
                   Positioned(
                            bottom:-150 ,                    
                    child: Center(child: Lottie.asset(AppLottie.loading,height: 250,width: 250),))
         
              ],
            ),
          ],
        ),
      ) 
        ) 
      
    );
 
  }
}
