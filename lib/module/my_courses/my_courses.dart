import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:masar/module/my_courses/cubit/my_courses_cubit.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/my_courses_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_route.dart';
import '../../shared/components/components/shared_component.dart';
import 'cubit/my_courses_state.dart';

class MyCourses extends StatelessWidget {
  const MyCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyCoursesCubit()..getCoursesOngoing(),
      child: BlocConsumer<MyCoursesCubit, MyCoursesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          MyCoursesCubit cubit = MyCoursesCubit.get(context);
          return Container(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Expanded(
                          child: defaultButton(
                        title: "قيد التقدم",
                        isActiv: cubit.isOngoing,
                        onTap: () {
                          cubit.changeOngoing(true);
                          cubit.getCoursesOngoing();
                        },
                      )),
                      Expanded(
                          child: defaultButton(
                        title: "مكتمل",
                        isActiv: !cubit.isOngoing,
                        onTap: () {
                          cubit.changeOngoing(false);
                          cubit.getCoursesCompleted();
                        },
                      ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ///////////////////
                cubit.isOngoing
                    ? HandlingDataRequst(
                        statusRequest: cubit.statusRequestOngoing,
                        textNodata: "لا يوجد كورسات قيد التقدم",
                        widget: AnimationLimiter(
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return  AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(seconds: 20),
                        delay:const Duration(milliseconds: 200) ,
                        child: SlideAnimation(
                          verticalOffset: 100, // 👈 العناصر تجي من أسفل
                          curve: Curves.easeOutCubic,
                          child: FadeInAnimation(
                            child: buildCourseOngoingItem(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AppRoute.courseDetails,
                                          arguments: {
                                            "courseID":
                                                "${cubit.listCoursesOngoing[index].id}",
                                            "is_enrolled": true,
                                          });
                                    },
                                    model: cubit.listCoursesOngoing[index])
                          ),
                        ),
                      ); 
                                
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 1),
                              itemCount: cubit.listCoursesOngoing.length),
                        ),
                      )
                    :
                    ////////////////////
                    HandlingDataRequst(
                        statusRequest: cubit.statusRequestCompleted,
                        textNodata: "لا يوجد كورسات مكتملة",
                        widget: AnimationLimiter(
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(seconds: 20),
                        delay:const Duration(milliseconds: 200) ,
                        child: SlideAnimation(
                          verticalOffset: 100, // 👈 العناصر تجي من أسفل
                          curve: Curves.easeOutCubic,
                          child: FadeInAnimation(
                            child: buildCourseCompletedItem(
                                    model:
                                        cubit.listCoursesCompleted[index],
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AppRoute.courseDetails,
                                          arguments: {
                                            "courseID":
                                                "${cubit.listCoursesOngoing[index].id}",
                                            "is_enrolled": true,
                                          });
                                    })
                          ),
                        ),
                      );
                                
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 1),
                              itemCount: cubit.listCoursesCompleted.length),
                        ))
              ],
            ),
          );
        },
      ),
    );
  }
}
