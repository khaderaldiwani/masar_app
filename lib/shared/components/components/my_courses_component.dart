import 'package:flutter/material.dart';
import 'package:masar/link_api.dart';
import 'package:masar/model/courses_completed_model.dart';
import 'package:masar/model/courses_ongoing_model.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_images.dart';

Widget buildCourseOngoingItem({required void Function()? onTap,required CoursesOngoingModel model}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      color: AppColor.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 95,
            decoration:  BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(10),
                  bottomStart: Radius.circular(10),
                ),
                image: DecorationImage(
                    image: model.image==null? AssetImage(AppImages.logo)
                    :NetworkImage(LinkApi.images+model.image!)
                    ,
                     fit: BoxFit.fill)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model.name}",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColor.blue),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: 5,),
           
            // Row(
            //         children: [
            //           CircleAvatar(radius: 14,backgroundImage:model.teacher!.image==null? 
            //           AssetImage(AppImages.person)
            //           : NetworkImage(LinkApi.images+model.teacher!.image!)
          
                      
            //           ),
            //           SizedBox(width: 5,),
            //           Text("أ.${model.teacher!.firstName} ${model.teacher!.lastName}"),
            //         ],
            //       ),
            Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColor.greyButton,
                        backgroundImage:
                        model.teacher!.image != null?
                         NetworkImage(LinkApi.images+model.teacher!.image!):
                         AssetImage(AppImages.person),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      
                          defaultSmaleTitle(title: "أ.${model.teacher!.firstName} ${model.teacher!.lastName}")
                    ],
                  ),
                       
                  SizedBox(height: 5,),
                 
               buildProgresBar(completedLessons:(model.progressPercentage as num).toDouble() ,
                totalLessons: 100),
               Center(
                 child: Text('${model.progressPercentage}% مكتمل',
                 
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 14,
                           color: AppColor.black
                         ),
                       ),
               ),
              ],
            ),
          ),
          const SizedBox(
            width: 5,
          )
        ],
      ),
    ),
  );
}

Widget buildCourseCompletedItem({required CoursesCompletedModel model,required void Function()? onTap}) {
  return InkWell(
    onTap:onTap ,
    child: Card(
      color: AppColor.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 95,
            decoration:  BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(10),
                  bottomStart: Radius.circular(10),
                ),
                image: DecorationImage(
                   
                    image: model.image ==null? AssetImage(AppImages.logo)
                    :NetworkImage(LinkApi.images+model.image!)
                    )),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model.name}",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColor.blue),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                     SizedBox(height: 5,),
          
              // Row(
              //         children: [
              //           CircleAvatar(radius: 14,backgroundImage:model.teacher!.image==null? 
              //           AssetImage(AppImages.teacher)
              //           : NetworkImage(LinkApi.images+model.teacher!.image!)
            
                        
              //           ),
              //           SizedBox(width: 5,),
              //           Text("أ.${model.teacher!.firstName} ${model.teacher!.lastName}"),
              //         ],
              //       ),
          
             Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColor.greyButton,
                        backgroundImage:
                        model.teacher!.image != null?
                         NetworkImage(LinkApi.images+model.teacher!.image!):
                         AssetImage(AppImages.person),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      
                          defaultSmaleTitle(title: "أ.${model.teacher!.firstName} ${model.teacher!.lastName}")
                    ],
                  ),
                 
               SizedBox(height: 5,),
              
                 Text('تاريخ الانتهاء: "${model.endDate}"',
                 
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 14,
                           color: AppColor.black
                         ),
                       ),
                
                //buildProgresBar(completedLessons: 11, totalLessons: 22)
              ],
            ),
          ),
          const SizedBox(
            width: 5,
          )
        ],
      ),
    ),
  );
}
