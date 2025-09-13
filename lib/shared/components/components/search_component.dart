import 'dart:io';

import 'package:flutter/material.dart';
import 'package:masar/link_api.dart';
import 'package:masar/model/categories_model.dart';
import 'package:masar/model/top_courses_model.dart';
import 'package:masar/model/top_teachers_model.dart';
import 'package:masar/module/search/cubit/search_cubit.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_images.dart';
import 'package:masar/shared/components/constant/app_route.dart';

Widget customSearchField({
  required void Function()? onPressedFilter,
  required void Function(String)? onChanged
  }) {
  return Row(
    children: [
      Expanded(
        child: Container(
          height: 50, //.h,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              TextFormField(
                autofocus: true,
                 style: TextStyle(
    color: AppColor.black, // لون النص
    fontSize: 16,
  ),
                cursorColor:  AppColor.primaryColor,
                onChanged:onChanged ,
                
                decoration: InputDecoration(
                    filled: true,
                    focusColor: AppColor.primaryColor,
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.primaryColor,width: 2),borderRadius: BorderRadius.circular(22)),
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
                        borderRadius: BorderRadius.circular(22))),
              ),
              PositionedDirectional(
                  end: 0,
                  child: CircleAvatar(
                    radius: 25,
                    child: IconButton(
                        onPressed: onPressedFilter,
                        icon: Icon(
                          Icons.filter_list,
                          size: 30,
                          color: AppColor.white,
                        )),
                    backgroundColor: AppColor.primaryColor,
                  ))
            ],
          ),
        ),
      ),
    ],
  );
}

Widget itemSearchRegistry({required String title}) {
  return Container(
      height: 50,
      padding: EdgeInsets.all(4),
      //   margin: EdgeInsetsDirectional.only(end: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.greyLight,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          defaultBodyTitle(title: title, color: AppColor.greyapp),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.cancel_outlined,
                size: 25,
              ))
        ],
      ));
}

Widget buildCategoriesSearchItem({required void Function()? onTap,required CategoriesModel model}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 80,
      //  width: 150,
      // margin: EdgeInsetsDirectional.only(end:10,bottom: 10 ),
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        //   mainAxisSize: MainAxisSize.max,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image:model.image==null? 
                    AssetImage(AppImages.logo)
                    :NetworkImage(LinkApi.images+model.image!)
                    , fit: BoxFit.fill)),
          ),
          Container(
            width: double.infinity,
            height: 40, // ارتفاع الزر
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.9),
                  const Color.fromARGB(160, 0, 0, 0),
                  const Color.fromARGB(90, 0, 0, 0),
                  const Color.fromARGB(40, 0, 0, 0),
                  const Color.fromARGB(0, 0, 0, 0),
                ],
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: defaultBodyTitle(
                    title: "${model.name}", color: Colors.white),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget buildFilterSearch({required SearchCubit cubit}) {
  return StatefulBuilder(
    builder: (context, setModalState) {
      return SizedBox(
        height: 320,

        width: double.infinity,
        child: Container(
          color: AppColor.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(child: defaultHeadTitle(title: "فلترة البحث")),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: defaultBodyTitle(title: "المستوى"),
              ),
              buildRadioGroup(
                groupValue: cubit.level,
                onChanged: (val) {
                  cubit.changeLevel(val!);
                  setModalState(() {}); // إعادة بناء الراديوات
                },
                title1: "مبتدئ",
                val1: "1",//starter
                title2: "متوسط",
                val2: "2",//average
                title3: "متقدم",
                val3: "3",//advance
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: defaultBodyTitle(title: "المدة "),
              ),
              buildRadioGroup(
                groupValue: cubit.time,
                onChanged: (val) {
                  cubit.changeTime(val!);
                  setModalState(() {});
                },
                title1: "1ساعة",
                val1: "1",
                title2: "1-4 ساعة",
                val2: "1-4",
                title3: "+4 ساعة",
                val3: "+4",
              ),
              const SizedBox(
                height: 10,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //   child: defaultBodyTitle(title: "بشهادة"),
              // ),
              // buildRadioGroup(
              //   groupValue: cubit.certificate,
              //   onChanged: (val) {
              //     cubit.selectCertificate(val!);
              //     setModalState(() {});
              //   },
              //   title1: "الكل",
              //   val1: "all",
              //   title2: "نعم",
              //   val2: "yes",
              //   title3: "لا",
              //   val3: "no",
              // ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: defaultButton(
                    title: "تطبيق التغييرات",
                    onTap: () {
                      cubit.getData(cubit.search);
                      Navigator.of(context).pop();
                    },
                  ))
            ],
          ),
        ),
      );
    },
  );
}

