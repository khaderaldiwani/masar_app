import 'package:flutter/material.dart';
import 'package:masar/layout/home_layout/cubit/home_layout_cubit.dart';
import 'package:masar/link_api.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import '../constant/app_images.dart';

AppBar customAppbarHome({
required void Function()? onPressedNoti,
required void Function()? onPressedFavo,
required void Function()? onImage,
 bool is_read=true
}) {
 String first_name =CachHelper.getString(key:"first_name")!;
 
 String last_name =CachHelper.getString(key:"last_name")!;
 
 String? image =CachHelper.getString(key:"image");

  return AppBar(
    leading: Container(
      margin: const EdgeInsetsDirectional.only(start: 10),
      child: InkWell(
        onTap: onImage,
        child: CircleAvatar(
          backgroundImage:image=="" ?AssetImage(AppImages.person):NetworkImage("${LinkApi.images}$image"),
          backgroundColor: AppColor.white,
        ),
      ),
    ),
    title: ListTile(
      title:  Padding(
      padding: const EdgeInsets.only(top: 0),
          child: Text(
          "مرحباً,👋",
          style: TextStyle(fontSize: 17,color: AppColor.black),
        ),
      ),
      subtitle: Padding(
        
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(
          "${first_name} ${last_name}",
          
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.blue),
        ),
      ),
    ),
    actions: [
      Container(
        margin: const EdgeInsetsDirectional.only(end: 10),
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: AppColor.greyButton,
              radius: 25,
              child: IconButton(
                icon:  Icon(
                  Icons.favorite_border_outlined,
                  size: 30,
                  color:AppColor.blue ,
                ),
                onPressed:onPressedFavo,
              ),
            ),
          
          ],
        ),
      ),
    
      Container(
        margin: const EdgeInsetsDirectional.only(end: 10),
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: AppColor.greyButton,
              radius: 25,
              child: IconButton(
                icon:  Icon(
                  Icons.notifications_active_outlined,
                  size: 30,
                  color:AppColor.blue ,
                ),
                onPressed:onPressedNoti,
              ),
            ),
            if(!is_read)
            PositionedDirectional(
              top: 5,
              end: 4,
              child: CircleAvatar(
                radius: 6,
                backgroundColor: Colors.green,
              ),
            )
          ],
        ),
      ),
        
    
    ],
  );
}

AppBar AppbarHomeLayout( {required String title,required BuildContext context}){
 HomeLayoutCubit cubit=HomeLayoutCubit.get(context);
  return AppBar(
              title: Text(title),
              leading: Container(
                margin: EdgeInsetsDirectional.only(start: 10),
                child: CircleAvatar(
                  radius: 10,
                  child: IconButton(
                    onPressed:(){
                     cubit.changeBottomNavBar(0);
                    },
                    icon: Icon(Icons.arrow_back),
                    color: AppColor.blue,
                  ),
                  backgroundColor: AppColor.greyLight,
                ),
              ),
            );
}
