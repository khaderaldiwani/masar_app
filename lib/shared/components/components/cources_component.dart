import 'package:flutter/material.dart';
import 'package:masar/module/courses/cubit/courses_cubit.dart';
import 'package:masar/module/home/cubit/home_cubit.dart';
import 'package:masar/shared/components/constant/app_color.dart';

Widget customTab(
    {required void Function()? onTap,
    required CoursesCubit cubit,
    required int index,
    required double widthTab}) {
  return InkWell(
    onTap: onTap,
    child: Container(
        clipBehavior: Clip.none,
        padding: EdgeInsets.only(left: widthTab, right: widthTab, bottom: 0),
        decoration: BoxDecoration(
        color:cubit.currentIndexTap == index?AppColor.secaodColor:AppColor.white ,
            
              border:cubit.currentIndexTap == index?
               Border.all(    
                    width: 4,
                    color: AppColor.secaodColor,
                  ):Border.all(    
                    width: 2,
                    color: AppColor.grey,
                  ),

                  borderRadius: BorderRadius.circular(20),
                  
                
                  ),
        child: Text(
          categoriesGeneral[index].name!,
          style: TextStyle(
              color: index == cubit.currentIndexTap
                  ? AppColor.white
                  : AppColor.grey,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        )),
  );
}