Widget buildRadioGroup({
  required String groupValue,
  required void Function(String?)? onChanged,
  required String title1,
  required String val1,
  required String title2,
  required String val2,
  required String title3,
  required String val3,
}) {
  return Row(
    children: [
      SizedBox(
        //height: 100,
        width: 142,
        child: RadioListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text(title1,style:TextStyle(color: AppColor.black) ,),
            value: val1,
            groupValue: groupValue,
            onChanged: onChanged, 
            
            ),
      ),
      SizedBox(
        //  height:100 ,
        width: 125,
        child: RadioListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 1),
            title: Text(title2,style:TextStyle(color: AppColor.black) ,),
            value: val2,
            groupValue: groupValue,
            onChanged: onChanged),
      ),
      SizedBox(
        //  height: 100,
        width: 144,
        child: RadioListTile(
            title: Text(title3,style:TextStyle(color: AppColor.black) ,),
            value: val3,
            groupValue: groupValue,
            onChanged: onChanged),
      ),
    ],
  );
}

Widget buildButtonOrderBy({required String title,required void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
        height: 35,
        padding: EdgeInsets.all(4),
        //   margin: EdgeInsetsDirectional.only(end: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:AppColor.greyLight,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            defaultBodyTitle(title: title, color: AppColor.greyapp),
            Icon(
                  Icons.filter_list_outlined,
                  size: 25,
                color: AppColor.grey,
                )
          ],
        )),
  );
}
Widget buildCourseItemResult({required BuildContext context,required TopCoursesModel model}) {
  return InkWell(
    onTap: (){
          Navigator.pushNamed(context, AppRoute.courseDetails,arguments: "${model.id}");
                  
    },
    child: Card(
      color: AppColor.white,
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
              margin: EdgeInsetsDirectional.only(start: 7,top: 10,bottom: 10),
              decoration:  BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20),
                    bottomStart: Radius.circular(20),
                    topEnd: Radius.circular(20),
                    bottomEnd: Radius.circular(20),
                  ),
                  image: DecorationImage(
                      image:model.image==null? AssetImage(AppImages.logo)
                      :NetworkImage(LinkApi.images+model.image!)
                      ,
                      
                       fit: BoxFit.fill,)),
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
                          color: AppColor.greyLight
                        ),
                        child: Text(
                          "${model.categoryName}",
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold
                              ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Spacer(),
                          IconButton(
                          onPressed: () {},
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
                  SizedBox(height: 4,),
                   Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColor.greyButton,
                        backgroundImage:
                        model.teacher!.image != null?
                         NetworkImage(LinkApi.images+"/"+model.teacher!.image!):
                         AssetImage(AppImages.person),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      
                          defaultSmaleTitle(title: "أ.${model.teacher!.firstName} ${model.teacher!.lastName}")
                    ],
                  ),
                 
                  SizedBox(height: 2,),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person,
                              color: AppColor.primaryColor),
                          Text(
                            "شخص ${model.numberOfStudents}",
                            style: TextStyle(fontSize: 12, color: AppColor.grey),
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(width: 5,),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Text(
                            "${model.rating}",
                            style: TextStyle(fontSize: 12, color: AppColor.grey),
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

Widget buildOrderBySearch({required SearchCubit cubit}) {
  return StatefulBuilder(
    builder: (context, setModalState) {
      return SizedBox(
        height: 350,
        width: double.infinity,
        child: Container(
          color: AppColor.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(child: defaultHeadTitle(title: "ترتيب حسب")),
              
              buildRadioGroupVertical(
                groupValue: cubit.orderBy,
                onChanged: (val) {
                  cubit.changeOrderBy(val!);
                  setModalState(() {}); // إعادة بناء الراديوات
                },
                title1:"الأحدث" ,
                val1:"newest" ,
                title2: "الأقدم",
                val2:"oldest" ,
                title3:"الأقل تقييماً" ,
                val3:"lowest_rating",
                title4: "الأعلى تقييماً",
                val4: "highest_rating",
                
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: defaultButton(
                    title: "تطبيق التغييرات",
                    onTap: () {
                      cubit.getData(cubit.search);
                      Navigator.of(context).pop();
                    },
                  ))
            ],
          ),
        ),
      );
    },
  );
}

Widget buildRadioGroupVertical({
  required String groupValue,
  required void Function(String?)? onChanged,
  required String title1,
  required String val1,
  required String title2,
  required String val2,
  required String title3,
  required String val3,
  required String title4,
  required String val4,
  
}) {
  return Column(
    children: [
      RadioListTile(
          title: Text(title1,style:TextStyle(color: AppColor.black) ,),
          value: val1,
          groupValue: groupValue,
          onChanged: onChanged),
      RadioListTile(
          title: Text(title2,style:TextStyle(color: AppColor.black) ,),
          value: val2,
          groupValue: groupValue,
          onChanged: onChanged),
      RadioListTile(
          title: Text(title3,style:TextStyle(color: AppColor.black) ,),
          value: val3,
          groupValue: groupValue,
          onChanged: onChanged),
      RadioListTile(
          title: Text(title4,style:TextStyle(color: AppColor.black) ,),
          value: val4,
          groupValue: groupValue,
          onChanged: onChanged),
      
    ],
  );
}
