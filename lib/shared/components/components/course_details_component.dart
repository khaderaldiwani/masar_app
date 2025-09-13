import 'package:flutter/material.dart';
import 'package:masar/link_api.dart';
import 'package:masar/model/course_details_model.dart';
import 'package:masar/module/course_details/cubit/course_details_cubit.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';

import '../constant/app_images.dart';

Widget customImageCourse(String? image) {
  return Container(
    width: double.infinity,
    height: 250,
    decoration:  BoxDecoration(
        image:
            DecorationImage(image:
            image == null?
             AssetImage(AppImages.logo):
             NetworkImage(LinkApi.images+image)
             , 
             
             fit: BoxFit.fill)),
  );
}

Widget customTitleCourse({required CourseDetailsModel model,required void Function()? onPressedFavorite,required CourseDetailsCubit cubit}) {
  return Row(
    children: [
      Expanded(child: defaultHeadTitle(title: "${model.name}")),
      IconButton(
          iconSize: 35,
          padding: const EdgeInsetsDirectional.only(start: 20),
          onPressed: onPressedFavorite,
          icon:  Icon(!cubit.isFaforite ? Icons.bookmark_border
          :Icons.bookmark,
           color: AppColor.primaryColor)
          )
    ],
  );
}

Widget customRowCategoriesWithReview({required CourseDetailsModel model}) {
  return Row(
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          alignment: Alignment.center,
          child:
              defaultSmaleTitle(title: "${model.categoryName}", color: AppColor.blue),
          decoration: BoxDecoration(
            color: AppColor.thirdColor,
          ),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Expanded(
        child: Row(
          children: [
            const Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            Text(
              "${model.feedbacksAvgRating} (${model.feedbacksCount} مراجعة)",
              style: TextStyle(fontSize: 16, color: AppColor.black),
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget customRowPrice({required CourseDetailsModel model}) {
  return Row(
    children: [
      Text(
        model.discount==null? "\SYP. ${model.price}"
        :"\SYP. ${model.finalPrice}",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: AppColor.secaodColor,
        ),
      ),
      const SizedBox(
        width: 20,
      ),
     if(model.discount!=null) Stack(
        alignment: Alignment.center,
        children: [
          Text(
            "\SYP. ${model.price}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColor.grey,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 1.8,
                color: AppColor.black,
              ),
            ),
          ),
        ],
      )
      //  defaultSmaleTitle(title: "200 \$")
    ],
  );
}

Widget customRowIconText({required CourseDetailsModel model}) {
  return Row(
    children: [
      CustomIconText(icon: Icons.groups, title: "${model.numberOfStudents} طالب"),
      const Spacer(),
      CustomIconText(icon: Icons.watch_later, title: "${model.numberOfHours} ساعة"),
      const Spacer(),
      CustomIconText(icon: Icons.leaderboard_sharp, title: "${model.level}")
    ],
  );
}

Widget customTab(
    {required void Function()? onTap,
    required CourseDetailsCubit cubit,
    required int index,
    required double widthTab}) {
  return InkWell(
    onTap: onTap,
    child: Container(
        clipBehavior: Clip.none,
        padding: EdgeInsets.only(left: widthTab, right: widthTab, bottom: 0),
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

Widget commentField({
  required TextEditingController controller,
  required void Function(String)? onChanged,
   VoidCallback? onSend,
   required BuildContext context,
   required CourseDetailsCubit cubit
   }){
  final theme = Theme.of(context);
 
   return Directionality(
      textDirection: TextDirection.rtl, // دعم العربية
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        //maxLength: maxLength,
        // minLines:3 ,
        // maxLength: 4,
         minLines: 1, // يبدأ بثلاثة أسطر
        maxLines: 2,
        
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        validator: (v) {
          if (controller.text == "" ) 
          return 'لا بمكن أن يكون السؤال فارغ';
  
          return null;
        },
             style: TextStyle(
    color: AppColor.black, // لون النص
    fontSize: 16,
  ),
        decoration: InputDecoration(
          hintText: 'اكتب سؤال...',
          hintStyle: TextStyle(
    color: AppColor.grey, // لون النص
    fontSize: 16,
  ),
          filled: true,
    
          fillColor: AppColor.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          counterText: '', // اخفِ العداد إن لم ترغب بإظهاره
          prefixIcon: const Icon(Icons.mode_comment_outlined),
        
          suffixIcon: handlingLoading(
            statusRequest: cubit.statusRequest,
            widget: IconButton(
              tooltip: 'إرسال',
              onPressed: onSend,
              icon:  Icon(Icons.send,color:controller.text==""?AppColor.black:AppColor.primaryColor,),
            ),
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
 