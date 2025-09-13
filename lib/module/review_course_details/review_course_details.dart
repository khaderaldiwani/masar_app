import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/course_details/cubit/course_details_cubit.dart';
import 'package:masar/module/course_details/cubit/course_details_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/review_courses_details.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewCourseDetails extends StatelessWidget {
  const ReviewCourseDetails({super.key});
  Widget build(BuildContext context) {
    CourseDetailsCubit cubit = CourseDetailsCubit.get(context);
   // cubit.getReviewCourse();
    return BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
      builder: (context, state) {
        return BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  size: 35,
                  Icons.star,
                  color: Colors.yellow,
                ),
                defaultHeadTitle(title: " ${cubit.average}   (${cubit.count} مراجعات)"),
                
              ],
            ),
            SizedBox(
              height: 20,
            ),

            HandlingDataRequst(
              statusRequest: cubit.statusRequest,
              textNodata: "لا يوجد مراجعات حالياً",
              widget: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildCardReview(cubit:cubit,model:cubit.listReview[index]  );//
                  },
                  separatorBuilder: (context, index) {
                    return customDivider();
                  },
                  itemCount:cubit.listReview.length// 
                  ),
            ),
          ],
        );
      },
    ); 
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Center(child:Rating(
        //       onSubmitted: (response) {
        //         print(
        //             'rating: ${response.rating}, comment: ${response.comment}');
                  
        //       },
        //     ))
        //   ],
        // );
      
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return 
  //   BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
  //     builder: (context, state) {
  //     CourseDetailsCubit cubit=CourseDetailsCubit.get(context);
  //       return Column(
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               const Icon(
  //                 size: 35,
  //                 Icons.star,
  //                 color: Colors.yellow,
  //               ),
  //               defaultHeadTitle(title: " 4.5 (27 reviews)"),
  //               Spacer(),
  //               InkWell(
  //                 child: Text(
  //                   "Add Review",
  //                   textAlign: TextAlign.end,
  //                   style: TextStyle(color: AppColor.secaodColor, fontSize: 16),
  //                 ),
  //                 onTap: () {
  //                   // showDialog(
  //                   //   context: context,
  //                   //   barrierDismissible:
  //                   //       true,
                          
  //                   //   builder: (context) => Rating()              
  //                   // );
  //                 },
  //               )
  //             ],
  //           ),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           ListView.separated(
  //               shrinkWrap: true,
  //               physics: NeverScrollableScrollPhysics(),
  //               itemBuilder: (context, index) {
  //                 return Text("data");//buildCardReview(cubit:cubit );
  //               },
  //               separatorBuilder: (context, index) {
  //                 return customDivider();
  //               },
  //               itemCount: 5),
  //         ],
  //       );
  //     },
  //   );
  
  // }

}
