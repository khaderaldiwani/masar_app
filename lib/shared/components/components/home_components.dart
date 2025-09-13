import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/link_api.dart';
import 'package:masar/model/categories_model.dart';
import 'package:masar/model/top_courses_model.dart';
import 'package:masar/model/top_teachers_model.dart';
import 'package:masar/module/home/cubit/home_cubit.dart';
import 'package:masar/module/home/cubit/home_state.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_route.dart';
import '../constant/app_color.dart';
import '../constant/app_images.dart';

Widget customSearchHome({required void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        Expanded(
          child: Container(
            height: 50, //.h,
            margin: const EdgeInsets.all(10),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      enabled: false,
                      filled: true,
                      fillColor: AppColor.greyLight,
                      hintText: "بحث",
                      hintStyle: TextStyle(color: AppColor.grey),
                      prefixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                            color: AppColor.grey,
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                // PositionedDirectional(
                //     end: -3,
                //     child: CircleAvatar(
                //       radius: 25,
                //       child: IconButton(
                //           onPressed: () {},
                //           icon: Icon(
                //             Icons.filter_list_alt,
                //             size: 30,
                //             color: AppColor.white,
                //           )),
                //       backgroundColor: AppColor.blue,
                //     )
                //     )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget customAnnonPageView(HomeCubit cubit) {
  return BlocBuilder<HomeCubit, HomeState>(
    builder: (context, state) {
      return Center(
        child: Container(
          height: 150,
          width: 350,
          decoration: BoxDecoration(
            color: AppColor.greyLight,
            borderRadius: BorderRadius.circular(20),
          ),
          child: cubit.ads.isEmpty?
                  handlinNoData(
                    textNodata: "لا يوجد الاعلانات حالياً"
                  )
                  : PageView.builder(
            controller: cubit.pageController,
            onPageChanged: (val) {
              cubit.changeAnnoun(val);
              print("Val============");
              print(val);
            },
            itemCount: cubit.ads.length, //,//listOnboardingModel.length + 1
            itemBuilder: (context, index) {
              print("cubit.currentIndexAnnoun12");
              print(cubit.currentIndexAnnoun);
              int tempIndex = index;
              if (index >= cubit.ads.length) {
                tempIndex = 0;
              }
              return Container(
                decoration: BoxDecoration(
                    color: AppColor.greyLight,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(
                            "${LinkApi.images}${cubit.ads[cubit.currentIndexAnnoun].media}"
                            //     listOnboardingModel[cubit.currentIndexAnnoun].image!,//listOnboardingModel[cubit.currentIndexAnnoun].image!,
                            ),
                        fit: BoxFit.fill)),
              );
          
              //   buildContainerAds( cubit.ads[tempIndex]);//
            },
          ),
        ),
      );
    },
  );
}

Widget customAnimatedContainer(HomeCubit cubit) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ...List.generate(cubit.ads.length, (index) {
        return
            //   BlocBuilder<OnboardingCubit, OnboardingState>(
            //     builder: (context, state) {     return
            AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 8,
          width: index == cubit.currentIndexAnnoun ? 25 : 12,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
              color: index == cubit.currentIndexAnnoun
                  ? AppColor.primaryColor
                  : AppColor.grey,
              borderRadius: BorderRadius.circular(20)),
        );
        //    },
        //  );
      })
    ],
  );
}

// Widget customAnnonOld() {
//   return Container(
//     height: 200, //.h,
//     child: ListView.builder(
//       scrollDirection: Axis.horizontal,
//       shrinkWrap: true,
//       physics: const AlwaysScrollableScrollPhysics(),
//       itemCount: 3,
//       itemBuilder: (context, index) {
//         return Container(
//           width: 360, //.w,
//           height: 180, //.h,
//           margin: const EdgeInsets.symmetric(horizontal: 5),
//           decoration: BoxDecoration(
//               color: AppColor.primaryColor,
//               borderRadius: BorderRadius.circular(20)),
//           child: Stack(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: ListTile(
//                       title: Text(
//                         "Announcement Title",
//                         style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: AppColor.blue),
//                       ),
//                       subtitle: const Text(
//                         "Announcement bodyfsdfd Announcement body Announcement body",
//                         style: TextStyle(fontSize: 15, color: Colors.black),
//                       ),
//                     ),
//                   ),
//                   if (AppImages.Announcements != null)
//                     Expanded(
//                         flex: 1, child: Image.asset(AppImages.Announcements))
//                 ],
//               )
//             ],
//           ),
//         );
//       },
//     ),
//   );
// }

