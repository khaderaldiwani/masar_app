import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/all_teachers/cubit/all_teachers_cubit.dart';
import 'package:masar/module/all_teachers/cubit/all_teachers_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/all_teacher_component.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_route.dart';

class AllTeachers extends StatelessWidget {
  const AllTeachers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(title: "كل المدرسين", context: context),
      body: BlocProvider(
        create: (context) => AllTeachersCubit()..getData(),
        child: BlocBuilder<AllTeachersCubit, AllTeachersState>(
          builder: (context, state) {
        AllTeachersCubit cubit=AllTeachersCubit.get(context);
   
            return HandlingDataRequst(
              statusRequest:cubit.statusRequest ,
              textNodata: "لا يوجد مدرسين",
              widget: ListView(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => 
                      buildTeacherCard(
                        
                          onProfileTap: () {
                            Navigator.pushNamed(context, AppRoute.TeacherProfile,arguments: "${cubit.listTeacher[index].id}");
    
                          },
                          model:cubit.listTeacher[index]
                          ),
                      separatorBuilder: (context, index) => customDivider(),
                      itemCount: cubit.listTeacher.length)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
