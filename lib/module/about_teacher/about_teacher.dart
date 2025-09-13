import 'package:flutter/material.dart';
import 'package:masar/model/teacher_profile_model.dart';
import 'package:masar/module/teacher_details/cubit/Teacher_profile_cubit.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';

class AboutTeacher extends StatelessWidget {
  const AboutTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    TeacherProfileCubit cubit=TeacherProfileCubit.get(context);
    TeacherProfileModel model =cubit.teacherProfile;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: defaultHeadTitle(
              maxline: 30,
              title:"${model.experiences}", 
              color: AppColor.greyapp,
              textAlign: TextAlign.center

              ),
          ),
            SizedBox(height: 30),
          defaultBodyTitle(
            maxLine: 60,
            title: "${model.description}",
            color: AppColor.black),
        ],
      ),
    );
  }
}