Widget customTitleHome(
    {required String title,
    required String endText,
    required void Function()? onTap}) {
  return Row(
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: 19, fontWeight: FontWeight.bold, color: AppColor.blue),
      ),
      const Spacer(),
      InkWell(
        onTap: onTap,
        child: Row(
          children: [
            defaultSmaleTitle(title: endText),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.grey,
              size: 20,
            )
          ],
        ),
      ),
    ],
  );
}

Widget buildTeacherItem(
    {required void Function()? onTap, required TopTeachersModel model}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColor.greyButton,
            backgroundImage:model.image==null? AssetImage(AppImages.person)
            :NetworkImage("${LinkApi.images}${model.image}")
            ,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "${model.firstName} ${model.lastName}",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}

Widget buildCategoryItem(
    {required CategoriesModel model, required void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 120,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            AppColor.primaryColor.withOpacity(0.15),
            AppColor.secaodColor.withOpacity(0.25),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ), 
            // BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     color: AppColor.greyButton
            //     ),

          ),
          Positioned(
            top: -20,
            child: CircleAvatar(
              radius: 33,
              backgroundColor: AppColor.white,
            ),
          ),
          Positioned(
            top: -18,
            child: CircleAvatar(
              radius: 30,
              backgroundImage: model.image != null
                  ? NetworkImage("${LinkApi.images}${model.image}")
                  : AssetImage(AppImages.logo),
              backgroundColor: AppColor.greyButton,
            ),
          ),
          Positioned(
              width: 100,
              top: 55,
              child: Text(
                "${model.name}",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              )),
        ],
      ),
    ),
  );
}

// Widget buildCategoryItem({
//   required CategoriesModel model,
//   required void Function()? onTap,
// }) {
//   return InkWell(
//     borderRadius: BorderRadius.circular(12),
//     onTap: onTap,
//     child: Container(
//       width: 110,
//       height: 110,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         gradient: LinearGradient(
//           colors: [
//             AppColor.primaryColor.withOpacity(0.15),
//             AppColor.secaodColor.withOpacity(0.25),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // صورة التصنيف
//           CircleAvatar(
//             radius: 28,
//             backgroundImage: model.image != null
//                 ? NetworkImage("${LinkApi.images}${model.image}")
//                 : AssetImage(AppImages.logo) as ImageProvider,
//             backgroundColor: AppColor.white,
//           ),
//           const SizedBox(height: 8),

//           // اسم التصنيف داخل الكارد
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 6),
//             child: Text(
//               model.name ?? "",
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//                 color: AppColor.primaryColor,
//               ),
//               textAlign: TextAlign.center,
//               overflow: TextOverflow.ellipsis,
//               maxLines: 2,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

Widget buildCategoryItemForAll(
    {required String text, required void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 120,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: 
             BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            AppColor.primaryColor.withOpacity(0.15),
            AppColor.secaodColor.withOpacity(0.25),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
 
          ),
          Positioned(
            top: -20,
            child: CircleAvatar(
              radius: 33,
              backgroundColor: AppColor.white,
            ),
          ),
          Positioned(
            top: -18,
            child: CircleAvatar(
                radius: 30,
                backgroundColor: AppColor.greyButton,
                child: Image.asset(AppImages.fire, height: 40)),
          ),
          Positioned(
              width: 100,
              top: 60,
              child: Text(
                "$text",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              )),
        ],
      ),
    ),
  );
}

// Widget buildCourseItem({required void Function()? onTap}) {
//   return InkWell(
//     onTap: onTap,
//     child: Container(
//       // margin: EdgeInsetsDirectional.only(end:10,bottom: 10 ),
//       height: 200,
//       decoration: BoxDecoration(
//           color: AppColor.white, borderRadius: BorderRadius.circular(10)),
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: 150,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     topRight: Radius.circular(10)),
//                 image: DecorationImage(
//                     image: AssetImage(AppImages.ui), fit: BoxFit.fill)),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Expanded(
//             child: Row(
//               children: [
//                 defaultBodyTitle(title: " Ui UX -"),
//                 Expanded(
//                   child: Text(
//                     "Graphics Design",
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                         color: AppColor.black),
//                     textAlign: TextAlign.center,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             children: [
//               Icon(Icons.play_lesson_outlined, color: AppColor.primaryColor),
//               Text(
//                 "24 درس",
//                 style: TextStyle(fontSize: 16, color: AppColor.black),
//                 textAlign: TextAlign.start,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Icon(
//                 Icons.star,
//                 color: Colors.yellow,
//               ),
//               Text(
//                 "4.5 (27 مراجعة)",
//                 style: TextStyle(fontSize: 16, color: AppColor.black),
//                 textAlign: TextAlign.start,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Text(
//                 "200,000 .SP",
//                 style: TextStyle(
//                     fontSize: 18,
//                     color: AppColor.secaodColor,
//                     fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               Spacer(),
//               IconButton(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.favorite_border_outlined,
//                     color: Colors.red,
//                   ))
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

