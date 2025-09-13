import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/course_details/cubit/course_details_cubit.dart';
import 'package:masar/module/course_details/cubit/course_details_state.dart';
import 'package:masar/shared/components/components/auth_component.dart';
import 'package:masar/shared/components/components/course_details_registered_component.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/function/function.dart';
import 'package:masar/shared/network/local/cach_helper.dart';

class Questions extends StatelessWidget {
  const Questions({super.key});

  @override
  Widget build(BuildContext context) {
   // String text =
   //     "يرجى مراجعة الدرس الثالث و الدرس الرابع يرجى مراجعة الدرس الثالث و الدرس الرابع يرجى مراجعة الدرس الثالث و الدرس الرابع يرجى مراجعة الدرس الثالث و الدرس الرابع يرجى مراجعة الدرس الثالث و الدرس الرابع  ";
   // String text2 = "السلام عليكم";
    bool isThereReply = true;
    CourseDetailsCubit cubit = CourseDetailsCubit.get(context);
//    cubit.question();

    return BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
      builder: (context, state) {
        return ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cubit.listQuestions.length,
          separatorBuilder: (_, __) => SizedBox(
            height: 10,
          ),
          itemBuilder: (context, index) {
            return buildComment(
                model: cubit.listQuestions[index],
                cubit: cubit,
                isThereReply: isThereReply,
                index: index,
                onTapReply: () {
                  showBottomSheet(
                    backgroundColor: AppColor.white,
                    context: context,
                    builder: (sheetContext) {
                      return Container(
                        color: AppColor.white,
                        height: 100,
                        child: ListView(children: [
                          SizedBox(height: 5),
                          Row(
                            children: [
                              defaultBodyTitle(
                                  title: "جارٍ الرد على ",
                                  bold: false,
                                  color: AppColor.black),
                              defaultBodyTitle(
                                  title:
                                      "${cubit.listQuestions[index].student!.firstName} ${cubit.listQuestions[index].student!.lastName}."),
                              InkWell(
                                onTap: () {
                                  cubit.controllercreateReply.clear();
                              
                                  Navigator.of(sheetContext).pop();
                                },
                                child: defaultBodyTitle(
                                    title: "  إلغاء", color: AppColor.greyapp),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Form(
                            key: cubit.formKeyCtreateReply,
                            child: commentField(
                                controller: cubit.controllercreateReply,
                                onChanged: (val) {
                                  cubit.refreshTextFormField();
                                },
                                onSend: () {
                                  // نفّذ الإرسال هنا
                                  cubit.createReply(context,"${cubit.listQuestions[index].id}",index);
                              
                                  Navigator.of(sheetContext).pop();
                                     
                                  
                                },
                                context: context),
                          ),
                        ]),
                      );
                    },
                  );
                },
                onLongPress: () {
                  if (CachHelper.getString(key: "id") ==
                      "${cubit.listQuestions[index].student!.id}") {
                    showModalBottomSheet(
                      context: context,
                      builder: (sheetContext) {
                        return buildDeleteUpdateQuestiont(
                          titleDelete: "حذف السؤال",
                          titleUpdate: "تعديل السؤال",
                          onTapDelete: () {
                          print("delete");
                          Navigator.of(sheetContext).pop();
                          cubit.deleteQuestion(
                              "${cubit.listQuestions[index].id}", context);
                        }, 
                        onTapEdit: () {
                          print("update");
                          Navigator.of(sheetContext).pop();
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                            builder: (sheetContext) {
                                cubit.controllerEditQues.text =
                                    "${cubit.listQuestions[index].body}";
                                return Form(
                                  key: cubit.formKeyEdit,
                                  child: SizedBox(
                                    height: 800,
                                    
                                    child: buildUpdateQuestion(
                                        cubit: cubit,
                                        controller: cubit.controllerEditQues,
                                        onTapCancel: () {
                                          Navigator.of(sheetContext).pop();
                                        },
                                        onTapRefresh: () {
                                          cubit.updateQuestion(
                                            context,
                                              "${cubit.listQuestions[index].id}"
                                              );
                                          Navigator.of(sheetContext).pop();
                                        
                                        }),
                                  ),
                                );
                              });
                        
                        }
                        );
                      },
                    );
                  }
                }
                );
          
          },
        );
      },
    );
  }
}
