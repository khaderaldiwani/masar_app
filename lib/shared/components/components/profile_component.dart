import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masar/link_api.dart';
import 'package:masar/model/student_profile_model.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_images.dart';
import 'package:masar/shared/network/local/cach_helper.dart';

Widget buildProfilItem({required XFile? file,required void Function()? onPressed,required StudentProfileModel model}) {
  String? image =CachHelper.getString(key:"image");
 
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 40),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: image=="" ?AssetImage(AppImages.person):NetworkImage("${LinkApi.images}$image"),
            ),
            // Positioned(
            //   bottom: -4,
            //   right: 2,
            //   child: CircleAvatar(
            //     radius: 16,
            //     backgroundColor: AppColor.white,
            //   ),
            // ),
            // Positioned(
            //   bottom: -3,
            //   right: 3,
            //   child: CircleAvatar(
            //     radius: 15,
            //     backgroundColor: AppColor.primaryColor,
            //     child: IconButton(
            //         onPressed:onPressed,
            //         iconSize: 16,
            //         icon: Icon(
            //           Icons.camera_alt,
            //           color: AppColor.blue,
            //         )),
            //   ),
            // ),
        
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 5,
        ),
        defaultHeadTitle(title: "${model.firstName} ${model.lastName}"),
        defaultSmaleTitle(title: "${model.username}")
      ],
    ),
  );
}
Widget CustomListTile(
    {required String title,
    required IconData leading,
    Color? backgroundColor,
    void Function()? onTap,
    Color? textColor,
    Color? leadingColor,
    }) {
  return ListTile(
    onTap: onTap,
    leading:CircleAvatar(
        radius: 20,
        backgroundColor: backgroundColor==null? AppColor.thirdColor:backgroundColor,
        child: Icon(
          leading,
          color:leadingColor==null? AppColor.primaryColor:leadingColor,
        )),
    title: defaultBodyTitle(title: title ,color:textColor ),
   
  );
}
