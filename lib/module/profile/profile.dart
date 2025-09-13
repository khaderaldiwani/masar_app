import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/profile/cubit/profile_cubit.dart';
import 'package:masar/module/profile/cubit/profile_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/home_components.dart';
import 'package:masar/shared/components/components/profile_component.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(title: "الملف الشخصي", context: context),
      body: BlocProvider(
        create: (context) => ProfileCubit()..init(),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            ProfileCubit cubit = ProfileCubit.get(context);

            return HandlingDataRequst(
              statusRequest: cubit.statusRequest,
              widget: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  buildProfilItem(
                      file: cubit.file,
                      onPressed: () async {},
                      model: cubit.studentProfile),
                  SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      // height: double.infinity,
                      //  padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        //     color: AppColor.white,
                      ),

                      child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: defaultBodyTitle(title: "التفاصيل"),
                          ),
                          CustomListTile(
                            title: "${cubit.studentProfile.educationLevel}",
                            onTap: () {},
                            leading: Icons.auto_stories,
                          ),
                          CustomListTile(
                              title: "عرض معلومات القسم \"حول\"",
                              onTap: () {
                                cubit.goToProfileDetails(
                                    context, cubit.studentProfile);
                              },
                              backgroundColor:
                                  const Color.fromARGB(0, 255, 255, 255),
                              leading: Icons.more_horiz,
                              leadingColor: AppColor.greyapp,
                              textColor: AppColor.greyapp),
                          customDivider(
                              color: AppColor.primaryColor, padding: false),
                          Center(
                              child: defaultHeadTitle(
                                  title: "الكورسات المتابعة",
                                  color: AppColor.primaryColor)),
                          customDivider(
                              color: AppColor.primaryColor, padding: false),
                          SizedBox(height: 20),
                          HandlingDataRequst(
                            statusRequest: cubit.statusRequestCourses,
                            textNodata: "لا يوجد دورات متابعة",
                            widget: ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return buildCourseDetails(
                                   context: context,
                                  model: cubit.courses[index]
                                  );

                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 1),
                                itemCount: cubit.courses.length
                                ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
