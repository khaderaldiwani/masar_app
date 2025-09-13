import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/model/course_details_model.dart';
import 'package:masar/module/course_details/cubit/course_details_cubit.dart';
import 'package:masar/module/course_details/cubit/course_details_state.dart';
import 'package:masar/shared/components/components/about_course_details_component.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_route.dart';

class AboutCourseDetails extends StatelessWidget {
  const AboutCourseDetails({super.key});

  @override
  Widget build(BuildContext context) {
    CourseDetailsCubit cubit = CourseDetailsCubit.get(context);
   CourseDetailsModel model= cubit.courseDetails;
    return BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
      builder: (context, state) {
        return Container(
          //  padding: ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              defaultHeadTitle(title: "المدرس"),
              buildTeacherItemAbout(
                model: model,
                onTap: (){
                  Navigator.pushNamed(context, AppRoute.TeacherProfile,arguments: "${model.teacher!.id}");
                }
                ),
              defaultHeadTitle(title: "حول الدورة"),

              ExpandableText(text:"${model.description}", cubit: cubit,),
              SizedBox(height: 20,)
            ],
          ),
        );
      },
    );
  }
}

