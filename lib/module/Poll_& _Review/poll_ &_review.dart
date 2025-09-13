import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:masar/module/course_details/cubit/course_details_cubit.dart';
import 'package:masar/module/course_details/cubit/course_details_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/review_courses_details.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_lottie.dart';
import 'package:masar/shared/network/remote/status_requst.dart';

class PollAndReview extends StatelessWidget {
  const PollAndReview({super.key});

  @override
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
                Spacer(),

              //  cubit.statusRequestCreateReview==StatusRequest.loading?
              //  SizedBox(
              //   height: 40,
              //   width: 120,
                
              //   child: Lottie.asset(AppLottie.loadingSec,width: 200,height: 200))
              //   :
                handlingLoading(
                  statusRequest: cubit.statusRequestCreateReview,
                 widget:   InkWell(
                  child: Text(
                    "اضافة تقييم",
                    textAlign: TextAlign.end,
                    style: TextStyle(color: AppColor.secaodColor, fontSize: 16),
                  ),
                  onTap: () {
                  
             if(!cubit.courseDetails.isFinished!)
             {
                 AwesomeDialog(
                  context: context,
                  headerAnimationLoop: true,
                  dialogType: DialogType.warning,
                  width: 350,
                  animType: AnimType.bottomSlide,
                  dialogBackgroundColor: AppColor.white,
                  showCloseIcon: true,
                  title: "تحذير",
                  desc: "لا يمكنك القيام بالتقييم قبل انتهاء الكورس ",
                  titleTextStyle:   
                       TextStyle(color: AppColor.primaryColor,fontSize: 18,fontWeight: FontWeight.bold),          
                  descTextStyle: TextStyle(color: AppColor.black,fontSize: 16,)
                  ).show();
               
              return;
             }

             int result=0;     
                    showDialog(
                      context: context,
                      barrierDismissible:
                          true,
                          
                      builder: (contextA) => Rating(
                        onSubmitted: (response)async {
              //   print(
              //       'rating: ${response.rating.toInt()}, comment: ${response.comment}');
               result= await  cubit.createReview("${response.comment}", "${response.rating.toInt()}");
              if (result==1 ) {
                  AwesomeDialog(
                    titleTextStyle:   
                       TextStyle(color: AppColor.primaryColor,fontSize: 18,fontWeight: FontWeight.bold),          
                  descTextStyle: TextStyle(color: AppColor.black,fontSize: 16,),
                  context: context,
                  headerAnimationLoop: true,
                  dialogType: DialogType.warning,
                  width: 350,
                  animType: AnimType.bottomSlide,
                  dialogBackgroundColor: AppColor.thirdColor,
                  showCloseIcon: true,
                  title: "تحذير",
                  desc: "لا يمكنك التقييم بدون كتابة مراجعة "
                  
                  ).show();
               
                }
                    if (result==2 ) {
                  AwesomeDialog(
                    titleTextStyle:   
                       TextStyle(color: AppColor.primaryColor,fontSize: 18,fontWeight: FontWeight.bold),          
                  descTextStyle: TextStyle(color: AppColor.black,fontSize: 16,),
                  context: context,
                  headerAnimationLoop: true,
                  dialogType: DialogType.warning,
                  width: 350,
                  animType: AnimType.bottomSlide,
                  dialogBackgroundColor: AppColor.thirdColor,
                  showCloseIcon: true,
                  title: "تحذير",
                  desc: "لم تمم عملية التقيمم قد تكون قمت بعملية التقييم سابقاً"
                  
                  ).show();
                }
              
              },)              
               );
                  },
                )
              
                 )
              
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

}


