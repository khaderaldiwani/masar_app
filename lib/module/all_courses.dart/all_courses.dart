// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:masar/module/all_courses.dart/cubit/all_courses_cubit.dart';
// import 'package:masar/module/all_courses.dart/cubit/all_courses_state.dart';
// import 'package:masar/shared/class/handling_data_requst.dart';
// import 'package:masar/shared/components/components/home_components.dart';
// import 'package:masar/shared/components/components/shared_component.dart';
// import 'package:masar/shared/components/constant/app_route.dart';

// class AllCourses extends StatelessWidget {
//   const AllCourses({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => AllCoursesCubit()..init(),
//       child: BlocConsumer<AllCoursesCubit, AllCoursesState>(
//         listener: (context, state) {
//         },
//         builder: (context, state) {
//           AllCoursesCubit cubit = AllCoursesCubit.get(context);
//           return Scaffold(
//             appBar: defaultAppbarWithAction(
//                 title: "كل الدورات",
//                 context: context,
//                 onSearch: () {
//                   Navigator.pushNamed(context, AppRoute.search);
//                 }),
//             body: HandlingDataRequst(
//               statusRequest: cubit.statusRequest,
//               textNodata: "لا يوجد دورات حالياً",
//               widget: Container(
//                 padding: const EdgeInsets.all(10),
//                 child: AnimationLimiter(
                  
//                   child: ListView(
//                     children: 
//                  AnimationConfiguration.toStaggeredList(
//                       duration: const Duration(seconds: 20),
//                       delay: const Duration(milliseconds: 100),
//                       childAnimationBuilder: (widget) => SlideAnimation(
//                         verticalOffset: 10,
//                         // verticalOffset: 100, // 👈 العناصر تأتي من أسفل الصفحة
//                         // curve: Curves.easeOutCubic,
//                         // child: widget,
//                         child: FadeInAnimation(
//                           child: widget,
//                         ),
                      
//                       ),
//                     children: [
//                       ListView.separated(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             return buildCourseDetails(
//                               context: context,
//                               model: cubit.courses[index],
//                             );
//                           },
//                           separatorBuilder: (context, index) =>
//                               const SizedBox(height: 1),
//                           itemCount: cubit.courses.length),
//                     ],
//                  )
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:masar/module/all_courses.dart/cubit/all_courses_cubit.dart';
import 'package:masar/module/all_courses.dart/cubit/all_courses_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/home_components.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_route.dart';

class AllCourses extends StatelessWidget {
  const AllCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllCoursesCubit()..init(),
      child: BlocConsumer<AllCoursesCubit, AllCoursesState>(
        listener: (context, state) {},
        builder: (context, state) {
          AllCoursesCubit cubit = AllCoursesCubit.get(context);
          return Scaffold(
            appBar: defaultAppbarWithAction(
              title: "كل الدورات",
              context: context,
              onSearch: () {
                Navigator.pushNamed(context, AppRoute.search);
              },
            ),
            body: HandlingDataRequst(
              statusRequest: cubit.statusRequest,
              textNodata: "لا يوجد دورات حالياً",
              widget: Container(
                padding: const EdgeInsets.all(10),
                child: AnimationLimiter(
                  child: ListView.separated(
                    itemCount: cubit.courses.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(seconds: 20),
                        delay:const Duration(milliseconds: 200) ,
                        child: SlideAnimation(
                          verticalOffset: 100, // 👈 العناصر تجي من أسفل
                          curve: Curves.easeOutCubic,
                          child: FadeInAnimation(
                            child: buildCourseDetails(
                              context: context,
                              model: cubit.courses[index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
