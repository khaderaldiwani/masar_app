import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/course_details/cubit/course_details_cubit.dart';
import 'package:masar/module/course_details/cubit/course_details_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/course_details_registered_component.dart';
class NotificationCourse extends StatelessWidget {
  const NotificationCourse({super.key});
  @override
  Widget build(BuildContext context) {
    
    CourseDetailsCubit cubit = CourseDetailsCubit.get(context);
    //cubit.initAnnouncements();
    return BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
     
      builder: (context, state) { 
        return HandlingDataRequst(
          statusRequest: cubit.statusRequest,
          textNodata: "لا يوجداعلامات",
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                  itemCount: cubit.listAnnouncements.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 5),
                  itemBuilder: (context, index) {
                    
                    return CustomCardNews(
                      context: context,
                     
                      index: index,
                      model:cubit.listAnnouncements[index]);
                 },
                ),
            // CustomCardNews(context: context,text: text2,index: 5 ),
          //  CustomCardNews(context: context,text: text),
          //   CustomCardNews(context: context,text: text2),
          //  CustomCardNews(context: context,text: text)
          
            ],
          ),
        );
      },
    );
  }
}
