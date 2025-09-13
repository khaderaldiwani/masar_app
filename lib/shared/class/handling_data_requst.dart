import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_lottie.dart';
import 'package:masar/shared/network/remote/status_requst.dart';

class HandlingDataRequst extends StatelessWidget {
  final StatusRequest? statusRequest;
  final Widget widget;
  final String? textNodata;
  final bool noDataLottie; 
  const HandlingDataRequst({super.key, required this.statusRequest, required this.widget,this.textNodata, this.noDataLottie=true});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading? Center(
      child://CircularProgressIndicator()
      SizedBox(
        
        child: Stack(
        alignment: Alignment.bottomCenter,
          children: [
            Lottie.asset(AppLottie.book,width: 250,height: 250),
            Positioned(
        bottom: -60,
        child: Lottie.asset(AppLottie.loading,width: 200,height: 200))
           
        ],),
      )
    )
  :statusRequest ==StatusRequest.serverfailure?
   Center(child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
   if(noDataLottie)  Lottie.asset(AppLottie.serverfailure,width: 250,height: 250),
      defaultBodyTitle(title: textNodata?? "حدث خطأ ما!",color: AppColor.grey)
    ],
  ))
  :statusRequest ==StatusRequest.failure?
  Center(child: SizedBox(
    
    child: Stack(
     alignment: Alignment.bottomCenter,
      children: [
     if(noDataLottie)  Lottie.asset(AppLottie.nodata,width: 250,height: 250),
        defaultBodyTitle(title: textNodata?? "لا يوجد بيانات ",color: AppColor.grey)
      ],
    ),
  ))
  :statusRequest ==StatusRequest.offLinefailure?
   Center(child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
   if(noDataLottie)  Lottie.asset(AppLottie.offline,width: 250,height: 250),
      defaultBodyTitle(title: textNodata?? "لا يوجد انترنت! ",color: AppColor.grey)
    ],
  ))
  :statusRequest ==StatusRequest.offLinefailure?
  Center(child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
   if(noDataLottie)  Lottie.asset(AppLottie.serverfailure,width: 250,height: 250),
      defaultBodyTitle(title: textNodata?? "حدث خطأ ما!",color: AppColor.grey)
    ],
  ))
    :widget;
  }
}

