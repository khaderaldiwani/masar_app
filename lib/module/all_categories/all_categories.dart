// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:masar/module/all_categories/cubit/all_categoris_cubit.dart';
// import 'package:masar/module/all_categories/cubit/all_categoris_state.dart';
// import 'package:masar/shared/class/handling_data_requst.dart';
// import 'package:masar/shared/components/components/categories_component.dart';
// import 'package:masar/shared/components/components/shared_component.dart';
// import 'package:masar/shared/components/constant/app_route.dart';

// class AllCategories extends StatelessWidget {
//   const AllCategories({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => AllCategoriesCubit()..getData(),
//       child: BlocBuilder<AllCategoriesCubit, AllCategoriesState>(
//         builder: (context, state) {
//           AllCategoriesCubit cubit = AllCategoriesCubit.get(context);

//           return Scaffold(
//               appBar: defaultAppbar(title: "كل التصنيفات", context: context),
//               body: HandlingDataRequst(
                
//                 statusRequest: cubit.statusRequest,
//                 textNodata: "لا يوجد تصنيفات \"لم يتم اضافة اي تصنيف بعد\"",
//                 widget: Container(
//                   padding: const EdgeInsets.all(15),
//                   child: ListView(
//                     children: [
//                       GridView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 childAspectRatio: 1.2,
//                                 mainAxisSpacing: 10.0,
//                                 crossAxisSpacing: 10.0),
//                         itemCount: cubit.categories.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return buildCategoriesSearchItem(
//                               onTap: () {
//                                 Navigator.pushNamed(
//                                   context,
//                                   AppRoute.courses,
//                                   arguments: index,
//                                 );
//                               },
//                               model: cubit.categories[index]);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ));
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:masar/module/all_categories/cubit/all_categoris_cubit.dart';
import 'package:masar/module/all_categories/cubit/all_categoris_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/categories_component.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_route.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllCategoriesCubit()..getData(),
      child: BlocBuilder<AllCategoriesCubit, AllCategoriesState>(
        builder: (context, state) {
          AllCategoriesCubit cubit = AllCategoriesCubit.get(context);

          return Scaffold(
            appBar: defaultAppbar(title: "كل التصنيفات", context: context),
            body: HandlingDataRequst(
              statusRequest: cubit.statusRequest,
              textNodata: "لا يوجد تصنيفات \"لم يتم اضافة اي تصنيف بعد\"",
              widget: Container(
                padding: const EdgeInsets.all(15),
                child: AnimationLimiter(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                    ),
                    itemCount: cubit.categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredGrid(
                        columnCount: 2,
                        position: index,
                        duration: const Duration(seconds: 20),
                        delay:const Duration(milliseconds: 400) ,
                        child: SlideAnimation(
                          verticalOffset: 200, // 👈 العناصر تجي من تحت
                          curve: Curves.easeOutCubic,
                          child: FadeInAnimation(
                            child: buildCategoriesSearchItem(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoute.courses,
                                  arguments: index,
                                );
                              },
                              model: cubit.categories[index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
