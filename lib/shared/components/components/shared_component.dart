import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:masar/module/course_details/cubit/course_details_cubit.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_images.dart';
import 'package:masar/shared/components/constant/app_lottie.dart';
import 'package:masar/shared/network/remote/status_requst.dart';
import 'package:rating_dialog/rating_dialog.dart';

Widget logo(){
  return Image.asset(AppImages.logo,width: 150,height: 150,);
}
Widget customAppbarLeading(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(6),
    child: CircleAvatar(
      backgroundColor: AppColor.white,
      child: IconButton(
          color: AppColor.blue,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
          )),
    ),
  );
}

Widget defaultButton(
    {required String title,
    required void Function()? onTap,
    bool isActiv = true}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      height: 40,
      decoration: BoxDecoration(
          color: isActiv ? AppColor.primaryColor : AppColor.white,
          borderRadius: BorderRadius.circular(20)),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: isActiv ?  AppColor.white:AppColor.blue ),
      ),
    ),
  );
}

Widget buildProgresBar({
  required double completedLessons,
  required double totalLessons,
}) {
  double progress = completedLessons / totalLessons;

  return Row(
    children: [
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
          ),
        ),
      ),
      
    ],
  );
}

Widget defaultHeadTitle({required String title,Color? color,int maxline=2,TextAlign? textAlign=TextAlign.start}) {
  return Text(
    title,
    maxLines:maxline,
    overflow: TextOverflow.ellipsis,
    textAlign: textAlign,
    style: TextStyle(
        fontSize: 21, fontWeight: FontWeight.bold,  color:color==null? AppColor.blue:color),
  );
}

Widget defaultSmaleTitle({int maxLine=2,required String title,Color? color,bool bold=true}) {
  return Text(
    title,
    style: TextStyle(
        fontSize: 14,
         fontWeight:bold? FontWeight.bold:FontWeight.normal,
         color:color==null? AppColor.grey:color
        
         ),
          maxLines: maxLine,
    overflow: TextOverflow.ellipsis,
  );
}

  Widget defaultBodyTitle({int maxLine=2,bool bold=true,required String title,Color? color,TextAlign textAlign=TextAlign.start}) {
  return Text(
   title,
    style: TextStyle(
        fontSize: 17,
         fontWeight:bold? FontWeight.bold:FontWeight.normal,
        color:color==null? AppColor.blue:color),
    textAlign:textAlign ,
    maxLines: maxLine,
    overflow: TextOverflow.ellipsis,
  );
}

