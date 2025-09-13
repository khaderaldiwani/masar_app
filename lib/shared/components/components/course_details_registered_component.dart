import 'package:flutter/material.dart';
import 'package:masar/link_api.dart';
import 'package:masar/model/announcements_model.dart';
import 'package:masar/model/assessments_model.dart';
import 'package:masar/model/attendances_model.dart';
import 'package:masar/model/question_model.dart';
import 'package:masar/module/course_details/cubit/course_details_cubit.dart';
import 'package:masar/module/course_details_registered/cubit/course_details_registered_cubit.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_images.dart';
import 'package:masar/shared/components/constant/app_route.dart';
import 'package:masar/shared/function/expanded_text.dart';
import 'package:masar/shared/network/local/cach_helper.dart';

Widget customTab(
    {required void Function()? onTap,
    required CourseDetailsRegisteredCubit cubit,
    required int index,
    required double widthTab}) {
  return InkWell(
    onTap: onTap,
    child: Container(
        clipBehavior: Clip.none,
        padding: EdgeInsets.only(left: widthTab, right: widthTab, bottom: 8),
        //   padding: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
            border: cubit.currentIndexTap == index
                ? BorderDirectional(
                    bottom: BorderSide(
                    width: 4,
                    color: AppColor.secaodColor,
                  ))
                : BorderDirectional(
                    bottom: BorderSide(
                    width: 2,
                    color: AppColor.grey,
                  ))),
        child: Text(
          cubit.tabs[index],
          style: TextStyle(
              color: index == cubit.currentIndexTap
                  ? AppColor.secaodColor
                  : AppColor.grey,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        )),
  );
}

Widget TableStudantMark({required List grades}) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: DataTable(
      border: TableBorder.all(color: Colors.grey),
      columns: const [
        DataColumn(label: Text('اسم المادة')),
        DataColumn(label: Text('العلامة')),
        DataColumn(label: Text('العلامة العظمى')),
        DataColumn(label: Text('ملاحظات')),
      ],
      rows: grades.map((grade) {
        return DataRow(
          cells: [
            DataCell(Text(grade['subject'] ?? '')),
            DataCell(Text('${grade['score']}')),
            DataCell(Text('${grade['maxScore']}')),
            DataCell(Text(grade['note'] ?? '')),
          ],
        );
      }).toList(),
    ),
  );
}

Widget CardStudantMark({required AssessmentsModel model }) {
  return Card(
    elevation: 3,
    color: AppColor.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.assignment, color: AppColor.secaodColor),
          ),
          const SizedBox(width: 16),

          // تفاصيل العلامة
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // نوع الاختبار

                defaultHeadTitle(
                  title: model.title ?? '',
                ),
                defaultBodyTitle(
                  title:"النوع: ${model.type ?? ''} " ,
                  color: AppColor.greyapp,
                  
                ),
                const SizedBox(height: 6),
                // العلامة و العظمى
                Row(
                  children: [
                    defaultBodyTitle(
                        title: "العلامة: ${model.grades![0].score}",
                        color: AppColor.greyapp),
                    const SizedBox(width: 16),
                    defaultBodyTitle(
                        title: "العظمى: ${model.maxScore}",
                        color: AppColor.grey),
                  ],
                ),
                const SizedBox(height: 6),
                // التاريخ

                defaultSmaleTitle(title: "📅 التاريخ: ${model.date}"),
                const SizedBox(height: 6),
                // الملاحظات

                defaultSmaleTitle(
                    title: "ملاحظات: ${model.grades![0].notes ?? ''}",
                    color: AppColor.grey,
                    bold: false),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
