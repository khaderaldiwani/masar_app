import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/course_details_registered/cubit/course_details_registered_cubit.dart';
import 'package:masar/module/course_details_registered/cubit/course_details_registered_state.dart';
import 'package:masar/shared/components/components/course_details_registered_component.dart';
import 'package:masar/shared/components/components/shared_component.dart';

class CourseDetailsRegistered extends StatelessWidget {
  const CourseDetailsRegistered({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseDetailsRegisteredCubit()..init(),
      child: BlocConsumer<CourseDetailsRegisteredCubit,
          CourseDetailsRegisteredState>(
        listener: (context, state) {},
        builder: (context, state) {
          CourseDetailsRegisteredCubit cubit =
              CourseDetailsRegisteredCubit.get(context);

          return Scaffold(
            appBar: defaultAppbar(title: "دورة تصميم تجربة المستخدم للمبتدئين", context: context),
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 40,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            controller: cubit.scrollController,
                            itemBuilder: (context, index) {
                              return Container(
                                key: cubit.tabKeys[index], // مفتاح لكل عنصر
                                child: customTab(
                                  widthTab: 15,
                                  cubit: cubit,
                                  index: index,
                                  onTap: () {
                                    cubit.changeCurrentIndexTap(index);
                                  },
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 0),
                            itemCount: cubit.tabs.length,
                          )
           ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(children: [
                       cubit.pagestabs[cubit.currentIndexTap]
                    
                  ],),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