AppBar defaultAppbar( {required String title,required BuildContext context}){
  return AppBar(
              title: Text(title, maxLines: 1,
                   overflow: TextOverflow.ellipsis,
  ),
              leading: Container(
                margin: EdgeInsetsDirectional.only(start: 10),
                child: CircleAvatar(
                  radius: 10,
                  child: IconButton(
                    onPressed:(){
                     Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                    color: AppColor.blue,
                  ),
                  backgroundColor: AppColor.greyLight,
                ),
              ),
            );
}
AppBar defaultAppbarWithAction( {
  required String title,
  required BuildContext context,
  required void Function()? onSearch
  }){
  return AppBar(
              title: Text(title, maxLines: 1,
                   overflow: TextOverflow.ellipsis,
  ),
              leading: Container(
                margin: EdgeInsetsDirectional.only(start: 10),
                child: CircleAvatar(
                  radius: 10,
                  child: IconButton(
                    onPressed:(){
                     Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                    color: AppColor.blue,
                  ),
                  backgroundColor: AppColor.greyLight,
                ),
              ),
              actions: [
                IconButton(onPressed:onSearch , icon:Icon(Icons.search) )
              ],
            );
}

Widget CustomIconText({required IconData icon,required String title , Color? color}){
  return Row(
             children: [
              Icon(icon,color:color==null?AppColor.secaodColor: color,),
              SizedBox(width: 5,),
               Text(
                        title,
    
                        style:TextStyle(
                                      fontSize: 16,
                                      color: AppColor.black
                                      ) ,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                               ),
             ],
           );
}
Widget customDivider({bool padding=true,Color? color,}) {

  return Padding(
    padding: padding? EdgeInsets.symmetric(horizontal: 15):EdgeInsets.symmetric(horizontal: 0),
    child: Divider(color:color==null? AppColor.scaffoldColor:color, thickness: 2),
  );
}

Widget ExpandableText(
    {required String text,
    TextStyle? style,
    int maxChars = 200,
    required CourseDetailsCubit cubit,
    
    }) {
  final showFullText = cubit.expanded || text.length <= maxChars;

  final visibleText =
      showFullText ? text : text.substring(0, maxChars) + '... ';

  return RichText(
    text: TextSpan(
      // style: TextStyle(color: Colors.black, fontSize: 16),
      children: [
        TextSpan(
          text: visibleText,
          style:style==null? TextStyle(
              fontSize: 16,
              color: AppColor.greyapp,
              fontWeight: FontWeight.bold):style,
        ),
        if (text.length > maxChars)
          TextSpan(
            text: cubit.expanded ? ' عرض الأقل ' : ' عرض المزيد',
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {
                cubit.showText();
              },
          ),
      ],
    ),
  );
}
// Widget ExpandableMultiText(
//     {required String text,
//     TextStyle? style,
//     int maxChars = 200,
//     required CourseDetailsCubit cubit,
//     required int index,
//     required List<bool> expandedList,
//     required String name,
//     }) {
//   final showFullText = expandedList[index] || text.length <= maxChars;

//   final visibleText =
//       showFullText ? text : text.substring(0, maxChars) + '... ';

//   return RichText(
//     text: TextSpan(
//       // style: TextStyle(color: Colors.black, fontSize: 16),
//       children: [
//         TextSpan(
//           text: visibleText,
//           style:style==null? TextStyle(
//               fontSize: 16,
//               color: AppColor.greyapp,
//               fontWeight: FontWeight.bold):style,
//         ),
//         if (text.length > maxChars)
//           TextSpan(
//             text: expandedList[index] ? ' عرض الأقل ' : ' عرض المزيد',
//             style: const TextStyle(
//               color: Colors.blue,
//               fontWeight: FontWeight.bold,
//             ),
//             recognizer: TapGestureRecognizer()..onTap = () {
//              name=="Ques"? cubit.toggleTextQues(index):cubit.toggleTextAnn(index);
//               },
//           ),
//       ],
//     ),
//   );
// }
Widget Rating({required dynamic Function(RatingDialogResponse) onSubmitted}){
  return RatingDialog(
                          
                    initialRating: 1.0,
                    
                        image: Image.asset(AppImages.logo,height: 150,width: 150,), //const FlutterLogo(size: 100),
                    title: Text(
                      'تقييم الكورس',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    message: Text(
                      "انقر على نجمة لتعيين تقييمك. أضف المزيد من الوصف هنا إذا أردت.",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 15),
                    ),
                    onCancelled: () => print('cancelled'),
                    
                    submitButtonText: 'ارسال',
                 //   submitButtonTextStyle: TextStyle(color: AppColor.primaryColor),
                    commentHint: 'أضف مراجعة',
                    
                    onSubmitted: onSubmitted,
                    //  (response) {
                    //   print('rating: ${response.rating}, comment: ${response.comment}');

                    // },
                  );
  
}

Widget handlinNoData({bool noDataLottie=true,String? textNodata}){
  return Center(child: Stack(
    clipBehavior: Clip.none,
  alignment: Alignment.bottomCenter,
    children: [
   if(noDataLottie) Positioned(
    bottom:-20 ,
    child: Lottie.asset(AppLottie.nodata,width: 250,height: 250)),
      Positioned(
        bottom: 10,
        child: defaultBodyTitle(title: textNodata?? "لا يوجد بيانات ",color: AppColor.grey))
    ],
  ));
}
Widget handlingLoading({required StatusRequest statusRequest,required Widget widget}){
  return statusRequest==StatusRequest.loading?
               Container(
                 
               height: 40,
               width: 120,
               margin: EdgeInsetsDirectional.only(start: 20),
                 child: Lottie.asset(AppLottie.loadingSec,width: 200,height: 200)
                 )
 :widget;
}