Widget CardStudantAttendancesTimeline({required AttendancesModel model, bool isLast = false}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // --- الخط العمودي مع الأيقونة ---
      Column(
        children: [
          // الأيقونة
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: model.status == "حاضر"
                  ? Colors.green
                  : Colors.redAccent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.assignment, size: 16, color: Colors.white),
          ),
          // الخط العمودي
          if (!isLast)
            Container(
              width: 2,
              height: 70,
              color: Colors.grey.withOpacity(0.4),
            ),
        ],
      ),
      const SizedBox(width: 12),

      // --- تفاصيل الحضور ---
      Expanded(
        child: Card(
          color: AppColor.white,
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // اسم المحاضرة
                defaultHeadTitle(title: model.lecture?.name ?? ''),

                const SizedBox(height: 6),

                // الحالة
                Row(
                  children: [
                    Icon(
                      model.status == "حاضر"
                          ? Icons.check_circle_outline
                          : Icons.cancel_outlined,
                      size: 18,
                      color: model.status == "حاضر"
                          ? Colors.green
                          : Colors.redAccent,
                    ),
                    const SizedBox(width: 6),
                    defaultBodyTitle(
                      title: "الحالة: ${model.status ?? ''}",
                      color: AppColor.greyapp,
                    ),
                  ],
                ),

                const Divider(height: 16, thickness: 0.8),

                // الملاحظات
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.note_alt_outlined,
                        size: 18, color: Colors.orange),
                    const SizedBox(width: 6),
                    Expanded(
                      child: defaultSmaleTitle(
                        title: "ملاحظات: ${model.notes ?? ''}",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

// Widget CardStudantAttendances({required AttendancesModel model }) {
//   return Card(
//     elevation: 3,
//     color: AppColor.white,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(15),
//     ),
//     child: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               color: Colors.blueAccent.withOpacity(0.2),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(Icons.assignment, color: AppColor.secaodColor),
//           ),
//           const SizedBox(width: 16),

//           // تفاصيل العلامة
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // نوع الاختبار

//                 defaultHeadTitle(
//                   title: model.lecture!.name ?? '',
//                 ),
//                 defaultBodyTitle(
//                   title:"الحالة: ${model.status ?? ''} " ,
//                   color: AppColor.greyapp,
                  
//                 ),
//                 const SizedBox(height: 6),
               
//                 defaultSmaleTitle(title: "ملاحظات: ${model.notes?? ''}"),
//                 const SizedBox(height: 6),
//                 // الملاحظات

                
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

Widget CustomCardNews({
     required BuildContext context, 
     
     required int index,
      required AnnouncementsModel model
    
    }){
  CourseDetailsCubit cubit = CourseDetailsCubit.get(context);

  return InkWell(
    onTap: () {
   //   cubit.toggleTextAnn(index);
   
    },
    child: Card(
      color: AppColor.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        // height:cubit.expanded?null:120,
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap:(){
              Navigator.pushNamed(context, AppRoute.TeacherProfile,arguments: "${model.teacher!.id}");
       
              } ,
              child: Container(
                width: 45,
                height: 45,
                decoration:  BoxDecoration(
                  image:  DecorationImage(
                      image:model.teacher!.image ==null?   AssetImage(AppImages.person)
                      :NetworkImage(LinkApi.images+model.teacher!.image!), 
                      fit: BoxFit.fill
                      ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  defaultBodyTitle(title: "${model.teacher!.firstName} ${model.teacher!.lastName}"),
                  // ExpandableMultiText(
                  //     index: index,
                  //     name:"Ann" ,
                  //     expandedList: cubit.expandedListAnn,
                  //     text: "${model.body}",
                  //     maxChars: 120,
                  //     cubit: cubit,
                  //     style: TextStyle(
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.bold,
                  //         color: AppColor.black)
                  //         )
                  
                      buildExpandableText("${model.body}", maxChars: 120,style:TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColor.black) )    
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildComment(
    {void Function()? onLongPress,
    required QuestionModel model,
    required CourseDetailsCubit cubit,
    required bool isThereReply,
    required int index,
    required void Function()? onTapReply
    }) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar(
        radius: 25,
        backgroundImage: model.student!.image != null
            ? NetworkImage(LinkApi.images + model.student!.image!)
            : AssetImage(AppImages.person),
      ),
      SizedBox(width: 5),
      Expanded(
        child: InkWell(
          onLongPress: onLongPress,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //  mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                color: AppColor.white,
                elevation: 3.0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defaultBodyTitle(
                        title:
                            "${model.student!.firstName} ${model.student!.lastName}",
                      ),
                      // ExpandableMultiText(
                      //   name: "Qeus",
                      //     index: index,
                      //     text: "${model.body}",
                      //     maxChars: 120,
                      //     cubit: cubit,
                      //     expandedList: cubit.expandedListQues,
                      //     style: TextStyle(
                      //         fontSize: 14,
                      //         fontWeight: FontWeight.bold,
                      //         color: AppColor.black)
                      //         ),
                              buildExpandableText("${model.body}", maxChars:120 ,style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black))
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),

                  InkWell(
                    onTap: onTapReply,
                      child: defaultSmaleTitle(
                          title: "رد", color: AppColor.secaodColor)
                      ),

                  // InkWell(child: defaultBodyTitle(title: "رد",color: AppColor.secaodColor)),
                ],
              ),
              SizedBox(
                height: 5,
              ),

              ////////////
              if (model.answers!.length != 0 &&
                  !cubit.isViewReplyList[index]) //isThereReply
                InkWell(
                  onTap: () {
                    cubit.showReply(index);
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        height: 2,
                        width: 30,
                        color: AppColor.greyButton,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          child: defaultSmaleTitle(
                              title: "عرض الردود", color: AppColor.greyapp)),
                    ],
                  ),
                ),

              ////////////
              if (isThereReply && cubit.isViewReplyList[index])
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: model.answers!.length,
                  separatorBuilder: (_, __) => SizedBox(height: 0),
                  itemBuilder: (context, index) {
                    return buildReply(
                      cubit: cubit,
                      model: model.answers![index],
                      onLongPress: () {
                  if (CachHelper.getString(key: "id") ==
                      "${model.answers![index].user!.id}") {
                    showModalBottomSheet(
                      context: context,
                      builder: (sheetContext) {
                        return buildDeleteUpdateQuestiont(
                          titleDelete: "حذف الإجابة",
                          titleUpdate: "تعديل الإجابة",
                          onTapDelete: () {
                          print("delete");
                          Navigator.of(sheetContext).pop();
                          cubit.deleteAnswer(
                              "${model.answers![index].id}", context);
                        }, 
                        onTapEdit: () {
                          print("update");
                          Navigator.of(sheetContext).pop();
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                            builder: (sheetContext) {
                                cubit.controllerEditAns.text =
                                    "${model.answers![index].body}";
                                return Form(
                                  key: cubit.formKeyEditAns,
                                  child: SizedBox(
                                    height: 800,
                                    child: buildUpdateQuestion(
                                        cubit: cubit,
                                        controller: cubit.controllerEditAns,
                                        onTapCancel: () {
                                          Navigator.of(sheetContext).pop();
                                        },
                                        onTapRefresh: () {
                                          cubit.updateAnswer(
                                            context,
                                              "${model.answers![index].id}"
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
                ),

              SizedBox(
                height: 10,
              ),

              if (isThereReply && cubit.isViewReplyList[index])
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 55),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        height: 2,
                        width: 30,
                        color: AppColor.greyButton,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          onTap: () {
                            cubit.showReply(index);
                          },
                          child: defaultSmaleTitle(
                              title: "اخفاء الردود", color: AppColor.greyapp)),
                    ],
                  ),
                ),
            ],
          ),
        ),
      )
    ],
  );
}

Widget buildReply({required CourseDetailsCubit cubit, required Answers model,void Function()? onLongPress}) {
  return Padding(
    padding: const EdgeInsetsDirectional.only(top: 10), //50
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundImage: model.user!.image != null
              ? NetworkImage(LinkApi.images + model.user!.image!)
              : AssetImage(AppImages.person),
        ),
        SizedBox(width: 5),
        Expanded(
          child: InkWell(
            onLongPress:onLongPress,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //  mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  color: AppColor.white,
                  elevation: 3.0,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        defaultBodyTitle(
                          title:
                              "${model.user!.firstName} ${model.user!.lastName}",
                        ),
                        // ExpandableText(
                        //     text: "${model.body}",
                        //     maxChars: 120,
                        //     cubit: cubit,
                        //     style: TextStyle(
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.bold,
                        //         color: AppColor.black)
                        //         )
                                buildExpandableText("${model.body}", maxChars: 120,style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColor.black)),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
            
                    // InkWell(child: defaultSmaleTitle(title: "رد",color: AppColor.secaodColor)),
                    if (model.isApproved!)
                      defaultBodyTitle(title: "تم التصديق", color: Colors.green),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildDeleteUpdateQuestiont({
  void Function()? onTapDelete,
  void Function()? onTapEdit,
  required String titleDelete,
  required String titleUpdate,
}) {
  return Container(
  width: double.infinity,
     color: AppColor.white,
    padding: EdgeInsets.all(20),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTapDelete,
          child: Row(
            children: [
              Icon(
                Icons.delete_outline_rounded,
                color: AppColor.black,
                size: 30,
              ),
              defaultBodyTitle(title:"${  titleDelete}" , color: AppColor.black)
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: onTapEdit,
          child: Row(
            children: [
              Icon(
                Icons.edit_outlined,
                color: AppColor.black,
                size: 30,
              ),
              defaultBodyTitle(title: "${  titleUpdate}", color: AppColor.black)
            ],
          ),
        )
      ],
    ),
  );
}

Widget customTextField(
    {required TextEditingController controller,
    required String? Function(String?)? validator,
    IconData? suffixIcon,
    void Function()? onPressedSuffex,
    required String hintText,
    bool? obscureText,
    TextInputType? keyboardType}) {
  return TextFormField(
    validator: validator,
    // maxLines: 5,
    minLines: 1, // يبدأ بثلاثة أسطر
    maxLines: 4,
    obscureText: obscureText ?? false,
    controller: controller,
    keyboardType: keyboardType,
    autofocus: true,
    style:  TextStyle(
    color: AppColor.black, // لون النص
    fontSize: 16,
  ),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        suffixIcon: obscureText != null
            ? IconButton(
                onPressed: onPressedSuffex,
                icon: Icon(
                    obscureText == true
                        ? Icons.remove_red_eye_rounded
                        : Icons.remove_red_eye_outlined,
                    color: AppColor.black))
            : null,
        fillColor: AppColor.greyLight, //AppColor.greyLight
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColor.grey,
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20))),
  );
}

Widget buildUpdateQuestion({required CourseDetailsCubit cubit,required void Function()? onTapCancel,required void Function()? onTapRefresh,required TextEditingController controller}) {
  return Container(
    color: AppColor.white,
    padding: EdgeInsets.all(10),
    height: 1200,
    width: double.infinity,
    child: Column(
      children: [
        defaultBodyTitle(title: "تعديل", color: AppColor.black),
        customDivider(color: AppColor.grey),
        SizedBox(height: 10),
        customTextField(
            keyboardType: TextInputType.multiline,
            controller: controller,
            
            validator: (val) {
              if (controller.text == "")
                return "لا يمكن أن يكون هذا الحقل فارغ";
              return null;
            },
            hintText: "تعديل "),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                width: 80,
                child: defaultButton(
                    title: "إلغاء",
                    onTap:onTapCancel,
                     isActiv: false)),
            SizedBox(
              width: 15,
            ),
            Container(
                width: 100,
                child: defaultButton(
                  title: "تحديث",
                  onTap: onTapRefresh,
                )),
          ],
        )
      ],
    ),
  );
}
Widget commentField({
  required TextEditingController controller,
  required void Function(String)? onChanged,
   VoidCallback? onSend,
   int maxLength=300,required BuildContext context}){
  final theme = Theme.of(context);
 
   return Directionality(
      textDirection: TextDirection.rtl, // دعم العربية
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        maxLength: maxLength,
        autofocus: true,
        style:  TextStyle(
    color: AppColor.black, // لون النص
    fontSize: 16,
  ),
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
         minLines: 1, // يبدأ بثلاثة أسطر
         maxLines: 2,
        validator: (v) {
          if (controller.text == "" ) 
          return 'الرجاء كتابة رد';
  
          return null;
        },
        decoration: InputDecoration(
          hintText: 'اكتب رد...',
          hintStyle: TextStyle(color: AppColor.grey),
          filled: true,
          fillColor:  AppColor.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          counterText: '', // اخفِ العداد إن لم ترغب بإظهاره
          prefixIcon: const Icon(Icons.mode_comment_outlined),
          suffixIcon: IconButton(
            tooltip: 'إرسال',
            onPressed: onSend,
            icon:  Icon(Icons.send,color:controller.text==""?AppColor.black:AppColor.primaryColor,),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: theme.dividerColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.6),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: theme.colorScheme.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: theme.colorScheme.error, width: 1.6),
          ),
        ),
      ),
    );
 
}
 