Widget buildCourseDetails(
    {required BuildContext context, TopCoursesModel? model, void Function()? onPressed}) {
  return InkWell(
    onTap: (){
          Navigator.pushNamed(context, AppRoute.courseDetails,arguments: {"courseID": "${model.id}","is_enrolled": model.is_enrolled,});
              
    },
    child: Card(
      elevation: 4,
      color: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        //     height: 165,
        //         width: 145,
        padding: EdgeInsetsDirectional.only(end: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 140,
              alignment: Alignment.center,
              margin: EdgeInsetsDirectional.only(start: 7, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20),
                    bottomStart: Radius.circular(20),
                    topEnd: Radius.circular(20),
                    bottomEnd: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: NetworkImage("${LinkApi.images}${model!.image}"),
                    fit: BoxFit.fill,
                  )),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.greyLight),
                        child: Text(
                          "${model.categoryName}",
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: onPressed,
                          icon: Icon(
                             model.is_favorited ?? false ? Icons.bookmark
                             : Icons.bookmark_border,
                            color: AppColor.primaryColor,
                            size: 30,
                          )
                          ),
                      //SizedBox(width: 5,)
                    ],
                  ),
                  Text(
                    "${model.name}",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColor.blue),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColor.greyButton,
                        backgroundImage:
                        model.teacher!.image != null?
                         NetworkImage(LinkApi.images+model.teacher!.image!):
                         AssetImage(AppImages.person),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      
                          defaultSmaleTitle(title: "أ.${model.teacher!.firstName} ${model.teacher!.lastName}")
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person, color: AppColor.primaryColor),
                          Text(
                            "${model.numberOfStudents}ِ شخص",
                            style:
                                TextStyle(fontSize: 12, color: AppColor.grey),
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Text(
                            "${model.rating}",
                            style:
                                TextStyle(fontSize: 12, color: AppColor.grey),
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Widget buildCourseOngoingItemTest({required void Function()? onTap}) {
//   return InkWell(
//     onTap: onTap,
//     child: Card(
//       elevation: 4,
//       color: AppColor.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Container(
//         //     height: 165,
//         //         width: 145,
//         padding: EdgeInsetsDirectional.only(end: 5),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 150,
//               width: 140,
//               alignment: Alignment.center,
//               margin: EdgeInsetsDirectional.only(start: 7, top: 10, bottom: 10),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadiusDirectional.only(
//                     topStart: Radius.circular(20),
//                     bottomStart: Radius.circular(20),
//                     topEnd: Radius.circular(20),
//                     bottomEnd: Radius.circular(20),
//                   ),
//                   image: DecorationImage(
//                     image: AssetImage(AppImages.ui),
//                     fit: BoxFit.fill,
//                   )),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 10),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: AppColor.greyLight),
//                         child: Text(
//                           "لغات",
//                           style: TextStyle(
//                               fontSize: 12,
//                               color: AppColor.primaryColor,
//                               fontWeight: FontWeight.bold),
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                         ),
//                       ),
//                       Spacer(),
//                       IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.bookmark_border,
//                             color: AppColor.primaryColor,
//                             size: 30,
//                           )),
//                       //SizedBox(width: 5,)
//                     ],
//                   ),
//                   Text(
//                     "انكليزي",
//                     style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                         color: AppColor.blue),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 2,
//                   ),
//                   SizedBox(
//                     height: 4,
//                   ),
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 15,
//                         backgroundImage: AssetImage(AppImages.teacher),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Text("أ. خضر الديواني"),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 2,
//                   ),
//                   Row(
//                     children: [
//                       Row(
//                         children: [
//                           Icon(Icons.person, color: AppColor.primaryColor),
//                           Text(
//                             "25 طالب",
//                             style:
//                                 TextStyle(fontSize: 12, color: AppColor.grey),
//                             textAlign: TextAlign.start,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.star,
//                             color: Colors.yellow,
//                           ),
//                           Text(
//                             "4.5",
//                             style:
//                                 TextStyle(fontSize: 12, color: AppColor.grey),
//                             textAlign: TextAlign.start,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
