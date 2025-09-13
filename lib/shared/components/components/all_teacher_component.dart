import 'package:flutter/material.dart';
import 'package:masar/model/all_teacher_model.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_images.dart';

Widget buildTeacherCard({
  required AllTeacherModel model,
  required void Function()? onProfileTap,
}) {
  return InkWell(
    onTap:onProfileTap ,
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          // صورة الأستاذ دائرية
          CircleAvatar(
            radius: 30,
            backgroundImage: model.image !=null
                ? NetworkImage(model.image!)
                : const AssetImage(AppImages.person)
                    as ImageProvider,
          ),
    
          const SizedBox(width: 12),
    
          // الاسم + الهيدلاين
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               defaultBodyTitle(title: "${model.firstName} ${model.lastName}"),
                const SizedBox(height: 4),
               defaultSmaleTitle(title: "${model.headline}",color: AppColor.greyapp,bold: true),
                
              ],
            ),
          ),
    
          Icon(
           Icons.more_horiz_outlined, color: Colors.blue,
          ),
        ],
      ),
    ),
  );
}