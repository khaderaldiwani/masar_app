import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masar/link_api.dart';
import 'package:masar/module/setting/cubit/setting_cubit.dart';
import 'package:masar/module/setting/setting.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_images.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import 'package:masar/shared/network/remote/status_requst.dart';

Widget buildProfilItem({required XFile? file,required void Function()? onPressed,required SettingCubit cubit}) {

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
              backgroundColor: AppColor.greyButton,
              backgroundImage:image=="" ?AssetImage(AppImages.person):NetworkImage("${LinkApi.images}$image"),
              //NetworkImage(image==""? AppImages.person:"${LinkApi.images}$image"),
            ),
            Positioned(
              bottom: -4,
              right: 2,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: AppColor.white,
              ),
            ),
            Positioned(
              bottom: -3,
              right: 3,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: AppColor.primaryColor,
                child: IconButton(
                    onPressed:onPressed,
                    iconSize: 16,
                    icon: Icon(
                      Icons.camera_alt,
                      color: AppColor.white,
                    )),
              ),
            ),
                if(cubit.statusRequestImage==StatusRequest.loading)Positioned(
                  top: 10,
                  bottom: 10,
                  right: 40,
                  child: Center(child:CircularProgressIndicator() ,)
                  )
          
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 5,
        ),
        defaultHeadTitle(title: "${cubit.first_name} ${cubit.last_name}"),
        defaultSmaleTitle(title: "${cubit.phone}")
      ],
    ),
  );
}

Widget CustomListTile(
    {required String title,
    required IconData leading,
    required IconData trailing,
    void Function()? onTap,
    Color? textColor,
    Color? leadingColor,
    }) {
  return ListTile(
    onTap: onTap,
    leading:CircleAvatar(
        radius: 20,
        backgroundColor: AppColor.thirdColor,
        child: Icon(
          leading,
          color:leadingColor==null? AppColor.primaryColor:leadingColor,
        )),
    title: defaultBodyTitle(title: title ,color:textColor ),
    trailing: Icon(
      trailing,
      color: AppColor.primaryColor,
    ),
  );
}

Widget CustomListTileSwitch(
    {required String title,
    required IconData leading,
    required Widget? trailing,
    void Function()? onTap,
    Color? textColor,
    Color? leadingColor,
    }) {
  return ListTile(
    onTap: onTap,
    leading:CircleAvatar(
        radius: 20,
        backgroundColor: AppColor.thirdColor,
        child: Icon(
          leading,
          color:leadingColor==null? AppColor.primaryColor:leadingColor,
        )),
    title: defaultBodyTitle(title: title ,color:textColor ),
    trailing:  trailing
  );
}

// Widget customDivider() {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 15),
//     child: Divider(color: AppColor.scaffoldColor, thickness: 2),
//   );
// }
Widget buildDialog({required void Function()? onTapFirst,required void Function()? onTapSecond}){
  return  Column(
                      children: [
                        Text('Make a choice',style: TextStyle(color: AppColor.black,fontSize: 20,fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: onTapFirst,
                            
                          child: Row(children: [
                            SizedBox(width: 10,),
                            Icon(Icons.photo,color: AppColor.secaodColor),
                            Text(" Gallery" ,style: TextStyle(color: AppColor.blue,fontSize: 19),)
                          ],),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: onTapSecond,
                          
                          child: Row(children: [
                            SizedBox(width: 10,),
                            Icon(Icons.camera,color: AppColor.secaodColor),
                            Text(" Camera" ,style: TextStyle(color: AppColor.blue,fontSize: 19),)
                          ],),
                        ),
                        SizedBox(height: 20),
                      ],
                     );
}
Widget buildDialogLogout({required void Function()? onTapFirst,required void Function()? onTapSecond}){
  return  Column(
                      children: [
                        Text( "هل تريد تسجيل الخروج؟",style: TextStyle(color: AppColor.black,fontSize: 20,fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: onTapFirst,
                              child:Container(
                                padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                                margin:EdgeInsets.all(5) ,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(child: Text("تسجيل الخروج" ,style: TextStyle(color: AppColor.white,fontSize: 19),))),
                            ),
                            InkWell(
                              onTap: onTapSecond,
                              child:Container(
                                padding: EdgeInsets.symmetric(vertical: 3,horizontal: 30),
                                margin:EdgeInsets.all(5) ,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(child: Text("إلغاء" ,style: TextStyle(color: Colors.red,fontSize: 19),))),
                            )
                          ],
                        ),
                        
                      ],
                     );
}
