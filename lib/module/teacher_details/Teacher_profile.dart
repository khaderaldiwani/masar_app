import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/teacher_details/cubit/Teacher_profile_cubit.dart';
import 'package:masar/module/teacher_details/cubit/Teacher_profile_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/components/teacher_profile_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';

class TeacherProfile extends StatelessWidget {
  const TeacherProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final String teacherID = ModalRoute.of(context)!.settings.arguments as String;

    return BlocProvider(
      create: (context) => TeacherProfileCubit(teacherID:teacherID)..init(),
      child: BlocConsumer<TeacherProfileCubit, TeacherProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          TeacherProfileCubit cubit =TeacherProfileCubit.get(context);
          return Scaffold(
            floatingActionButton: Container(
              margin: EdgeInsets.only(top: 10),
              height: 40,
              width: 40,
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back, color: AppColor.blue),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
            body: HandlingDataRequst(
              statusRequest: cubit.statusRequestProfile,
              widget: SafeArea(
                  child: ListView(children: [
                SizedBox(height: 60),
                buildProfilItem(model: cubit.teacherProfile),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                        child: buildTitleSubTitle(title: "${cubit.teacherProfile.coursesCount}", subTitle: "دورة")),
                    customVerticalDivider(),
                    Expanded(
                        child: buildTitleSubTitle(
                            title: "${cubit.teacherProfile.studentsCount}", subTitle: "طالب")),
                    customVerticalDivider(),
                    Expanded(
                        child: buildTitleSubTitle(
                            title: "${cubit.teacherProfile.feedbacksCount}", subTitle: "مراجعة")),
                  ],
                ),
                SizedBox(height: 20,),
                customDivider(color: AppColor.grey),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 15),
                  child: SizedBox(
                    
                      height: 40,
                      child: ListView.separated(
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
                              },
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 0),
                        itemCount: cubit.tabs.length,
                      )),
                ),
              
                SizedBox(
                  height: 15,
                ),
              
                   cubit.pagestabs[cubit.currentIndexTap]
              ])),
            ),
          );
        },
      ),
    );
  }
}
