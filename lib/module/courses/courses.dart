import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:masar/module/courses/cubit/courses_cubit.dart';
import 'package:masar/module/courses/cubit/courses_state.dart';
import 'package:masar/module/home/cubit/home_cubit.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/cources_component.dart';
import 'package:masar/shared/components/components/home_components.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_route.dart';

class Courses extends StatelessWidget {
  const Courses({super.key});

  @override
  Widget build(BuildContext context) {
    final int value = ModalRoute.of(context)!.settings.arguments as int;

    return BlocProvider(
      create: (context) => CoursesCubit(initialValue: value),
      child: BlocConsumer<CoursesCubit, CoursesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        
        builder: (context, state) {
          CoursesCubit cubit=CoursesCubit.get(context);
    
          return Scaffold(
            appBar: defaultAppbar(title: "دورات", context: context),
            body: ListView(
              children: [
                SizedBox(height: 20,),
                Padding(
                padding: const EdgeInsetsDirectional.only(start: 15),
                
                child: SizedBox( 
                    height: 40,
                    child: ListView(
                        clipBehavior: Clip.none,
                         scrollDirection: Axis.horizontal,
                      children: [
                        // customTab(
                        //         widthTab: 35 ,
                        //         cubit: cubit,
                        //         index: 0,
                        //         onTap: () {
                        //        //   cubit.changeCurrentIndexTap(index);
                        //         },
                        //       ),
                        ListView.separated(
                           shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                          clipBehavior: Clip.none,
                          scrollDirection: Axis.horizontal,
                          controller: cubit.scrollController,
                          itemBuilder: (context, index) {
                            return Container(
                              key: cubit.tabKeys[index], // مفتاح لكل عنصر
                              child: customTab(
                                widthTab: 35 ,
                                cubit: cubit,
                                index: index,
                                onTap: () {
                                  cubit.changeCurrentIndexTap(index);
                                  cubit.getData(categoriesGeneral[index].id!);
                                },
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 10),
                          itemCount: categoriesGeneral.length,
                        ),
                      ],
                    )
                    ),

              ),
              const SizedBox(height: 20),
              HandlingDataRequst(
                textNodata: "لا يوجد دورات في هذا القسم حالياً",
                statusRequest:cubit.statusRequest,
               widget: 
                AnimationLimiter(
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
                              child: buildCourseDetails(
                      context: context,
                      model: cubit.courses[index],
                    
                    )
                            ),
                          ),
                        );
                      
                  },
                   separatorBuilder: (context, index) =>SizedBox(height: 1) ,
                   itemCount:cubit.courses.length
                   ),
                ),
                
               )

              ],
            ),
          );
        },
      ),
    );
  }
}
