import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/course_details/cubit/course_details_cubit.dart';
import 'package:masar/module/course_details/cubit/course_details_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/receipts_component.dart';
import 'package:masar/shared/components/constant/app_route.dart';

class ReceiptsCourse extends StatelessWidget {
  const ReceiptsCourse({super.key});

  @override
  Widget build(BuildContext context) {
    CourseDetailsCubit cubit=CourseDetailsCubit.get(context);
    return BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
      builder: (context, state) {
        return HandlingDataRequst(
          statusRequest: cubit.statusRequest,
          textNodata: "لا يوجد ايصالات",
          widget: 
        Column(
          children: [
            ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildReceiptsPaymentItem(
                      //    status: "paymented",
                      model: cubit.listReceiptsCourse[index],
                      onTab: () {
                    Navigator.pushNamed(context, AppRoute.eReceipt,
                        arguments: {'id':"${cubit.listReceiptsCourse[index].id}" });
                  });
                },
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemCount: cubit.listReceiptsCourse.length)
          ],
        )
      );
      },
    );
  }
}
