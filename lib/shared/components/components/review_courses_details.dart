import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/link_api.dart';
import 'package:masar/model/feedback_model.dart';
import 'package:masar/module/Poll_&%20_Review/poll_%20&_review.dart';
import 'package:masar/module/course_details/cubit/course_details_cubit.dart';
import 'package:masar/module/course_details/cubit/course_details_state.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_images.dart';
import 'package:masar/shared/function/expanded_text.dart';

Widget buildCardReview({required CourseDetailsCubit cubit,required FeedBackModel model}){
  String text1="تيسبتسنبت سىبنستنمب سمبنمس تسينمبنتسينم نسيمبنسمك خسيبنخسية سيبختسن سخيبخبة مستبنمسب ستيبمنت تسيمنبت ت تيبمنت تيسبمنت تيسمنب ت تيبمنت تيسبمنت تيسمنب ت تيبمنت تيسبمنت تيسمنب تيبمنت ت تيبمنت تيسبمنت تيسمنب ت تيبمنت تيسبمنت تيسمنب ت تيبمنت تيسبمنت تيسمنب تيسبمنت تيسمنب تنيتبم";
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
                  image:model.student!.image==null? AssetImage(AppImages.person):NetworkImage(LinkApi.images+model.student!.image!), fit: BoxFit.fill)
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
        buildExpandableText("${model.body}", maxChars: 120,style: TextStyle(fontSize: 16, color: AppColor.black),),
         SizedBox(height: 10,),
         defaultSmaleTitle(title: "${model.feedbackedAt}"),            
        
        
    
  ],
      );


}
