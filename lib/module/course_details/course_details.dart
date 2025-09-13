import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/model/course_details_model.dart';
import 'package:masar/module/course_details/cubit/course_details_cubit.dart';
import 'package:masar/module/course_details/cubit/course_details_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/course_details_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';

class CourseDetails extends StatelessWidget {
  const CourseDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final Map map =
        ModalRoute.of(context)!.settings.arguments as Map;
    return BlocProvider(
      create: (context) => CourseDetailsCubit(courceID:map['courseID'] ,isRedisteredval:map['is_enrolled']),
      child: BlocConsumer<CourseDetailsCubit, CourseDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          CourseDetailsCubit cubit = CourseDetailsCubit.get(context);
          CourseDetailsModel model= cubit.courseDetails;
          return Scaffold(
            floatingActionButton: Container(
              margin: const EdgeInsets.only(top: 10),
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
              statusRequest: cubit.statusRequestCourseDetails,
              widget: Column(
                children: [
                  Expanded(
                    child: ListView(
                      controller:cubit.scrollControllerListview ,
                      children: [
                        customImageCourse("${model.image}"),
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customTitleCourse(
                                cubit: cubit,
                                model: model,onPressedFavorite: () {
                               if (cubit.isFaforite==false) {
                                cubit.createFavorite();
                                cubit.changeFavorite();  
                               }else{
                                 cubit.deleteFavorite();
                                cubit.changeFavorite();
                               } 
                               
                              
                              },),
                              const SizedBox(
                                height: 10,
                              ),
                              customRowCategoriesWithReview(model: model),
                              const SizedBox(
                                height: 20,
                              ),
                              customRowPrice(model: model),
                              const SizedBox(
                                height: 20,
                              ),
                              customRowIconText(model: model),
                              const SizedBox(
                                height: 20,
                              ),
                              Divider(
                                color: AppColor.black,
                              ),
                              SizedBox(
                                  height: 40,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    controller: cubit.scrollController,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        key: cubit
                                            .tabKeys[index], // مفتاح لكل عنصر
                                        child: customTab(
                                          widthTab: cubit.registered ? 15 : 65,
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
                              const SizedBox(
                                height: 15,
                              ),
                              cubit.pagestabs[cubit.currentIndexTap]
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (cubit.currentIndexTap == 3)
                    ///////////
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Form(
                        key: cubit.formKey,
                        child: commentField(
                          cubit: cubit,
                          onChanged: (val) {
                            cubit.refreshTextFormField();
                          },
                          controller: cubit.commentCtrl,
                          context: context,
                          onSend: () {
                          
                             cubit.createQuestion() ;
                            
                          },
                        ),
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
