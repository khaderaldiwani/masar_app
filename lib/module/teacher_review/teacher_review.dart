import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/teacher_details/cubit/Teacher_profile_cubit.dart';
import 'package:masar/module/teacher_details/cubit/Teacher_profile_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/components/teacher_profile_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';

class TeacherReview extends StatelessWidget {
  const TeacherReview({super.key});

  @override
  Widget build(BuildContext context) {
     TeacherProfileCubit cubit=TeacherProfileCubit.get(context);
     cubit.getFeedBack();
    return BlocBuilder<TeacherProfileCubit, TeacherProfileState>(
      builder: (context, state) {
        return HandlingDataRequst(
          statusRequest: cubit.statusRequest,
          textNodata: "لا يوجد مراجعات",
          widget: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      size: 35,
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    defaultHeadTitle(title: " ${cubit.average} (${cubit.count} reviews)"),
                    // Spacer(),
                    // InkWell(
                    //   child: Text(
                    //     "Add Review",
                    //     textAlign: TextAlign.end,
                    //     style: TextStyle(color: AppColor.secaodColor, fontSize: 16),
                    //   ),
                    //   onTap: () {
                    //     // showDialog(
                    //     //   // context: context,
                    //     //   // barrierDismissible:
                    //     //   //     true,
                    //     //   // builder: (context) => Rating()              
                    //     // );
                    //   },
                    // )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return buildCardReview(model:cubit.listFeedBack[index] );
                    },
                    separatorBuilder: (context, index) {
                      return customDivider();
                    },
                    itemCount: cubit.listFeedBack.length),
              ],
            ),
          ),
        );
      },
    );
  
  }
}