import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/model/student_profile_model.dart';
import 'package:masar/module/profile/cubit/profile_cubit.dart';
import 'package:masar/module/profile/cubit/profile_state.dart';
import 'package:masar/shared/components/components/profile_component.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/function/function.dart';

class Profiledetails extends StatelessWidget {
  const Profiledetails({super.key});

  @override
  Widget build(BuildContext context) {
final StudentProfileModel model = ModalRoute.of(context)!.settings.arguments as StudentProfileModel;

    return Scaffold(
        appBar: defaultAppbar(title: "حول", context: context),
        body:
            //  BlocConsumer<ProfileCubit, ProfileState>(
            //   listener: (context, state) {},
            //   builder: (context, state) {
            //     ProfileCubit cubit = ProfileCubit.get(context);

            //     return
            //   },
            // ),
            Container(
      //color: AppColor.white,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: defaultHeadTitle(title: "التفاصيل"),
              ),
              CustomListTile(
                title: "${model.educationLevel}",
                onTap: () {
                 
                },
                leading: Icons.auto_stories,
              ),
              customDivider(),
              CustomListTile(
                title: "${model.phone}",
                onTap: () {
                 
                },
                leading: Icons.phone,
              ),
              customDivider(),
              CustomListTile(
                title:model.gender=="M"?"ذكر":"انثى",
                onTap: () {
                  
                },
                leading: Icons.person,
              ),
              customDivider(),
              CustomListTile(
                title: "${formatDate(model.birthDate!)}",
                onTap: () {
                 
                },
                leading: Icons.cake
                
                ,
              ),
            ],
          ),
        ));
  }
}
