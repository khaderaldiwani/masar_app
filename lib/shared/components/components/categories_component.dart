import 'package:flutter/material.dart';
import 'package:masar/link_api.dart';
import 'package:masar/model/categories_model.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_images.dart';

Widget buildCategoriesSearchItem({
  required void Function()? onTap,
  required CategoriesModel model}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 80,
      //  width: 150,
      // margin: EdgeInsetsDirectional.only(end:10,bottom: 10 ),
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        //   mainAxisSize: MainAxisSize.max,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image:model.image !=null ? NetworkImage("${LinkApi.images}${model.image}") :AssetImage(AppImages.logo),
                    
                     fit: BoxFit.fill
                    )
                    ),
          ),
          Container(
            width: double.infinity,
            height: 40, // ارتفاع الزر
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.9),
                  const Color.fromARGB(160, 0, 0, 0),
                  const Color.fromARGB(90, 0, 0, 0),
                  const Color.fromARGB(40, 0, 0, 0),
                  const Color.fromARGB(0, 0, 0, 0),
                ],
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: defaultBodyTitle(
                    title: "${model.name}", color: Colors.white),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
