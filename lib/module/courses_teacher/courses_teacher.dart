import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/teacher_details/cubit/Teacher_profile_cubit.dart';
import 'package:masar/module/teacher_details/cubit/Teacher_profile_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/home_components.dart';
import 'package:masar/shared/components/constant/app_route.dart';

class CoursesTeacher extends StatelessWidget {
  const CoursesTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    TeacherProfileCubit cubit = TeacherProfileCubit.get(context);
    cubit.getCourses();
    return BlocBuilder<TeacherProfileCubit, TeacherProfileState>(
      builder: (context, state) {
        return HandlingDataRequst(
          statusRequest: cubit.statusRequest,
          textNodata: "لا يوجد دورات ",
          widget: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return buildCourseDetails(
                 context: context,
                  model:cubit.courses[index] 
          
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 1),
              itemCount: cubit.courses.length //cubit.courses.length
              ),
        );
      },
    );
  }
}
