import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masar/link_api.dart';
import 'package:masar/model/courses_upcoming_model.dart';
import 'package:masar/model/feedback_model.dart';
import 'package:masar/model/teacher_profile_model.dart';
import 'package:masar/module/teacher_details/cubit/Teacher_profile_cubit.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_images.dart';
import 'package:masar/shared/function/expanded_text.dart';
import 'package:masar/shared/function/function.dart';

Widget buildProfilItem({required TeacherProfileModel model}) {
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
              backgroundImage:model.image==null? AssetImage(AppImages.person)
              :NetworkImage(LinkApi.images+model.image!),
            ),
            
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 5,
        ),
        defaultHeadTitle(title: "${model.firstName} ${model.lastName}"),
        SizedBox(height: 5),
        defaultSmaleTitle(title:"${model.headline}",color: AppColor.greyapp)
      ],
    ),
  );
}
Widget buildTitleSubTitle({required String title,required String subTitle,}){
  return Column(
                  children: [
                    defaultHeadTitle(title: title),
                    SizedBox(height: 5),
                    defaultBodyTitle(title: subTitle,color: AppColor.greyapp)
                  ],
                );
}
Widget customVerticalDivider(){
  return  Container(height: 60,width: 2,color:AppColor.primaryColor,);
               
}
Widget customTab(
    {required void Function()? onTap,
    required TeacherProfileCubit cubit,
    required int index,
    required double widthTab}) {
  return InkWell(
    onTap: onTap,
    child: Container(
        clipBehavior: Clip.none,
        padding: EdgeInsets.only(left: widthTab, right: widthTab, bottom: 0),
        //   padding: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
            border: cubit.currentIndexTap == index
                ? BorderDirectional(
                    bottom: BorderSide(
                    width: 4,
                    color: AppColor.secaodColor,
                  ))
                : BorderDirectional(
                    bottom: BorderSide(
                    width: 2,
                    color: AppColor.grey,
                  ))),
        child: Text(
          cubit.tabs[index],
          style: TextStyle(
              color: index == cubit.currentIndexTap
                  ? AppColor.secaodColor
                  : AppColor.grey,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        )),
  );
}

Widget buildCardReview({required FeedBackModel model}){
  
  return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
    
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsetsDirectional.only(top: 10),
          height: 50,
          width: 50,
          decoration:  BoxDecoration(
           //   border: Border.symmetric(horizontal: BorderSide(color: AppColor.primaryColor ,width: 5),vertical: BorderSide(color: AppColor.primaryColor)),
              shape: BoxShape.circle,
              image: DecorationImage(
                  image:model.student!.image==null? 
                  AssetImage(AppImages.person)
                  :  NetworkImage(LinkApi.images+model.student!.image!)
                
                  ,
                   fit: BoxFit.fill)
                  ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             // SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${model.student!.firstName} ${model.student!.lastName}",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: AppColor.blue),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Container(
                  //  alignment: Alignment.topRight,
                    padding: EdgeInsets.symmetric(horizontal: 10 ,vertical: 5),
                    decoration: BoxDecoration(
  
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColor.secaodColor,width: 2),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star,color: AppColor.secaodColor,size: 20,),
                        SizedBox(width: 5,),
                        defaultSmaleTitle(title: "${model.rating}",color: AppColor.secaodColor)
  
                      ],
                    ),
                  )
                ],
              ),
  
                        ],
          ),
        ),
        
        const SizedBox(
          width: 5,
        )
      ],
    
    ),
    SizedBox(height: 10,),
        
         buildExpandableText("${model.body}",maxChars:100 , style: TextStyle(fontSize: 16, color: AppColor.black),),
         SizedBox(height: 10,),
         defaultSmaleTitle(title: formatDate("${model.feedbackedAt}")),            
        
    
  ],
      );


}
Widget ExpandableText(
    {required String text,
    TextStyle? style,
    int maxChars = 200,
    required TeacherProfileCubit cubit,
    
    }) {
  final showFullText = cubit.expanded || text.length <= maxChars;

  final visibleText =
      showFullText ? text : text.substring(0, maxChars) + '... ';

  return RichText(
    text: TextSpan(
      // style: TextStyle(color: Colors.black, fontSize: 16),
      children: [
        TextSpan(
          text: visibleText,
          style:style==null? TextStyle(
              fontSize: 16,
              color: AppColor.greyapp,
              fontWeight: FontWeight.bold):style,
        ),
        if (text.length > maxChars)
          TextSpan(
            text: cubit.expanded ? ' عرض الأقل ' : ' عرض المزيد',
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {
                cubit.showText();
              },
          ),
      ],
    ),
  );
}
