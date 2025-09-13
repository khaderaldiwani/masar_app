import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/course_details/cubit/course_details_cubit.dart';
import 'package:masar/module/course_details/cubit/course_details_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/course_details_registered_component.dart';

class Marks extends StatelessWidget {
  const Marks({super.key});

  @override
  Widget build(BuildContext context) {
    CourseDetailsCubit cubit = CourseDetailsCubit.get(context);

    return BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
      builder: (context, state) {
        return HandlingDataRequst(
          statusRequest: cubit.statusRequest,
          textNodata: "لا يوجد علامات",
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cubit.listAssessments.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return CardStudantMark(model:cubit.listAssessments[index]);
                },
              ),
            ],
          ),
        );
      },
    );
  }

}
