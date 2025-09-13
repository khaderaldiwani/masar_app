import 'package:flutter/material.dart';
import 'package:masar/link_api.dart';
import 'package:masar/model/course_details_model.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_images.dart';

Widget buildTeacherItemAbout({required CourseDetailsModel model,required void Function()? onTap}){
  Teacher teacher= model.teacher!;
  return InkWell(
    onTap:onTap,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsetsDirectional.only(top: 10),
          height: 70,
          width: 70,
          decoration:  BoxDecoration(
           //   border: Border.symmetric(horizontal: BorderSide(color: AppColor.primaryColor ,width: 5),vertical: BorderSide(color: AppColor.primaryColor)),
              shape: BoxShape.circle,
              image: DecorationImage(
                  image:teacher.image==null? AssetImage(AppImages.person)
                  :NetworkImage("${LinkApi.images}/${teacher.image}")
                  ,
                  
                   fit: BoxFit.fill)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Text(
            "${teacher.firstName} ${teacher.lastName}",
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppColor.blue),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(height: 4,),
              Text(
                    "${teacher.headline}",
                    style: TextStyle(fontSize: 16, color: AppColor.greyapp,fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
              
            SizedBox(height: 10,)
            ],
          ),
        ),
        const SizedBox(
          width: 5,
        )
      ],
    ),
  );


}